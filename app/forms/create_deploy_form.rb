class CreateDeployForm
  include ActiveModel::Model

  attr_accessor(
    :github_link,
    :username,
    :repository_name
  )

  def attributes
    {
      github_link: github_link,
      username: username,
      repository_name: repository_name
    }
  end
end
