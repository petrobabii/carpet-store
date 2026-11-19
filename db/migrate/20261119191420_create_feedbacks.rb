class CreateFeedbacks < ActiveRecord::Migration[8.1]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: true, foreign_key: true
      t.string :last_name
      t.string :first_name
      t.string :phone
      t.text :message
      t.text :admin_reply
      t.datetime :replied_at

      t.timestamps
    end
  end
end
