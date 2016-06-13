#require 'platform-api'

class CreateDeployService
  def initialize(form)
    @form = form
  end

  def call
    Deploy.create(@form.attributes)
    Dir.chdir("/home/jarek/Desktop/repos") do
      system "git clone #{@form.github_link}"
    end
  end
end
