module Crystallize
  def self.dir
    "#{File.dirname(File.absolute_path(__FILE__))}/crystallize"
  end
end

Dir.glob("#{Crystallize.dir}/*.rb") { |file| require file }
