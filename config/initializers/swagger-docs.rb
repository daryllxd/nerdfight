# config/initializers/swagger-docs.rb
Swagger::Docs::Config.register_apis({
  "1.0" => {
  # location where our api doc files will be generated, as of now we will store files under public directory
  :api_file_path => "public/",
  # base path url of our application
  # while using production mode, point it to production url
  :base_path => "http://localhost:3000",
  :camelize_model_properties => false,
  # setting this option true tells swagger to clean all files generated in api_file_path directory before any files are generated
  :clean_directory => true,
  # As we are using Rails-API, our ApplicationController inherits ActionController::API instead of ActionController::Base
  # Hence, we need to add ActionController::API instead of default ActionController::Base
  :base_api_controller => ApiController,
  # parent_controller needs to be specified if API controllers are inheriting some other controller than ApplicationController
  # :parent_controller => ApplicationController,
  :attributes => {
  :info => {
  "title" => "Nerdfight",
  "description" => "Nerdfight",
  "contact" => "sourcepad@gmail.com",
  "license" => "Apache 2.0",
  "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
}
}
}
})
