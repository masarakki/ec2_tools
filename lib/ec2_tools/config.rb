module Ec2Tools::Config
  class FileNotFoundError < StandardError ; end
  
  attr_reader :access_key_id, :secret_access_key, :server
  
  def self.load(file = '')
    
  end
  
  private
  def self.search_config_file
    ["config/amazon_ec2.yml", ".account.yml"].each do |file|
      return file if File.exists?(file)
    end
    raise FileNotFoundError
  end
end
