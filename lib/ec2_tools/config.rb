module Ec2Tools::Config
  class FileNotFoundError < StandardError ; end
  class InvalidConfigError < StandardError ; end
  require 'yaml'
  attr_reader :access_key_id, :secret_access_key, :server
  
  def self.load(file = nil)
    file = search_config_file if file.nil?
    raise  FileNotFoundError unless File.exists?(file)
    data = YAML.load_file(file)
    
    raise InvalidConfigError.new("config file must contain key, secret, server") unless valid_config?(data)
    
    { :access_key_id => data['key'],
      :secret_access_key => data['secret'],
      :server => data['server'] }
  end
  
  private
  def self.search_config_file
    ["config/amazon_ec2.yml", ".account.yml"].each do |file|
      return file if File.exists?(file)
    end
    raise FileNotFoundError
  end
  
  def self.valid_config?(data)
    data.has_key?('key') && data.has_key?('secret') && data.has_key?('server')
  end
end
