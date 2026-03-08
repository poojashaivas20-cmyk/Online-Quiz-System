-- ============================================================
-- Additional Questions Seed Data (CTE version - Supabase compatible)
-- Run this in Supabase SQL Editor
-- ============================================================


-- ============================================================
-- SPACE EXPLORATION QUIZ - Extra Questions
-- ============================================================

-- Q3: How many planets?
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'How many planets are in our solar system?', 5
    FROM quizzes WHERE title = 'Space Exploration' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('8', TRUE), ('7', FALSE), ('9', FALSE), ('10', FALSE)) AS v(opt, correct);

-- Q4: Closest star
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the closest star to Earth (other than the Sun)?', 10
    FROM quizzes WHERE title = 'Space Exploration' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Proxima Centauri', TRUE), ('Sirius', FALSE), ('Alpha Centauri A', FALSE), ('Betelgeuse', FALSE)) AS v(opt, correct);

-- Q5: First Moon landing
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Which space agency landed the first humans on the Moon?', 5
    FROM quizzes WHERE title = 'Space Exploration' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('NASA', TRUE), ('ESA', FALSE), ('Roscosmos', FALSE), ('ISRO', FALSE)) AS v(opt, correct);


-- ============================================================
-- GENERAL KNOWLEDGE QUIZ - Questions
-- ============================================================

-- Q1: Capital of France
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the capital city of France?', 5
    FROM quizzes WHERE title = 'General Knowledge' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Paris', TRUE), ('Berlin', FALSE), ('Madrid', FALSE), ('Rome', FALSE)) AS v(opt, correct);

-- Q2: Longest river
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Which is the longest river in the world?', 5
    FROM quizzes WHERE title = 'General Knowledge' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Nile', TRUE), ('Amazon', FALSE), ('Yangtze', FALSE), ('Missouri', FALSE)) AS v(opt, correct);

-- Q3: Hexagon sides
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'How many sides does a hexagon have?', 5
    FROM quizzes WHERE title = 'General Knowledge' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('6', TRUE), ('5', FALSE), ('7', FALSE), ('8', FALSE)) AS v(opt, correct);

-- Q4: Kangaroo country
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Which country is home to the kangaroo?', 5
    FROM quizzes WHERE title = 'General Knowledge' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Australia', TRUE), ('New Zealand', FALSE), ('South Africa', FALSE), ('Brazil', FALSE)) AS v(opt, correct);

-- Q5: Smallest country
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the smallest country in the world?', 10
    FROM quizzes WHERE title = 'General Knowledge' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Vatican City', TRUE), ('Monaco', FALSE), ('San Marino', FALSE), ('Liechtenstein', FALSE)) AS v(opt, correct);


-- ============================================================
-- SCIENCE & NATURE QUIZ - Questions
-- ============================================================

-- Q1: Chemical symbol for water
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the chemical symbol for water?', 5
    FROM quizzes WHERE title = 'Science & Nature' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('H2O', TRUE), ('CO2', FALSE), ('NaCl', FALSE), ('O2', FALSE)) AS v(opt, correct);

-- Q2: Photosynthesis gas
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What gas do plants absorb during photosynthesis?', 5
    FROM quizzes WHERE title = 'Science & Nature' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Carbon Dioxide', TRUE), ('Oxygen', FALSE), ('Nitrogen', FALSE), ('Hydrogen', FALSE)) AS v(opt, correct);

-- Q3: Speed of light
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the approximate speed of light in a vacuum?', 10
    FROM quizzes WHERE title = 'Science & Nature' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('3 x 10^8 m/s', TRUE), ('3 x 10^6 m/s', FALSE), ('3 x 10^10 m/s', FALSE), ('3 x 10^4 m/s', FALSE)) AS v(opt, correct);

-- Q4: Powerhouse of the cell
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'What is the powerhouse of the cell?', 5
    FROM quizzes WHERE title = 'Science & Nature' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Mitochondria', TRUE), ('Nucleus', FALSE), ('Ribosome', FALSE), ('Chloroplast', FALSE)) AS v(opt, correct);

-- Q5: Bones in human body
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'How many bones are in the adult human body?', 10
    FROM quizzes WHERE title = 'Science & Nature' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('206', TRUE), ('205', FALSE), ('208', FALSE), ('210', FALSE)) AS v(opt, correct);


-- ============================================================
-- WORLD HISTORY QUIZ - New Quiz + Questions
-- ============================================================

INSERT INTO quizzes (title, description, category)
VALUES ('World History', 'Test your knowledge of historical events', 'History');

-- Q1: WWII end year
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'In which year did World War II end?', 5
    FROM quizzes WHERE title = 'World History' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('1945', TRUE), ('1944', FALSE), ('1946', FALSE), ('1943', FALSE)) AS v(opt, correct);

-- Q2: First US President
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Who was the first President of the United States?', 5
    FROM quizzes WHERE title = 'World History' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('George Washington', TRUE), ('Abraham Lincoln', FALSE), ('Thomas Jefferson', FALSE), ('John Adams', FALSE)) AS v(opt, correct);

-- Q3: Ancient wonder in Alexandria
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Which ancient wonder was located in Alexandria?', 10
    FROM quizzes WHERE title = 'World History' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('The Lighthouse of Alexandria', TRUE), ('The Colossus of Rhodes', FALSE), ('The Hanging Gardens', FALSE), ('The Statue of Zeus', FALSE)) AS v(opt, correct);

-- Q4: Berlin Wall
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'The Berlin Wall fell in which year?', 5
    FROM quizzes WHERE title = 'World History' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('1989', TRUE), ('1991', FALSE), ('1987', FALSE), ('1985', FALSE)) AS v(opt, correct);

-- Q5: Mona Lisa
WITH new_q AS (
    INSERT INTO questions (quiz_id, question_text, points)
    SELECT id, 'Who painted the Mona Lisa?', 5
    FROM quizzes WHERE title = 'World History' LIMIT 1
    RETURNING id
)
INSERT INTO options (question_id, option_text, is_correct)
SELECT new_q.id, v.opt, v.correct FROM new_q,
(VALUES ('Leonardo da Vinci', TRUE), ('Michelangelo', FALSE), ('Raphael', FALSE), ('Donatello', FALSE)) AS v(opt, correct);
