class Task < ActiveRecord::Base
  belongs_to :user

  def self.current_tasks
 	where(user_id: current_user AND completed_at is null)
  end

  acts_as_list

end
