class CreateNotes < ActiveRecord::Migration[5.2]
  
  def up
    create_table :notes do |t|
      t.string :title
      t.string :content
      t.datetime :completion_date
      t.integer :user_id
      t.timestamp

    end
  end

  def down
    drop_table :notes
  end

end
