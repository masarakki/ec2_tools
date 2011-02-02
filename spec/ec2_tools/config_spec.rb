require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ec2Tools::Config do
  describe ".load" do
    context "with filename" do
    end
    
    context "without filename" do
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
