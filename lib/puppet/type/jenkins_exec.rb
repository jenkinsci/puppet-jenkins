require 'puppet_x/jenkins/type/cli'

PuppetX::Jenkins::Type::Cli.newtype(:jenkins_exec) do
  @doc = 'Execute groovy script on jenkins master'

  newparam(:script) do
    desc 'script name'
    isnamevar

    validate do |script|
      raise ArgumentError, "Script must be a String, got value of class #{script.class}" unless script.is_a? String
    end
  end

  newproperty(:returns, :array_matching => :all, :event => :executed_script) do |property|
    include Puppet::Util::Execution
    munge do |value|
      value.to_s
    end

    def event_name
      :executed_script
    end

    defaultto '0'

    attr_reader :output
    desc "The expected exit code(s).  An error will be returned if the
      executed command has some other exit code.  Defaults to 0. Can be
      specified as an array of acceptable exit codes or a single value.

      On POSIX systems, exit codes are always integers between 0 and 255.

      On Windows, **most** exit codes should be integers between 0
      and 2147483647.

      Larger exit codes on Windows can behave inconsistently across different
      tools. The Win32 APIs define exit codes as 32-bit unsigned integers, but
      both the cmd.exe shell and the .NET runtime cast them to signed
      integers. This means some tools will report negative numbers for exit
      codes above 2147483647. (For example, cmd.exe reports 4294967295 as -1.)
      Since Puppet uses the plain Win32 APIs, it will report the very large
      number instead of the negative number, which might not be what you
      expect if you got the exit code from a cmd.exe session.

      Microsoft recommends against using negative/very large exit codes, and
      you should avoid them when possible. To convert a negative exit code to
      the positive one Puppet will use, add it to 4294967296."

    # Make output a bit prettier
    def change_to_s(currentvalue, newvalue)
      'executed successfully'
    end

    # First verify that all of our checks pass.
    def retrieve
      # We need to return :notrun to trigger evaluation; when that isn't
      # true, we *LIE* about what happened and return a "success" for the
      # value, which causes us to be treated as in_sync?, which means we
      # don't actually execute anything.  I think. --daniel 2011-03-10
      #if @resource.check_all_attributes
      return :notrun
      #else
      #  return self.should
      #end
    end

    # Actually execute the command.
    def sync
      event = :executed_script
      tries = self.resource[:tries]
      try_sleep = self.resource[:try_sleep]

      begin
        tries.times do |try|
          # Only add debug messages for tries > 1 to reduce log spam.
          debug("Exec try #{try+1}/#{tries}") if tries > 1
          @status = provider.run(self.resource[:script])
          @output = @status
          break if self.should.include?(@status.exitstatus.to_s)
          if try_sleep > 0 and tries > 1
            debug("Sleeping for #{try_sleep} seconds between tries")
            sleep try_sleep
          end
        end
      rescue Timeout::Error
        self.fail Puppet::Error, 'Script exceeded timeout', $!
      end

      if log = @resource[:logoutput]
        case log
        when :true
          log = @resource[:loglevel]
        when :on_failure
          unless self.should.include?(@status.exitstatus.to_s)
            log = @resource[:loglevel]
          else
            log = :false
          end
        end
        unless log == :false
          @output.split(/\n/).each { |line|
            self.send(log, line)
          }
        end
      end

      unless self.should.include?(@status.exitstatus.to_s)
        self.fail("#{self.resource[:script]} returned #{@status.exitstatus} instead of one of [#{self.should.join(",")}]")
      end

      event
    end
  end

  newparam(:logoutput) do
    desc "Whether to log command output in addition to logging the
      exit code.  Defaults to `on_failure`, which only logs the output
      when the command has an exit code that does not match any value
      specified by the `returns` attribute. As with any resource type,
      the log level can be controlled with the `loglevel` metaparameter."

    defaultto :on_failure

    newvalues(:true, :false, :on_failure)
  end

  newparam(:tries) do
    desc "The number of times execution of the command should be tried.
      Defaults to '1'. This many attempts will be made to execute
      the command until an acceptable return code is returned.
      Note that the timeout parameter applies to each try rather than
      to the complete set of tries."

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[\d]+$/
          raise ArgumentError, 'Tries must be an integer'
        end
        value = Integer(value)
      end
      raise ArgumentError, 'Tries must be an integer >= 1' if value < 1
      value
    end

    defaultto 1
  end

  newparam(:try_sleep) do
    desc 'The time to sleep in seconds between \'tries\'.'

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[-\d.]+$/
          raise ArgumentError, 'try_sleep must be a number'
        end
        value = Float(value)
      end
      raise ArgumentError, 'try_sleep cannot be a negative number' if value < 0
      value
    end

    defaultto 0
  end

  # require all authentication & authorization related types
  [
    :jenkins_user,
    :jenkins_security_realm,
    :jenkins_authorization_strategy,
  ].each do |type|
    autorequire(type) do
      catalog.resources.find_all do |r|
        r.is_a?(Puppet::Type.type(type))
      end
    end
  end
end # PuppetX::Jenkins::Type::Cli.newtype
