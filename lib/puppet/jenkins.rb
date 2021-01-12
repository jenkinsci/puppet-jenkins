require 'etc'

module Puppet
  module Jenkins
    # @return [String] Full path to the Jenkins user's home directory
    def self.home_dir
      return Etc.getpwnam('jenkins').dir
    rescue ArgumentError
      # The Jenkins user doesn't exist!
      return '/var/lib/jenkins'
    end

    # @return [String] Full path to the Jenkins user's plugin directory
    def self.plugins_dir
      File.join(home_dir, 'plugins')
    end
  end
end
