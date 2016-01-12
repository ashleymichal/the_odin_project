class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.text :content
    	t.references :members, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
