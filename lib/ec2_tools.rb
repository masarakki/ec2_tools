class Ec2Tools
  autoload :EC2, 'ec2_tools/ec2'
  autoload :Config, 'ec2_tools/config'
  
  @ec2 = nil
  
  def initialize(config_file = nil)
    @ec2 = EC2.new(Config.load(config_file))
  end
end
