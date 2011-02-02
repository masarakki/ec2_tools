require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ec2Tools::Config do
  describe ".load" do
    before do
      @config = {
        :access_key_id => 'hage',
        :secret_access_key => 'hige',
        :server => 'huga'
      }
    end

    context "file not found" do
      it "raise FileNotFoundError" do
        lambda{
          Ec2Tools::Config.load('unkounkounko')
        }.should raise_error(Ec2Tools::Config::FileNotFoundError)
      end
    end
    
    context "invalid config" do
      it "raise InvalidConfigError" do
        File.stub(:exists?) { true }
        Ec2Tools::Config.stub(:search_config_file) { 'ec2.yml' }
        YAML.stub(:load_file) { {:hoge => "huga"} }
        lambda{
          Ec2Tools::Config.load
        }.should raise_error(Ec2Tools::Config::InvalidConfigError)
      end
    end
    
    context "with filename" do
      it "load from specified file" do
        File.stub(:exists?) { true }
        Ec2Tools::Config.should_not_receive(:search_config_file)
        YAML.should_receive(:load_file).with('config/hoge.yml') { @config }
        Ec2Tools::Config.load('config/hoge.yml').should eq(@config)
      end
    end
    
    context "without filename" do
      it "search default config file" do
        File.stub(:exists?) { true }
        Ec2Tools::Config.should_receive(:search_config_file) { 'config/amazon_ec2.yml' }
        YAML.should_receive(:load_file).with('config/amazon_ec2.yml') { @config }
        Ec2Tools::Config.load.should eq(@config)
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
