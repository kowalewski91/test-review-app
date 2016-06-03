#require 'platform-api'

class CreateHerokuForkService
  def initialize(branch_name, staging_name)
    @branch_name = branch_name
    @staging_name = staging_name
  end

  def call
    #response = @heroku.app.info('pure-waters-89036')
    #addons = @heroku.addon.list_by_app('pure-waters-89036')

    fork
  end

  private

  def fork
    exec("heroku fork --from #{@staging_name} --to #{@branch_name}")
  end
end
