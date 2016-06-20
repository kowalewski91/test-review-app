class DeploysController < ApplicationController
  before_action :set_deploy, only: [:show, :edit, :update, :destroy, :deploy_repository, :fetch_repository]

  def index
    @repos = Deploy.all
    #@repos = Github::Client::Repos.new
  end

  def show
    @repo = Rugged::Repository.new(Rails.root.join('public', 'projects', "#{@deploy.project_name}").to_s)
  end

  def new
    @form = CreateDeployForm.new
  end

  def edit
  end

  def create
    @form = CreateDeployForm.new(deploy_form_params)
    service = CreateDeployService.new(@form)

    if service.call

      redirect_to deploys_path
    else
      render :new
    end
  end

  def deploy_repository
    app_name =params[:branch_name] + '-' + @deploy.project_name
    Dir.chdir(Rails.root.join('public', 'projects', "#{@deploy.project_name}")) do
      system "git checkout -b #{params[:branch_name]} origin/#{params[:branch_name]}"
      system "heroku fork --from #{@deploy.project_name} --to #{app_name}"
      system "git remote add #{params[:branch_name]} https://git.heroku.com/#{app_name}.git"
      system "git push #{params[:branch_name]} #{params[:branch_name]}:master"
      system "heroku run rake db:migrate"
      system "git remote remove #{params[:branch_name]}"
    end
    redirect_to deploy_path(@deploy.id)
  end

  def fetch_repository
     Dir.chdir(Rails.root.join('public', 'projects', "#{@deploy.project_name}")) do
       system "git fetch --all"
     end
     redirect_to deploy_path(@deploy.id)
  end

  def update
    respond_to do |format|
      if @deploy.update(deploy_params)
        format.html { redirect_to @deploy, notice: 'Deploy was successfully updated.' }
        format.json { render :show, status: :ok, location: @deploy }
      else
        format.html { render :edit }
        format.json { render json: @deploy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deploy.destroy
    respond_to do |format|
      format.html { redirect_to deploys_url, notice: 'Deploy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deploy
      @deploy = Deploy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deploy_params
      params.fetch(:deploy, {})
    end

    def deploy_form_params
      params.require(:deploy_form).permit(:github_link, :project_name)
    end

end
