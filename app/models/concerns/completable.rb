module Completable
  
  def complete
    self.update({completed: true, completed_at: Time.now})
  end

end