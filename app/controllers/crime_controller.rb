class CrimeController < ApplicationController
  # before_action :check_token

  def new_crime


    user = User.find_by(email: params[:useremail])

    return render status: 500, json: OpenStruct.new({ status: "fail-no-user"}) if user.email.nil?
    if params.index(nil) || params[:crimetype].nil? || params[:latitude].nil? || params[:longitude].nil? || params[:locationName].nil?
      return render status: 500, json: OpenStruct.new({ status: "fail-no-user"})
    end

    if "#{params[:latitude]}".to_i == 0 || params[:latitude].length < 1 || params[:longitude].length < 1
      return render status: 500, json: OpenStruct.new({ status: "fail-no-user"})
    end


    crime = Crime.create(
      crime_type: params[:crimetype],
      lat: params[:latitude],
      lon: params[:longitude],
      location_name: params[:locationName],
      user_id: user.id,
      crime_name: params[:crime_name],
      crime_image_link: params[:crime_image_link],
      desc: params[:desc]
    )

    user.update(point: user.point + 10)
    UserActivity.create(
      user_id: user.id, 
      crime_id: crime.id,  
      crime_type: params[:crimetype],
      lat: params[:latitude],
      lon: params[:longitude],
      location_name: params[:locationName],   
      activity_type: 1,
      point: 10)

    render status: 200, json: OpenStruct.new({ status: 200})
  end

  def verify_approve
    user = User.find_by(email: params[:useremail])
    unless user
      return render status: 200, json: OpenStruct.new({ status: "fail-no-user"})
    end
    user.update(point: user.point + 5)
    crime = Crime.find_by(id: params[:id])
    crime.update(verified: crime.verified + 1)
    CrimeApprove.create(user_id: user.id, crime_id: crime.id, user_name: user.name)
    UserActivity.create(
      user_id: user.id, 
      crime_type: params[:crimetype],
      lat: params[:latitude],
      lon: params[:longitude],
      location_name: params[:locationName],  
      crime_id: crime.id, 
      activity_type: 2, 
      point: 5)
    render status: 200, json: OpenStruct.new({ crime: crime})
  end

  def verify_unapprove
    user = User.find_by(email: params[:useremail])
    unless user
      return render status: 200, json: OpenStruct.new({ status: "fail-no-user"})
    end
    crime = Crime.find_by(id: params[:id])
    crime.update(unapprove: crime.unapprove + 1)
    user.update(point: user.point + 5)
    CrimeUnapprove.create(user_id: user.id, crime_id: crime.id, user_name: user.name)
    UserActivity.create(
      user_id: user.id, 
      crime_type: params[:crimetype],  
      lat: params[:latitude],
      lon: params[:longitude],
      location_name: params[:locationName],  
      crime_id: crime.id, 
      activity_type: 3, 
      point: 5)
    render status: 200, json: OpenStruct.new({ crime: crime})
  end

  def new_user
    
    if User.exists?( email: params[:user_email])
      puts "In plus_one_to_y"
    else
      User.create(
        uid: params[:user_uid],
        name: params[:user_name],
        password: '12341234',
        usergender: params[:user_gender],
        useremail: params[:user_email],
        encrypted_password: '12341234',
        email: params[:user_email]
      )
    end
    render status: 200, json: OpenStruct.new({ status: 200})
  end

  def new_user_email
    if User.exists?( email: params[:user_email])
      puts "In plus_one_to_y"
    else
      Useremail.create(
        id: params[:user_id],
        uid: params[:user_uid],
        name: params[:user_name],
        usergender: params[:user_gender],
        useremail: params[:user_email],
        userbirthday: params[:user_birthday],
        password: params[:user_password]
      )
    end
      render status: 200, json: OpenStruct.new({ status: 200})
  end

  def get_approve
    crime = Crime.find(params[:crime_id])
    approve = crime.crime_approve
    render status: 200, json: OpenStruct.new({ status: 200, data: approve})
  end


  def get_unapprove
    crime = Crime.find(params[:crime_id])
    approve = crime.crime_unapprove
    render status: 200, json: OpenStruct.new({ status: 200, data: approve})
  end

  # location_1 {lat , lon} / location_2 {lat , lon}
  def get_distance(location_1, location_2)
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


  def get_username

    if User.exists?( email: params[:user_email])
      getUsername = params[:user_email]
      sendUserEmail = User.where(email: params[:user_email])
  end
    render status: 200, json: OpenStruct.new({ status: 200, data: sendUserEmail})
  end

  def get_near
    if "#{params[:distance]}".to_i == 0 || "#{params[:distance]}".to_i > 4000
      return render status: 500, json: OpenStruct.new({ status: 200, data: []})
    end
    lat = params[:current_lat]
    lon = params[:current_lon]
    crime_data = Crime.where("created_at >= ?", Time.zone.now.beginning_of_day)
    crimes = crime_data.select do |c|
      distance = get_distance([lat.to_f, lon.to_f],[c.lat.to_f, c.lon.to_f])
      distance <= params[:distance].to_i
      p distance
      p "00000000-----"
      p params[:distance].to_i
      p "--------"
    end
  
    render status: 200, json: OpenStruct.new({ status: 200, data: crimes})
  end

  private

  def check_token
    list = Iplist.find_or_create_by(ip: request.remote_ip, date: Date.today)
    p "-------------------------"
    p request.user_agent
    p "-------------------------"
    p request.user_agent =~ /iOS/
    list.update(count: list.count + 1)
    # if list.count > 1000ser
    #   return render status: 500, json: OpenStruct.new({ status: 500, message: "fuck fuck fuck"})
    # end

    unless request.user_agent =~ /iOS/
      p "not ios"
      return render status: 200, json: OpenStruct.new({ status: 500, message: "fuck fuck"})
    end
    if params[:token] != "RV2HP71Kzpsv73z6FLt8OFZS9zM4s254"
      p "no token"
      return render status: 200, json: OpenStruct.new({ status: 500, message: "fuck"})
    end

  end


end
