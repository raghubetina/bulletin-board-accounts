class AddUserIdToBoards < ActiveRecord::Migration[8.0]
  def change
    add_column :boards, :user_id, :integer
  end
end
