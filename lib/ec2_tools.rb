class Ec2Tools
  autoload :EC2, 'ec2_tools/ec2'
  autoload :Config, 'ec2_tools/config'
  
  @config = nil
  
  def initialize(config_file = nil)
    @config = Config.load(config_file)
  end
end
