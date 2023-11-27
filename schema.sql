CREATE TABLE users (
  name VARCHAR(50) NOT NULL,
  photo VARCHAR(255),
  bio VARCHAR(250) NOT NULL,
  updated_at DATE NOT NULL,
  created_at DATE NOT NULL,
  posts_counter INT,
  comments_id INT,
  likes_id INT,
  author_id INT,
  FOREIGN KEY (comments_id) REFERENCES comments(id),
  FOREIGN KEY (likes_id) REFERENCES likes(id),
  FOREIGN KEY (author_id) REFERENCES posts(id)
);

CREATE INDEX idx_users_comments_id ON users(comments_id);
CREATE INDEX idx_users_likes_id ON users(likes_id);
CREATE INDEX idx_users_author_id ON users(author_id);

CREATE TABLE comments (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT,
  post_id INT,
  text VARCHAR(50) NOT NULL,
  updated_at DATE NOT NULL,
  created_at DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

CREATE TABLE likes (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT,
  post_id INT,
  updated_at DATE NOT NULL,
  created_at DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

CREATE TABLE posts (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  author_id INT,
  title VARCHAR(50) NOT NULL,
  text VARCHAR(50) NOT NULL,
  updated_at DATE NOT NULL,
  created_at DATE NOT NULL,
  comments_counter INT,
  likes_counter INT,
  FOREIGN KEY (author_id) REFERENCES users(id)
);
