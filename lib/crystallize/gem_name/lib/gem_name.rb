directory = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{directory}/{{gem_name}}/*.rb") { |file| require file }

module {{gem_name_camelized}}
end
