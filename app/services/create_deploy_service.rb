#require 'platform-api'

class CreateDeployService
  def initialize(form)
    @form = form
  end

  def call
    Deploy.create(@form.attributes)
    Dir.chdir("/home/czarek/Desktop/repos") do
      system "git clone #{@form.github_link}"
    end
  end

  private

  def fork

    #system "heroku fork --from #{@staging_name} --to #{@branch_name}"
    #system 'git remote add userprofile2 https://git.heroku.com/userprofile2.git'
    #system 'git push userprofile2 userprofile:master'
  end
end
