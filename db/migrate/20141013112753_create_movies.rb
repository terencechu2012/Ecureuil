class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :studio
      t.integer :rotten
      t.integer :audience
      t.string :story
      t.string :genre
      t.integer :numtheatres
      t.integer :boxaverage
      t.decimal :domesticgross, :precision => 10, :scale => 3
      t.decimal :foreigngross, :precision => 10, :scale => 3
      t.decimal :worldwidegross, :precision => 10, :scale => 3
      t.decimal :budget, :precision => 10, :scale => 3
      t.decimal :profitability, :precision => 10, :scale => 6
      t.decimal :openingweekend, :precision => 10, :scale => 3

      t.timestamps
    end
  end
end
