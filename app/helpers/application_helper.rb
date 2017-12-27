module ApplicationHelper

  def post_resource(resource, params)
    uri = "#{ENV['API_BASE_URL']}/#{resource}"
    response = RestClient::Resource.new(uri)
    response.post(params.to_json, session[:auth_headers])
  end

  def put_resource(resource, params)
    uri = "#{ENV['API_BASE_URL']}/#{resource}/#{params[:id]}"
    response = RestClient::Resource.new(uri)
    response.put(params.to_json, session[:auth_headers])
  end

  def delete_resource(resource, params)
    uri = "#{ENV['API_BASE_URL']}/#{resource}/#{params[:id]}"
    response = RestClient::Resource.new(uri)
    response.delete(session[:auth_headers])
  end

  def get_resources(resource, term = '')
    uri = "#{ENV['API_BASE_URL']}/#{resource}"

    headers = session[:auth_headers]
    headers['params'] = {term: term}
    response = RestClient.get(uri, headers)
    JSON.parse(response.body, :symbolize_names => true)
  end

  def get_resource(resource, params)
    uri = "#{ENV['API_BASE_URL']}/#{resource}/#{params[:id]}"
    response = RestClient::Resource.new(uri).get(session[:auth_headers])
    JSON.parse(response.body, :symbolize_names => true)
  end

  def get_collection(hash)
    hash[:data] || []
  end

  def get_attribute_value_from(hash, key)
    hash = hash.key?(:data) ? hash[:data] : hash
    return hash[key] if hash.key?(key)
    hash = hash.key?(:attributes) ? hash[:attributes] : hash
    value = hash.key?(key) ? hash[key] : '...'
    value.instance_of?(String) ? value.capitalize : value
  end

  def get_relationship_attribute_value_from(hash, relation, key)
    hash = hash.key?(:data) ? hash[:data] : hash
    hash = hash.key?(:relationships) ? hash[:relationships] : hash
    hash = hash.key?(relation) ? hash[relation] : hash
    hash = hash.key?(:data) ? hash[:data] : hash
    value = hash.key?(key) ? hash[key] : '...'
    value.instance_of?(String) ? value.capitalize : value
  end

  def get_relationship_from(hash, relation)
    hash = hash.key?(:data) ? hash[:data] : hash
    hash = hash.key?(:relationships) ? hash[:relationships] : hash
    hash = hash.key?(relation) ? hash[relation] : hash
    hash.key?(:data) ? hash[:data] : []
  end

  def flash_success(action)
    { success: t(action, scope: [:message]) }
  end

  def flash_errors(errors)
    full_msg = "<ul>"
    JSON.parse(errors, :symbolize_names => true).each do |msg|
      full_msg << "<li>#{msg}</li>"
    end
    full_msg << "</ul>"
    flash.now[:error] = full_msg
  end
end
