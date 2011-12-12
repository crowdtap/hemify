module Hemify

  class Generator
    def self.generate(type)
      raise ArgumentError unless [:css,:js].include? type
      type_str = type.to_s

      source = ''
      FileUtils.cd Rails.root do
        `rm -rf node_modules` if Dir.exists? "node_modules"
        `npm install`
        FileUtils.cd "node_modules" do
          Dir.glob("*").each do |project|
            FileUtils.cd project do
              `hem build` unless File.exists? "public/application.#{type_str}"
              source << File.open("public/application.#{type_str}").read
            end
          end
        end
        File.open("vendor/assets/javascripts/external.#{type_str}",'w') do |f|
          f.puts source
        end
      end
    end
  end

end
