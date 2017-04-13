class Task < ActiveRecord::Base
  belongs_to :user
  include Completable

  def assign_to(user_id)
    if (self.is_assigned? && self.user_id != user_id)
      raise TaskAlreadyAssigned
    end
    self.update({user_id: user_id})
  end

  def is_assigned?
    !self.user_id.nil?
  end

end
