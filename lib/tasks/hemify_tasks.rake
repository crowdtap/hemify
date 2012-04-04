require 'hemify/builder'

namespace :hemify do
  desc "Generate assets from hem projects listed in package.json"
  task :generate do
    package = ENV["PACKAGE"]
    if package.nil?
      raise "PACKAGE needs to be set"
    end
    Hemify::Builder.generate(package)
  end
end
