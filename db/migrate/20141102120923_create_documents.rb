class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :x
      t.integer :y

      t.timestamps
    end
  end
end
