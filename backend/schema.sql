-- Enable UUID extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Quizzes Table
CREATE TABLE quizzes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    category TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Questions Table
CREATE TABLE questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    question_type TEXT DEFAULT 'multiple-choice',
    points INT DEFAULT 1,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Options Table
CREATE TABLE options (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE
);

-- Sample Data
INSERT INTO quizzes (title, description, category) VALUES 
('General Knowledge', 'Test your basic knowledge', 'General'),
('Science & Nature', 'Explore the wonders of science', 'Science');

-- Custom Quiz: Space Exploration
DO $$
DECLARE
    quiz_id UUID;
    q1_id UUID;
    q2_id UUID;
BEGIN
    -- Create Quiz
    INSERT INTO quizzes (title, description, category) 
    VALUES ('Space Exploration', 'Discover the mysteries of our solar system', 'Science')
    RETURNING id INTO quiz_id;

    -- Question 1
    INSERT INTO questions (quiz_id, question_text, points)
    VALUES (quiz_id, 'Which planet is known as the Red Planet?', 5)
    RETURNING id INTO q1_id;

    INSERT INTO options (question_id, option_text, is_correct) VALUES
    (q1_id, 'Mars', TRUE),
    (q1_id, 'Jupiter', FALSE),
    (q1_id, 'Venus', FALSE),
    (q1_id, 'Saturn', FALSE);

    -- Question 2
    INSERT INTO questions (quiz_id, question_text, points)
    VALUES (quiz_id, 'What is the largest moon in the solar system?', 10)
    RETURNING id INTO q2_id;

    INSERT INTO options (question_id, option_text, is_correct) VALUES
    (q2_id, 'Ganymede', TRUE),
    (q2_id, 'Titan', FALSE),
    (q2_id, 'Europa', FALSE),
    (q2_id, 'Io', FALSE);

END $$;
