class HerokuManager
  def initialize(repo_manager)
    @repo_manager = repo_manager
  end

  def fork(app_name, target_app_name)
    @repo_manager.within_repo do
      system "heroku fork --from #{app_name} --to #{target_app_name}"
    end

    app_name = 'fasfasf' #TODO: get the app name after fork

    return app_name
  end

  def db_migrate(app_name)
    @repo_manager.within_repo do
      system "heroku rake db:migrate --app #{app_name}"
    end
  end

  def self.all_apps
    []
  end

  def self.app_url(app_name)
    "https://git.heroku.com/#{app_name}.git"
  end
end
