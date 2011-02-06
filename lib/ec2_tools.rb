class Ec2Tools
  autoload :EC2, 'ec2_tools/ec2'
  autoload :Config, 'ec2_tools/config'
  
  @ec2 = nil
  
  def initialize(config_file = nil)
    @ec2 = EC2.new(Config.load(config_file))
  end
  
  def method_missing(name, *args)
    self.class.send(:define_method, name) do |*x|
      @ec2.send(name, *x)
    end
    @ec2.send(name, *args)
  end
  
  def inspect
    "#<Ec2Tools>"
  end
end
