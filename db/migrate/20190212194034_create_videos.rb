class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :titulo
      t.string :url
      t.integer  :views, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
