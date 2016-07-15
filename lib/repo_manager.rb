class RepoManager
  def initialize(repo_name)
    @repo_name = repo_name
  #   TODO: make checkups about the repo, ensure that there is a git folder
  end

  def checkout(branch_name)
    within_repo do
      system "git checkout -b #{branch_name} origin/#{branch_name}"
    end

    raise StandardError.new('Problem with checkout') if $?.exitstatus != 0

    true
  end

  def push(branch_name, git_url)
    # TODO: check whether the name is there or not, if yes then remove it
    # TODO: also the app should be removed
    fetch_all
    remote_name =  branch_name

    within_repo do
      system "git remote add #{remote_name} #{git_url}"
      system "git push #{branch_name} #{remote_name}:master"
      system "git remote remove #{remote_name}"
    end

    true
  end

  def fetch_all
    within_repo do
      system "git fetch --all"
    end
  end

  def within_repo
    Dir.chdir(Rails.root.join('public', 'projects', "#{@repo_name}")) do
      yield
    end
  end
end
