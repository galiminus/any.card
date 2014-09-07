class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.string :from
      t.string :tags
      t.string :materials
      t.integer :min_partners
      t.integer :grade

      t.timestamps
    end
  end
end
