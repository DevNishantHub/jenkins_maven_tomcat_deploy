<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snake Game</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: white;
        }

        .game-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            background: linear-gradient(45deg, #fff, #f0f0f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-board {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 1.2rem;
            font-weight: bold;
        }

        #gameCanvas {
            border: 3px solid rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            background: rgba(0, 0, 0, 0.2);
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.3);
        }

        .controls {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }

        .btn {
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            border: none;
            padding: 12px 24px;
            border-radius: 25px;
            color: white;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.6);
        }

        .btn:active {
            transform: translateY(0);
        }

        .instructions {
            margin-top: 15px;
            font-size: 0.9rem;
            opacity: 0.8;
            line-height: 1.4;
        }

        .game-over {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.8);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            display: none;
        }

        .high-score {
            color: #ffd700;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse {
            animation: pulse 0.3s ease-in-out;
        }
    </style>
</head>
<body>
    <div class="game-container">
        <h1>🐍 Snake Game hisss s</h1>
        <h1>This is a sanke game </h1>
        
        <div class="score-board">
            <div>Score: <span id="score">0</span></div>
            <div class="high-score">High Score: <span id="highScore">0</span></div>
        </div>

        <canvas id="gameCanvas" width="400" height="400"></canvas>

        <div class="controls">
            <button class="btn" onclick="startGame()">Start Game</button>
            <button class="btn" onclick="pauseGame()">Pause</button>
        </div>

        <div class="instructions">
            Use WASD or Arrow Keys to move<br>
            Eat the red food to grow and score points!
        </div>

        <div id="gameOver" class="game-over">
            <h2>Game Over!</h2>
            <p>Final Score: <span id="finalScore">0</span></p>
            <button class="btn" onclick="restartGame()">Play Again</button>
        </div>
    </div>

    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const scoreElement = document.getElementById('score');
        const highScoreElement = document.getElementById('highScore');
        const gameOverDiv = document.getElementById('gameOver');
        const finalScoreElement = document.getElementById('finalScore');

        // Game variables
        const gridSize = 20;
        const tileCount = canvas.width / gridSize;

        let snake = [
            {x: 10, y: 10}
        ];
        let food = {};
        let dx = 0;
        let dy = 0;
        let score = 0;
        let highScore = 0;
        let gameRunning = false;
        let gameLoop;

        // Initialize game
        function init() {
            // Load high score from JSP session or use default
            <% 
                Integer savedHighScore = (Integer) session.getAttribute("highScore");
                if (savedHighScore == null) {
                    savedHighScore = 0;
                    session.setAttribute("highScore", savedHighScore);
                }
            %>
            highScore = <%= savedHighScore %>;
            highScoreElement.textContent = highScore;
            
            generateFood();
            drawGame();
        }

        function generateFood() {
            food = {
                x: Math.floor(Math.random() * tileCount),
                y: Math.floor(Math.random() * tileCount)
            };
            
            // Make sure food doesn't spawn on snake
            for (let segment of snake) {
                if (segment.x === food.x && segment.y === food.y) {
                    generateFood();
                    return;
                }
            }
        }

        function drawGame() {
            // Clear canvas with gradient
            const gradient = ctx.createLinearGradient(0, 0, canvas.width, canvas.height);
            gradient.addColorStop(0, 'rgba(20, 20, 40, 0.9)');
            gradient.addColorStop(1, 'rgba(40, 20, 60, 0.9)');
            ctx.fillStyle = gradient;
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            // Draw snake
            ctx.fillStyle = '#4ecdc4';
            ctx.shadowColor = '#4ecdc4';
            ctx.shadowBlur = 10;
            
            for (let i = 0; i < snake.length; i++) {
                const segment = snake[i];
                if (i === 0) {
                    // Snake head - different color and glow
                    ctx.fillStyle = '#45e6dc';
                    ctx.shadowBlur = 15;
                } else {
                    ctx.fillStyle = '#4ecdc4';
                    ctx.shadowBlur = 5;
                }
                
                ctx.fillRect(segment.x * gridSize + 2, segment.y * gridSize + 2, gridSize - 4, gridSize - 4);
            }

            // Draw food
            ctx.fillStyle = '#ff6b6b';
            ctx.shadowColor = '#ff6b6b';
            ctx.shadowBlur = 15;
            ctx.beginPath();
            ctx.arc(
                food.x * gridSize + gridSize/2, 
                food.y * gridSize + gridSize/2, 
                gridSize/2 - 2, 
                0, 
                2 * Math.PI
            );
            ctx.fill();

            // Reset shadow
            ctx.shadowBlur = 0;
        }

        function updateGame() {
            if (!gameRunning) return;

            const head = {x: snake[0].x + dx, y: snake[0].y + dy};

            // Check wall collision
            if (head.x < 0 || head.x >= tileCount || head.y < 0 || head.y >= tileCount) {
                gameOver();
                return;
            }

            // Check self collision
            for (let segment of snake) {
                if (head.x === segment.x && head.y === segment.y) {
                    gameOver();
                    return;
                }
            }

            snake.unshift(head);

            // Check food collision
            if (head.x === food.x && head.y === food.y) {
                score += 10;
                scoreElement.textContent = score;
                scoreElement.parentElement.classList.add('pulse');
                setTimeout(() => scoreElement.parentElement.classList.remove('pulse'), 300);
                
                generateFood();
            } else {
                snake.pop();
            }

            drawGame();
        }

        function startGame() {
            if (gameRunning) return;
            
            gameRunning = true;
            gameOverDiv.style.display = 'none';
            
            // Reset if needed
            if (snake.length === 1 && dx === 0 && dy === 0) {
                dx = 1;
                dy = 0;
            }
            
            gameLoop = setInterval(updateGame, 150);
        }

        function pauseGame() {
            gameRunning = false;
            clearInterval(gameLoop);
        }

        function gameOver() {
            gameRunning = false;
            clearInterval(gameLoop);
            
            // Update high score
            if (score > highScore) {
                highScore = score;
                highScoreElement.textContent = highScore;
                
                // Save high score to session via AJAX
                fetch('index.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=saveHighScore&highScore=' + highScore
                });
            }
            
            finalScoreElement.textContent = score;
            gameOverDiv.style.display = 'block';
        }

        function restartGame() {
            snake = [{x: 10, y: 10}];
            dx = 0;
            dy = 0;
            score = 0;
            scoreElement.textContent = score;
            gameOverDiv.style.display = 'none';
            generateFood();
            drawGame();
        }

        // Keyboard controls
        document.addEventListener('keydown', (e) => {
            if (!gameRunning && (e.key === 'w' || e.key === 's' || e.key === 'a' || e.key === 'd' || 
                                 e.key === 'ArrowUp' || e.key === 'ArrowDown' || e.key === 'ArrowLeft' || e.key === 'ArrowRight')) {
                startGame();
            }

            switch(e.key) {
                case 'w':
                case 'ArrowUp':
                    if (dy !== 1) { dx = 0; dy = -1; }
                    break;
                case 's':
                case 'ArrowDown':
                    if (dy !== -1) { dx = 0; dy = 1; }
                    break;
                case 'a':
                case 'ArrowLeft':
                    if (dx !== 1) { dx = -1; dy = 0; }
                    break;
                case 'd':
                case 'ArrowRight':
                    if (dx !== -1) { dx = 1; dy = 0; }
                    break;
                case ' ':
                    e.preventDefault();
                    if (gameRunning) pauseGame();
                    else startGame();
                    break;
            }
        });

        // Initialize game when page loads
        init();
    </script>

    <%
        // Handle high score saving
        String action = request.getParameter("action");
        if ("saveHighScore".equals(action)) {
            String highScoreParam = request.getParameter("highScore");
            if (highScoreParam != null) {
                try {
                    int newHighScore = Integer.parseInt(highScoreParam);
                    session.setAttribute("highScore", newHighScore);
                } catch (NumberFormatException e) {
                    // Handle invalid number format
                }
            }
        }
    %>
</body>
</html>
