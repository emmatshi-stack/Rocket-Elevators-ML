class CreateProfileIds < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_ids do |t|
      t.int :id
      t.string :name

      t.timestamps
    end
  end
end
