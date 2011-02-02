module Ec2Tools::Config
  class FileNotFoundError < StandardError ; end
  class InvalidConfigError < StandardError ; end
  require 'yaml'
  attr_reader :access_key_id, :secret_access_key, :server
  
  def self.load(file = nil)
    file = search_config_file if file.nil?
    raise  FileNotFoundError unless File.exists?(file)
    data = YAML.load_file(file)
    return data if data.is_a?(Hash) && 
      data.has_key?(:access_key_id) &&
      data.has_key?(:secret_access_key) &&
      data.has_key?(:server)
    
    raise InvalidConfigError.new("config file must contain access_key_id, secret_access_key, server")
  end
  
  private
  def self.search_config_file
    ["config/amazon_ec2.yml", ".account.yml"].each do |file|
      return file if File.exists?(file)
    end
    raise FileNotFoundError
  end
end
