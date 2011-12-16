module Hemify

  class Builder
    def self.generate
      source = ''
      FileUtils.cd Rails.root do
        `rm -rf node_modules` if Dir.exists? "node_modules"
        `npm install`
        FileUtils.cd "node_modules" do
          Dir.glob("*").each do |project|
            FileUtils.cd project do
              `hem build`
              `cp public/application.js #{Rails.root}/vendor/assets/javascripts/#{project}.js`
              `cp public/application.css #{Rails.root}/vendor/assets/stylesheets/#{project}.css`
              `rm -rf #{Rails.root}/vendor/assets/images/#{project}`
              `mkdir -p #{Rails.root}/vendor/assets/images/#{project}`
              `cp public/#{project}/* #{Rails.root}/vendor/assets/images/#{project}`
            end
          end
        end
      end
    end
  end

end
