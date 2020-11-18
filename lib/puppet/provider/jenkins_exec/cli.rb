require 'puppet_x/jenkins/util'
require 'puppet_x/jenkins/provider/cli'

Puppet::Type.type(:jenkins_exec).provide(:cli, :parent => PuppetX::Jenkins::Provider::Cli) do
  class << self
    undef :prefetch
    undef :instances
  end

  def run(script)
    cli(['groovy', '='], :stdin => script)
  end
end
