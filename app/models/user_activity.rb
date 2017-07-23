class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :crime


  def self.add_new(user_id, crime_id, type, point)
    UserActivity.create(user_id: user_id, crime_id: crime_id, activity_type: type, point: point)
  end

end
