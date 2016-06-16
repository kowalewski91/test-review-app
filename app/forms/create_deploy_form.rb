class CreateDeployForm
  include ActiveModel::Model

  attr_accessor(
    :github_link,
    :project_name
  )

  def attributes
    {
      github_link: github_link,
      project_name: project_name
    }
  end
end
