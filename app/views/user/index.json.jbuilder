json.array! @users do |u|
  json.id u.id
  json.email u.email
  json.profile_type u.profile_type
  json.avatar u.avatar
  json.created_at u.created_at
end
