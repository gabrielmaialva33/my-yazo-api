json.array! @posts do |p|
  json.id p.id
  json.title p.title
  json.author p.author
  json.body p.body
end
