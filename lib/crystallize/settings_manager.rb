require 'pathname'
require 'yaml'

module Crystallize
  class SettingsManager
    def get
      read || write
    end

    def write
      puts "Welcome to Crystallize!\nPlease enter some settings for your gems:"
      settings = prompt_settings
      settings['version'] = Crystallize::VERSION
      File.open(path, 'w') do |file|
        YAML.dump(settings, file)
      end
      puts "Thanks! Saved your settings in ~/.crystallize.yml"
      settings
    end

    def read
      return nil unless File.exist?(path)
      settings = YAML.load_file(path)
      return nil unless settings && settings['name'] && settings['email'] && settings['github_username']
      settings
    end

    private

    def prompt_settings
      settings = {}
      settings['name'] = prompt_setting('name')
      settings['email'] = prompt_setting('email')
      settings['github_username'] = prompt_setting('GitHub username')
      settings
    end

    def prompt_setting(name)
      print "Your #{name}: "
      value = nil
      loop do
        value = gets.chomp
        break if !value.empty?
        puts "Please enter your #{name}!"
      end
      value
    end

    def path
      @path ||= Pathname.new(`echo ~`.strip).join('.crystallize.yml')
    end
  end
end
