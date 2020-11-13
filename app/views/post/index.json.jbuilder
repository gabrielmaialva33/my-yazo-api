json.array! @posts do |i|
  json.id i.id
  json.title i.title
  json.author i.author
  json.body i.body
end
