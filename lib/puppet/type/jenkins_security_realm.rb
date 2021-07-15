require_relative '../../puppet/x/jenkins/type/cli'

Puppet::X::Jenkins::Type::Cli.newtype(:jenkins_security_realm) do
  @doc = "Manage Jenkins' security realm"

  ensurable

  newparam(:name) do
    desc 'Name of the security realm class'
    isnamevar
  end

  newproperty(:arguments, array_matching: :all) do
    desc 'List of arguments to security realm class constructor'

    def insync?(is)
      is_insync = true
      reason = ''

      is.each.with_index do |val, index|
        item_is_not_insync = false
        if val == :undef
          item_is_not_insync = true if should[index].class != NilClass
          reason = 'undef/nil'
        elsif should[index].class == String && should[index].start_with?('Boolean:')
          item_is_not_insync = true if should[index].gsub(%r{Boolean:}, '') != val.to_s
          reason = 'Boolean'
        elsif val != should[index]
          item_is_not_insync = true
          reason = 'N-EQ'
        end

        debug("Type jenkins_security_realm. Arguments NOT insync? Index: #{index} - is: '#{val}' - should: '#{should[index]}' - reason: #{reason}") if item_is_not_insync
        is_insync = false if item_is_not_insync
      end

      is_insync
    end
  end

  # require all instances of jenkins_user, as does
  # jenkins_authorization_strategy, to ensure that the state of jenkins_user
  # resources is not attempted to be modify between jenkins_security_realm and
  # jenkins_authorization_strategy state changes.
  autorequire(:jenkins_user) do
    catalog.resources.select do |r|
      r.is_a?(Puppet::Type.type(:jenkins_user))
    end
  end

  autorequire(:jenkins_authorization_strategy) do
    if self[:ensure] == :absent
      catalog.resources.select do |r|
        r.is_a?(Puppet::Type.type(:jenkins_authorization_strategy))
      end
    end
  end
end # Puppet::X::Jenkins::Type::Cli.newtype
