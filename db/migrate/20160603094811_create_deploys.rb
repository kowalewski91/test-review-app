class CreateDeploys < ActiveRecord::Migration
  def change
    create_table :deploys do |t|

      t.timestamps null: false
    end
  end
end
