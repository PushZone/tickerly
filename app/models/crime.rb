class Crime < ActiveRecord::Base
  has_many :user_activities
  has_many :crime_approve
  has_many :crime_unapprove
  belongs_to :user

  def self.get_distance(location_1, location_2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (location_2[0]-location_1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (location_2[1]-location_1[1]) * rad_per_deg

    lat1_rad, lon1_rad = location_1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = location_2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end

end
