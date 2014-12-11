require 'fileutils'

module Crystallize
  class Creator
    def initialize
      args = ARGV
      @gem_name = args.shift
      if @gem_name.nil?
        puts "Please specify a gem name:\ncrystallize my_gem" and return
      end
    end

    def run
      gem_dir = "#{Dir.pwd}/#{@gem_name}"
      FileUtils.rm_rf(gem_dir)
      FileUtils.cp_r("#{Crystallize.dir}/gem_name", gem_dir)
      gem_name_camelized = @gem_name.split('_').map { |word| word.capitalize }.join
      Dir.chdir(gem_dir) do
        rename_files
        Dir.glob('**/*').each do |name|
          next unless File.file?(name)
          content = File.read(name)
          content.gsub!('gem_name', @gem_name)
          content.gsub!('GemName', gem_name_camelized)
          File.write(name, content)
        end
      end
      Dir.chdir("#{gem_dir}/lib") do
        rename_files
      end
      Dir.chdir(gem_dir) do
        `git init && git add . && git commit -m 'Initial commit'`
      end
      puts "Created gem in ./#{@gem_name}"
    end

    def rename_files
      %x[for f in *gem_name*; do mv "$f" "`echo $f | sed s/gem_name/#{@gem_name}/`"; done]
    end
  end
end
