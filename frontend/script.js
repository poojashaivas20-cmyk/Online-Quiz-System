// ─── Global State ─────────────────────────────────────────────────────────────

let currentUser = JSON.parse(localStorage.getItem('user')) || null;
let authToken = localStorage.getItem('token') || null;

// ─── Auth Helpers ─────────────────────────────────────────────────────────────

function updateAuthUI() {
    const authLinks = document.getElementById('auth-links');
    const userProfile = document.getElementById('user-profile');
    const userEmailSpan = document.getElementById('user-email');
    const navGetStarted = document.getElementById('nav-get-started');

    if (currentUser && authToken) {
        authLinks.style.display = 'none';
        userProfile.style.display = 'flex';
        userEmailSpan.innerText = currentUser.email.split('@')[0]; // Show just the username part
        navGetStarted.style.display = 'inline-block';
    } else {
        authLinks.style.display = 'flex';
        userProfile.style.display = 'none';
        navGetStarted.style.display = 'none';
    }
}

async function handleSignup(e) {
    e.preventDefault();
    const email = document.getElementById('signup-email').value;
    const password = document.getElementById('signup-password').value;

    try {
        const response = await fetch('http://localhost:5000/api/signup', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        const data = await response.json();
        if (!response.ok) throw new Error(data.error || 'Signup failed');

        alert('Signup successful! You can now log in.');
        document.getElementById('signup-modal').style.display = 'none';
        document.getElementById('login-modal').style.display = 'flex';
    } catch (error) {
        alert(error.message);
    }
}

async function handleLogin(e) {
    e.preventDefault();
    const email = document.getElementById('login-email').value;
    const password = document.getElementById('login-password').value;

    try {
        const response = await fetch('http://localhost:5000/api/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        const data = await response.json();
        if (!response.ok) throw new Error(data.error || 'Login failed');

        currentUser = data.user;
        authToken = data.access_token;
        localStorage.setItem('user', JSON.stringify(currentUser));
        localStorage.setItem('token', authToken);

        updateAuthUI();
        document.getElementById('login-modal').style.display = 'none';
        showView('browse');
    } catch (error) {
        alert(error.message);
    }
}

function handleLogout() {
    currentUser = null;
    authToken = null;
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    updateAuthUI();
    showView('home');
}

// ─── Fetch & Render History (Backend Version) ───────────────────────────────

async function renderHistory() {
    const historyContainer = document.getElementById('history-container');

    if (!authToken) {
        historyContainer.innerHTML = `
            <div class="status-msg" style="text-align:center; padding: 3rem;">
                <h3>Please login to see your history</h3>
                <button class="btn-primary" onclick="document.getElementById('login-modal').style.display='flex'">Login Now</button>
            </div>`;
        return;
    }

    historyContainer.innerHTML = `<p class="status-msg">⏳ Loading your history...</p>`;

    try {
        const response = await fetch('http://localhost:5000/api/my-results', {
            headers: { 'Authorization': `Bearer ${authToken}` }
        });
        if (!response.ok) throw new Error('Could not fetch history');
        const history = await response.json();

        if (history.length === 0) {
            historyContainer.innerHTML = `
                <div class="status-msg" style="text-align:center; padding: 3rem;">
                    <p>You haven't taken any quizzes yet. <a href="#" id="browse-again-link" style="color:var(--accent);">Browse quizzes</a> to get started!</p>
                </div>`;
            document.getElementById('browse-again-link')?.addEventListener('click', (e) => {
                e.preventDefault();
                showView('browse');
            });
            return;
        }

        historyContainer.innerHTML = `
            <div class="history-list" style="display: flex; flex-direction: column; gap: 1rem;">
                ${history.map(item => `
                    <div class="quiz-card" style="display: flex; justify-content: space-between; align-items: center; padding: 1.2rem 1.5rem; border-left: 4px solid var(--accent);">
                        <div>
                            <h4 style="margin: 0; color: #fff; font-size: 1.1rem;">${item.quizzes.title}</h4>
                            <small style="color: #666;">${new Date(item.created_at).toLocaleString()}</small>
                        </div>
                        <div style="text-align: right;">
                            <span style="font-size: 1.4rem; font-weight: bold; color: var(--accent);">${item.score} / ${item.total_questions}</span>
                            <div style="font-size: 0.85rem; color: #888;">${Math.round((item.score / item.total_questions) * 100)}%</div>
                        </div>
                    </div>
                `).join('')}
            </div>
        `;
    } catch (error) {
        historyContainer.innerHTML = `<p class="status-msg" style="color: #ff4757;">❌ Error loading history: ${error.message}</p>`;
    }
}

// ─── Page / View State ────────────────────────────────────────────────────────

function showView(view) {
    const hero = document.getElementById('hero-section');
    const quizList = document.getElementById('quiz-list');
    const myQuizzes = document.getElementById('my-quizzes-section');

    hero.style.display = 'none';
    quizList.style.display = 'none';
    myQuizzes.style.display = 'none';

    if (view === 'home') {
        hero.style.display = 'flex';
    } else if (view === 'browse') {
        quizList.style.display = 'grid';
        fetchQuizzes();
    } else if (view === 'my-quizzes') {
        myQuizzes.style.display = 'block';
        renderHistory();
    }
}

// ─── DOM Ready ────────────────────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', () => {
    console.log('QuizMaster initialized');
    updateAuthUI();

    // ── Nav & Auth listeners ─────────────────────────────────────────────
    document.getElementById('nav-home').addEventListener('click', (e) => { e.preventDefault(); showView('home'); });
    document.getElementById('nav-logo').addEventListener('click', (e) => { e.preventDefault(); showView('home'); });
    document.getElementById('nav-my-quizzes').addEventListener('click', (e) => { e.preventDefault(); showView('my-quizzes'); });
    document.getElementById('nav-get-started').addEventListener('click', (e) => { e.preventDefault(); showView('browse'); });
    document.getElementById('nav-logout').addEventListener('click', (e) => { e.preventDefault(); handleLogout(); });

    document.getElementById('open-login').addEventListener('click', (e) => { e.preventDefault(); document.getElementById('login-modal').style.display = 'flex'; });
    document.getElementById('open-signup').addEventListener('click', (e) => { e.preventDefault(); document.getElementById('signup-modal').style.display = 'flex'; });

    document.getElementById('switch-to-signup').addEventListener('click', (e) => {
        e.preventDefault();
        document.getElementById('login-modal').style.display = 'none';
        document.getElementById('signup-modal').style.display = 'flex';
    });
    document.getElementById('switch-to-login').addEventListener('click', (e) => {
        e.preventDefault();
        document.getElementById('signup-modal').style.display = 'none';
        document.getElementById('login-modal').style.display = 'flex';
    });

    document.getElementById('login-form').addEventListener('submit', handleLogin);
    document.getElementById('signup-form').addEventListener('submit', handleSignup);

    // ── Hero buttons ─────────────────────────────────────────────────────
    document.getElementById('browse-quizzes').addEventListener('click', () => {
        if (!authToken) {
            document.getElementById('login-modal').style.display = 'flex';
        } else {
            showView('browse');
        }
    });
    document.getElementById('create-quiz').addEventListener('click', () => showCreateModal());

    // ── History button ───────────────────────────────────────────────────
    document.getElementById('clear-history').addEventListener('click', () => {
        alert('Persistent history is managed by your account. Only admins can delete results.');
    });
});

// ─── Fetch & Render Quiz List ─────────────────────────────────────────────────

async function fetchQuizzes() {
    const quizList = document.getElementById('quiz-list');
    quizList.innerHTML = `<p class="status-msg">⏳ Loading quizzes...</p>`;

    try {
        const response = await fetch('http://localhost:5000/api/quizzes');
        if (!response.ok) throw new Error('API Error');
        const quizzes = await response.json();
        renderQuizzes(quizzes);
    } catch (error) {
        quizList.innerHTML = `<div class="error-box"><h3>⚠️ Error</h3><p>${error.message}</p></div>`;
    }
}

function renderQuizzes(quizzes) {
    const quizList = document.getElementById('quiz-list');
    quizList.innerHTML = quizzes.map(quiz => `
        <div class="quiz-card">
            <span class="quiz-category">${quiz.category || 'General'}</span>
            <h3>${quiz.title}</h3>
            <p>${quiz.description || ''}</p>
            <button class="btn-primary" onclick="takeQuiz('${quiz.id}')">Take Quiz</button>
        </div>
    `).join('');
}

async function takeQuiz(quizId) {
    const quizList = document.getElementById('quiz-list');
    quizList.innerHTML = `<p class="status-msg">⏳ Loading quiz...</p>`;
    showView('browse'); // Ensure quiz list is the container

    try {
        const response = await fetch(`http://localhost:5000/api/quizzes/${quizId}`);
        const quiz = await response.json();
        renderQuizQuestions(quiz);
    } catch (error) {
        quizList.innerHTML = `<div class="error-box"><h3>⚠️ Error</h3><p>${error.message}</p></div>`;
    }
}

function renderQuizQuestions(quiz) {
    const container = document.getElementById('quiz-list');
    container.innerHTML = `
        <div class="quiz-view" data-quiz-id="${quiz.id}">
            <h2 id="current-quiz-title">${quiz.title}</h2>
            <div id="questions-container">
                ${quiz.questions.map((q, idx) => `
                    <div class="question-item">
                        <p><strong>Q${idx + 1}: ${q.question_text}</strong></p>
                        <div class="options-container">
                            ${q.options.map(opt => `
                                <label class="option-label">
                                    <input type="radio" name="question-${q.id}" value="${opt.id}" data-correct="${opt.is_correct}">
                                    <span>${opt.option_text}</span>
                                </label>
                            `).join('')}
                        </div>
                    </div>
                `).join('<hr>')}
            </div>
            <div class="quiz-actions">
                <button class="btn-secondary" onclick="showView('browse')">← Back</button>
                <button class="btn-primary" onclick="submitQuiz()">Submit Quiz</button>
            </div>
            <div id="quiz-result"></div>
        </div>
    `;
}

async function submitQuiz() {
    const quizView = document.querySelector('.quiz-view');
    const quizId = quizView.dataset.quizId;
    const questions = document.querySelectorAll('[name^="question-"]');
    const questionNames = [...new Set([...questions].map(el => el.name))];

    let answered = 0;
    let correct = 0;
    let total = questionNames.length;

    questionNames.forEach(name => {
        const selected = document.querySelector(`input[name="${name}"]:checked`);
        if (selected) {
            answered++;
            if (selected.dataset.correct === 'true') correct++;
        }
    });

    if (answered < total) { alert('Please answer all questions!'); return; }

    const percent = Math.round((correct / total) * 100);

    // Save to Backend
    if (authToken) {
        try {
            await fetch('http://localhost:5000/api/save-result', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${authToken}`
                },
                body: JSON.stringify({ quiz_id: quizId, score: correct, total_questions: total })
            });
        } catch (e) { console.error('History sync failed', e); }
    }

    document.getElementById('quiz-result').innerHTML = `
        <div class="result-box">
            <h3>Scored: ${correct} / ${total} (${percent}%)</h3>
            <button class="btn-primary" onclick="showView('browse')">Back to Quizzes</button>
            <button class="btn-secondary" onclick="showView('my-quizzes')">See History</button>
        </div>`;

    document.querySelectorAll('#questions-container input').forEach(el => el.disabled = true);
    document.querySelector('button[onclick="submitQuiz()"]').disabled = true;
}

function showCreateModal() {
    const modal = document.createElement('div');
    modal.className = 'modal-overlay';
    modal.innerHTML = `
        <div class="modal-box"><h2>Create Quiz</h2><p>Use Supabase Dashboard.</p><button class="btn-primary" onclick="this.parentElement.parentElement.remove()">Close</button></div>`;
    document.body.appendChild(modal);
}
