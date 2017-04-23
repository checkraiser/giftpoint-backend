Apipie.configure do |config|
  config.app_name                = "BackendNgan"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  #config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
  config.authenticate = Proc.new do
	require_login
  end
end
