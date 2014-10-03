class Swagger::Docs::Config
  def self.base_api_controller
    Api::ApiController
  end
end

Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    api_extension_type: :json,
    # the output location where your .json files are written to
    api_file_path: "public/api/",
    # the URL base path to your API
    base_path: "http://staging-businesslunch.herokuapp.com",
    # if you want to delete all .json files at each generation
    clean_directory: true
  }
})
