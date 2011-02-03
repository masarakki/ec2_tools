require 'AWS'

class Ec2Tools::EC2 < AWS::EC2::Base
  def initialize(config)
    @config = config
  end
end
