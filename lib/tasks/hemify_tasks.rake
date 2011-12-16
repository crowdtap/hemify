require 'hemify/builder'

namespace :hemify do
  desc "Generate assets from hem projects listed in package.json"
  task :generate do
    Hemify::Builder.generate
  end
end
