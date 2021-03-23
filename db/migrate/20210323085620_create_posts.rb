class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string     :title,                 null: false
      t.text       :overview,              null: false
      t.text       :programming_languages, null: false
      t.text       :text,                  null: false
      t.string     :portfolio_url,         null: false
      t.string     :github_url,            null: false
      t.references :user,                  foreign_key: true
      t.timestamps
    end
  end
end
