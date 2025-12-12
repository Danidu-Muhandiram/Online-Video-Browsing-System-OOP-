-- Add avatar and user_type columns to users table
ALTER TABLE users
ADD COLUMN avatar VARCHAR(255) DEFAULT NULL,
ADD COLUMN user_type VARCHAR(50) DEFAULT 'user';

-- Update existing records to have default user_type
UPDATE users SET user_type = 'user' WHERE user_type IS NULL; 