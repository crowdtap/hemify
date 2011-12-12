require 'hemify/generator'

namespace :hemify do
  desc "Generate assets from hem projects listed in package.json"
  task :generate do
    Hemify::Generator.generate(:js)
    Hemify::Generator.generate(:css)
  end
end
