require 'grape-swagger'

class API < Grape::API
 
  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
      error_code: 404,
      error_message: e.message
      }.to_json, 404).finish
  end
 
  rescue_from :all do |e|
    Rack::Response.new({
      error_code: 500,
      error_message: e.message
      }.to_json, 500).finish
  end
 
  mount Music::Store
  add_swagger_documentation(
    api_version: "v1",
    hide_documentation_path: true,
    mount_path: "/api/v1/swagger_doc",
    hide_format: true
  )

end


