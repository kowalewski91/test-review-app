json.array!(@deploys) do |deploy|
  json.extract! deploy, :id
  json.url deploy_url(deploy, format: :json)
end
