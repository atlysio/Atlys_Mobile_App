module AtlysMobileApp
  class Engine < ::Rails::Engine
    isolate_namespace AtlysMobileApp

    initializer "atlys_mobile_app", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount AtlysMobileApp::Engine, at: "/"
      end
    end
end
end
