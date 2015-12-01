class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, reject_if: :all_blank
end
