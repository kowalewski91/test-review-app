class CreateControllers < ActiveRecord::Migration
  def change
    create_table :controllers do |t|
      t.string :Deploy

      t.timestamps null: false
    end
  end
end
