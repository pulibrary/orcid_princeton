class AddUniversityIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :university_id, :string
  end
end
