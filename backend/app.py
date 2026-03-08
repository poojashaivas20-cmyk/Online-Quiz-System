from flask import Flask, jsonify, request
from flask_cors import CORS
import os
from dotenv import load_dotenv
from supabase import create_client, Client

load_dotenv()

app = Flask(__name__)
CORS(app)

# Supabase configuration
SUPABASE_URL = os.environ.get("SUPABASE_URL")
SUPABASE_KEY = os.environ.get("SUPABASE_KEY")

supabase: Client = None
if SUPABASE_URL and SUPABASE_KEY:
    supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.route('/')
def index():
    return jsonify({"message": "Online Quiz API is running"})

# ─── Auth Routes ─────────────────────────────────────────────────────────────

@app.route('/api/signup', methods=['POST'])
def signup():
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    
    data = request.json
    email = data.get('email')
    password = data.get('password')
    
    try:
        res = supabase.auth.sign_up({"email": email, "password": password})
        return jsonify({"message": "Signup successful", "user": res.user.id if res.user else None}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/api/login', methods=['POST'])
def login():
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    
    data = request.json
    email = data.get('email')
    password = data.get('password')
    
    try:
        res = supabase.auth.sign_in_with_password({"email": email, "password": password})
        return jsonify({
            "access_token": res.session.access_token,
            "user": {
                "id": res.user.id,
                "email": res.user.email
            }
        }), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 401

# ─── Quiz Routes ─────────────────────────────────────────────────────────────

@app.route('/api/quizzes', methods=['GET'])
def get_quizzes():
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    try:
        response = supabase.table('quizzes').select('*').order('created_at', desc=True).execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/quizzes/<quiz_id>', methods=['GET'])
def get_quiz_details(quiz_id):
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    try:
        response = supabase.table('quizzes').select('*, questions(*, options(*))').eq('id', quiz_id).single().execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# ─── User Results Routes ──────────────────────────────────────────────────────

@app.route('/api/save-result', methods=['POST'])
def save_result():
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    
    data = request.json
    token = request.headers.get('Authorization')
    if not token: return jsonify({"error": "Unauthorized"}), 401
    
    token = token.replace('Bearer ', '')
    
    try:
        # Verify user via token
        user = supabase.auth.get_user(token)
        user_id = user.user.id
        
        result_data = {
            "user_id": user_id,
            "quiz_id": data.get('quiz_id'),
            "score": data.get('score'),
            "total_questions": data.get('total_questions')
        }
        
        response = supabase.table('user_results').insert(result_data).execute()
        return jsonify(response.data), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/api/my-results', methods=['GET'])
def get_my_results():
    if not supabase: return jsonify({"error": "Supabase not configured"}), 500
    
    token = request.headers.get('Authorization')
    if not token: return jsonify({"error": "Unauthorized"}), 401
    
    token = token.replace('Bearer ', '')
    
    try:
        user = supabase.auth.get_user(token)
        user_id = user.user.id
        
        # Join with quizzes to get the title
        response = supabase.table('user_results').select('*, quizzes(title)').eq('user_id', user_id).order('created_at', desc=True).execute()
        return jsonify(response.data)
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True, port=5000)
