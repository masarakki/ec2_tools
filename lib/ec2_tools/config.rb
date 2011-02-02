class Ec2Tools::Config
  class FileNotFoundError < StandardError ; end
  require 'yaml'
  attr_reader :access_key_id, :secret_access_key, :server
  
  def initialize(options = {})
    @access_key_id = options[:access_key] || ''
    @secret_access_key = options[:secret_key] || ''
    @server = options[:server] || ''
  end
  
  def self.load(file = nil)
    file = search_config_file if file.nil?
    raise  FileNotFoundError unless File.exists?(file)
    data = YAML.load_file(file)
    new(data)
  end
  
  private
  def self.search_config_file
    ["config/amazon_ec2.yml", ".account.yml"].each do |file|
      return file if File.exists?(file)
    end
    raise FileNotFoundError
  end
end
