class AddTechsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :techs, :text, null: false
  end
end
