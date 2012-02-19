class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.text :description
      t.boolean :active
      t.timestamps
    end
  end
end
