# == Schema Information
#
# Table name: listings
#
#  id         :bigint           not null, primary key
#  body       :text
#  expires_on :date
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#
class Listing < ApplicationRecord
  belongs_to :board, class_name: "Board", foreign_key: "board_id"

  validates :title, presence: true
  validates :body, presence: true
  validates :expires_on, presence: true
  validates :board_id, presence: true
end
