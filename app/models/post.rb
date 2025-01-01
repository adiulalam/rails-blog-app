# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  is_draft   :boolean          default(TRUE), not null
#
class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :user

  validates :title, presence: true
  validates :user_id, presence: true

  scope :draft, -> { where(is_draft: true) }
  scope :completed, -> { where(is_draft: false) }
end
