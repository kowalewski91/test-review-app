class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|
      t.string :github_link, null: false
      t.string :project_name,  null: false
      t.timestamps null: false
    end
  end
end
