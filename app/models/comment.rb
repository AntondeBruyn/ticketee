class Comment < ActiveRecord::Base
  belongs_to :state
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :previous_state, class_name: "State"
  delegate :project, to: :ticket
  validates :text, presence: true
  before_create :set_previous_state
  after_create :set_ticket_state

private

  def set_previous_state
    self.previous_state = ticket.state
  end

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end
end
