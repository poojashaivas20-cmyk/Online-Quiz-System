-- ============================================================
-- MASTER SEED DATA (Supabase Compatible)
-- Description: Clears all quiz data and re-seeds it correctly
-- ============================================================

-- 1. CLEAN UP (Safe because of CASCADE in schema)
TRUNCATE quizzes CASCADE;

-- 2. SEED DATA
DO $$
DECLARE
    q_id UUID;
    quiz_id UUID;
BEGIN

-- --------------------------------------------------------
-- QUIZ 1: General Knowledge
-- --------------------------------------------------------
INSERT INTO quizzes (title, description, category) 
VALUES ('General Knowledge', 'Test your basic knowledge of the world', 'General')
RETURNING id INTO quiz_id;

-- Q1
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the capital city of France?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Paris', TRUE), (q_id, 'Berlin', FALSE), (q_id, 'Madrid', FALSE), (q_id, 'Rome', FALSE);

-- Q2
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Which is the longest river in the world?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Nile', TRUE), (q_id, 'Amazon', FALSE), (q_id, 'Yangtze', FALSE), (q_id, 'Missouri', FALSE);

-- Q3
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'How many sides does a hexagon have?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '6', TRUE), (q_id, '5', FALSE), (q_id, '7', FALSE), (q_id, '8', FALSE);

-- Q4
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Which country is home to the kangaroo?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Australia', TRUE), (q_id, 'New Zealand', FALSE), (q_id, 'South Africa', FALSE), (q_id, 'Brazil', FALSE);

-- Q5
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the smallest country in the world?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Vatican City', TRUE), (q_id, 'Monaco', FALSE), (q_id, 'San Marino', FALSE), (q_id, 'Liechtenstein', FALSE);


-- --------------------------------------------------------
-- QUIZ 2: Science & Nature
-- --------------------------------------------------------
INSERT INTO quizzes (title, description, category) 
VALUES ('Science & Nature', 'Explore the wonders of science and biology', 'Science')
RETURNING id INTO quiz_id;

-- Q1
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the chemical symbol for water?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'H2O', TRUE), (q_id, 'CO2', FALSE), (q_id, 'NaCl', FALSE), (q_id, 'O2', FALSE);

-- Q2
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What gas do plants absorb from the atmosphere during photosynthesis?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Carbon Dioxide', TRUE), (q_id, 'Oxygen', FALSE), (q_id, 'Nitrogen', FALSE), (q_id, 'Hydrogen', FALSE);

-- Q3
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the approximate speed of light in a vacuum?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '3 x 10^8 m/s', TRUE), (q_id, '3 x 10^6 m/s', FALSE), (q_id, '3 x 10^10 m/s', FALSE), (q_id, '3 x 10^4 m/s', FALSE);

-- Q4
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the powerhouse of the cell?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Mitochondria', TRUE), (q_id, 'Nucleus', FALSE), (q_id, 'Ribosome', FALSE), (q_id, 'Chloroplast', FALSE);

-- Q5
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'How many bones are in the adult human body?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '206', TRUE), (q_id, '205', FALSE), (q_id, '208', FALSE), (q_id, '210', FALSE);


-- --------------------------------------------------------
-- QUIZ 3: Space Exploration
-- --------------------------------------------------------
INSERT INTO quizzes (title, description, category) 
VALUES ('Space Exploration', 'Discover the mysteries of our solar system', 'Science')
RETURNING id INTO quiz_id;

-- Q1
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Which planet is known as the Red Planet?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Mars', TRUE), (q_id, 'Jupiter', FALSE), (q_id, 'Venus', FALSE), (q_id, 'Saturn', FALSE);

-- Q2
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the largest moon in the solar system?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Ganymede', TRUE), (q_id, 'Titan', FALSE), (q_id, 'Europa', FALSE), (q_id, 'Io', FALSE);

-- Q3
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'How many planets are in our solar system?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '8', TRUE), (q_id, '7', FALSE), (q_id, '9', FALSE), (q_id, '10', FALSE);

-- Q4
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'What is the closest star to Earth (other than the Sun)?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Proxima Centauri', TRUE), (q_id, 'Sirius', FALSE), (q_id, 'Alpha Centauri A', FALSE), (q_id, 'Betelgeuse', FALSE);

-- Q5
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Which space agency landed the first humans on the Moon?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'NASA', TRUE), (q_id, 'ESA', FALSE), (q_id, 'Roscosmos', FALSE), (q_id, 'ISRO', FALSE);


-- --------------------------------------------------------
-- QUIZ 4: World History
-- --------------------------------------------------------
INSERT INTO quizzes (title, description, category) 
VALUES ('World History', 'Test your knowledge of historical events', 'History')
RETURNING id INTO quiz_id;

-- Q1
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'In which year did World War II end?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '1945', TRUE), (q_id, '1944', FALSE), (q_id, '1946', FALSE), (q_id, '1943', FALSE);

-- Q2
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Who was the first President of the United States?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'George Washington', TRUE), (q_id, 'Abraham Lincoln', FALSE), (q_id, 'Thomas Jefferson', FALSE), (q_id, 'John Adams', FALSE);

-- Q3
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Which ancient wonder was located in Alexandria?', 10) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'The Lighthouse of Alexandria', TRUE), (q_id, 'The Colossus of Rhodes', FALSE), (q_id, 'The Hanging Gardens', FALSE), (q_id, 'The Statue of Zeus', FALSE);

-- Q4
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'The Berlin Wall fell in which year?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, '1989', TRUE), (q_id, '1991', FALSE), (q_id, '1987', FALSE), (q_id, '1985', FALSE);

-- Q5
INSERT INTO questions (quiz_id, question_text, points) VALUES (quiz_id, 'Who painted the Mona Lisa?', 5) RETURNING id INTO q_id;
INSERT INTO options (question_id, option_text, is_correct) VALUES (q_id, 'Leonardo da Vinci', TRUE), (q_id, 'Michelangelo', FALSE), (q_id, 'Raphael', FALSE), (q_id, 'Donatello', FALSE);

END $$;
