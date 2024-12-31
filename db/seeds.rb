user1 = User.create!(email: "user1@example.com", password: "password123")
user2 = User.create!(email: "user2@example.com", password: "password123")
user3 = User.create!(email: "user3@example.com", password: "password123")

Post.create!(title: "Post by User 1", body: "This is the body of the first post.", user: user1)
Post.create!(title: "Post by User 2", body: "This is the body of the second post.", user: user2)
Post.create!(title: "Post by User 3", body: "This is the body of the third post.", user: user3)
Post.create!(title: "Another post by User 1", body: "Another body of a post by User 1.", user: user1)
Post.create!(title: "Another post by User 2", body: "Another body of a post by User 2.", user: user2)
