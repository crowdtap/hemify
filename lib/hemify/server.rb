require 'execjs'

module Hemify
  class Server
    def initialize(type)
      raise ArgumentError unless [:css,:js].include? type

      @type = type
    end

    def call(env)
      @source = ''
      FileUtils.cd Rails.root do
        if Dir.exists? "node_modules"
          FileUtils.cd "node_modules" do
            Dir.glob("*").each do |project|
              FileUtils.cd project do
                `hem build` unless File.exists? "public/application.#{@type.to_s}"
                @source << File.open("public/application.#{@type.to_s}").read
              end
            end
          end
        end
      end

      case @type
      when :js
        content_type = "text/javascript"
      when :css
        content_type = "text/css"
      end
      [200, {"Content-Type" => content_type}, [@source]]
    end
  end
end
