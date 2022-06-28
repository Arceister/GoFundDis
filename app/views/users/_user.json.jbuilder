json.extract! user, :id, :email, :password, :name, :phone, :birthdate, :bio, :picture, :created_at, :updated_at
json.url user_url(user, format: :json)
