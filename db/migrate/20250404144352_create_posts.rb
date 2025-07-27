# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.2]
  def up
    create_table :posts do |t|
      t.string :titulo
      t.string :descricao
          
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
