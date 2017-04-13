class Task < ActiveRecord::Base
  belongs_to :user
  include Completable

  validates :title, presence: true

  def assign_to(user_id)
    raise TaskAlreadyAssigned if (self.is_assigned? && self.user_id != user_id)
    self.update({user_id: user_id})
  end

  def complete
    raise TaskIsNotAssigned if !self.is_assigned?
    super
  end

  def is_assigned?
    !self.user_id.nil?
  end

end
