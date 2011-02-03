require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ec2Tools do
  describe "#initialize" do
    before do
      @conf = { :hoge => 'hage' }
    end
    it "load config and create ec2 instance with config" do
      ec2 = mock(Ec2Tools::EC2)
      Ec2Tools::Config.should_receive(:load) { @conf }
      Ec2Tools::EC2.should_receive(:new).with(@conf) { ec2 }
      Ec2Tools.new.instance_variable_get(:@ec2).should eq(ec2)
    end
  end
  
  # et.keys
  # et.servers(:key).map(:private_ip)
end
