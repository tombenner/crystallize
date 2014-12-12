require 'fileutils'

module Crystallize
  class Creator
    def initialize
      @settings_manager = SettingsManager.new
      @gem_name = ARGV.shift
      @gem_dir = "#{Dir.pwd}/#{@gem_name}"
    end

    def run
      @settings = @settings_manager.get
      if @gem_name.nil? || @gem_name.empty?
        puts "Please specify a gem name:\ncrystallize my_gem"
        return
      end
      if @gem_name == 'settings'
        @settings_manager.write
        return
      end

      FileUtils.rm_rf(@gem_dir)
      FileUtils.cp_r("#{Crystallize.dir}/gem_name", @gem_dir)

      Dir.chdir(@gem_dir) do
        rename_files
        replace_tokens
      end

      Dir.chdir("#{@gem_dir}/lib") do
        rename_files
      end
      Dir.chdir(@gem_dir) do
        `git init && git add . && git commit -m 'Initial commit'`
      end

      puts "Created gem in ./#{@gem_name}"
    end

    private

    def replace_tokens
      token_values = get_token_values
      Dir.glob('**/*').each do |name|
        next unless File.file?(name)
        content = File.read(name)
        token_values.each do |token, value|
          content.gsub!("{{#{token}}}", value)
        end
        File.write(name, content)
      end
    end

    def get_token_values
      gem_name_camelized = @gem_name.split('_').map { |word| word.capitalize }.join
      {
        :gem_name => @gem_name,
        :gem_name_camelized => gem_name_camelized,
        :settings_name => @settings['name'],
        :settings_email => @settings['email'],
        :settings_github_username => @settings['github_username'],
        :year => Time.now.year.to_s
      }
    end

    def rename_files
      %x[for f in *gem_name*; do mv "$f" "`echo $f | sed s/gem_name/#{@gem_name}/`"; done]
    end
  end
end
