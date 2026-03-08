-- ============================================================
-- AUTHENTICATION & USER RESULTS SETUP
-- Run this in Supabase SQL Editor
-- ============================================================

-- 1. Create User Results Table
CREATE TABLE IF NOT EXISTS user_results (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE user_results ENABLE ROW LEVEL SECURITY;

-- 3. Create Policies
-- Users can only view their own results
CREATE POLICY "Users can view their own results" 
ON user_results FOR SELECT 
USING (auth.uid() = user_id);

-- Users can only insert their own results
CREATE POLICY "Users can insert their own results" 
ON user_results FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- 4. Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_results_user_id ON user_results(user_id);
CREATE INDEX IF NOT EXISTS idx_user_results_quiz_id ON user_results(quiz_id);
