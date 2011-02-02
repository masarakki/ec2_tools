require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ec2Tools::Config do
  describe "#initialize" do
    before do
      @conf = Ec2Tools::Config.new(:access_key => 'aaa',
        :secret_key => 'bbb',
        :server => 'ccc')
    end
    
    it "set access_key_id" do
      @conf.access_key_id.should eq('aaa')
    end
    it "set secret_access_key" do
      @conf.secret_access_key.should eq('bbb')
    end
    it "set server" do
      @conf.server.should eq('ccc')
    end
  end
  
  describe ".load" do
    context "file not found" do
      it "raise FileNotFoundError" do
        lambda{
          Ec2Tools::Config.load('unkounkounko')
        }.should raise_error(Ec2Tools::Config::FileNotFoundError)
      end
    end
    context "with filename" do
      it "load from specified file" do
        conf = mock(Ec2Tools::Config)
        File.stub(:exists?) { true }
        Ec2Tools::Config.should_not_receive(:search_config_file)
        YAML.should_receive(:load_file).with('config/hoge.yml') { {:hoge => 'hage'} }
        Ec2Tools::Config.should_receive(:new).with(:hoge => 'hage') { conf }
        Ec2Tools::Config.load('config/hoge.yml').should eq(conf)
      end
    end
    
    context "without filename" do
      it "search default config file" do
        conf = mock(Ec2Tools::Config)
        File.stub(:exists?) { true }
        Ec2Tools::Config.should_receive(:search_config_file) { 'config/amazon_ec2.yml' }
        YAML.should_receive(:load_file).with('config/amazon_ec2.yml') { {:hoge => 'hige'} }
        Ec2Tools::Config.should_receive(:new).with(:hoge => 'hige') { conf }
        Ec2Tools::Config.load.should eq(conf)
      end
    end
  end
  
  describe ".search_config_file" do
    it "search files by order" do
      File.should_receive(:exists?).with("config/amazon_ec2.yml").ordered { false }
      File.should_receive(:exists?).with(".account.yml").ordered { true }
      Ec2Tools::Config.send(:search_config_file).should eq(".account.yml")
    end
    it "raise FileNotFoundError if no file exists" do
      File.stub(:exists?) { false }
      lambda{
        Ec2Tools::Config.send(:search_config_file)
      }.should raise_error(Ec2Tools::Config::FileNotFoundError)
    end
  end
end
