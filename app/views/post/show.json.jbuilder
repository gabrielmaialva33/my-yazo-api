json.id @post.id
json.title @post.title
json.author @post.author
json.body @post.body
json.comments @post.comment, :user_id, :message, :rate, :created_at
