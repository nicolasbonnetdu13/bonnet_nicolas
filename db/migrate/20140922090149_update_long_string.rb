class UpdateLongString < ActiveRecord::Migration
  def change
    change_column :posts, :description, :text, :limit => 4294967295
    change_column :comments, :comment, :text, :limit => 4294967295
  end
end
