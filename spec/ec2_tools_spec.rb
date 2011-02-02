require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ec2Tools do
  describe "#initialize" do
    it "create config and set as @config" do
      conf = mock(Ec2Tools::Config)
      Ec2Tools::Config.should_receive(:load).with(nil) { conf }
      Ec2Tools.new.instance_variable_get(:@config).should eq(conf)
    end
    
    it "create config from specified file and set as @config" do
      conf = mock(Ec2Tools::Config)
      Ec2Tools::Config.should_receive(:load).with('config/hoge.yml') { conf }
      Ec2Tools.new('config/hoge.yml').
        instance_variable_get(:@config).should eq(conf)
    end
  end
  
  # et.keys
  # et.servers(:key).map(:private_ip)
end
