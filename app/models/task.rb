class Task < ActiveRecord::Base
  belongs_to :user
  include Completable

  validates :title, presence: true

  scope :my_tasks, -> (user_id) {
    where(user_id: user_id)
  }

  scope :other_tasks, -> (user_id) {
    where("user_id <> ? or user_id is ?", user_id, nil)
  }

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
