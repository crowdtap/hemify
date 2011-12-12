module Hemify

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/hemify_tasks.rake'
    end
  end

end
