<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #495057;
            line-height: 1.5;
        }

        .game-container {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e9ecef;
            padding: 32px;
            text-align: center;
            max-width: 640px;
            width: 100%;
            margin: 20px;
        }

        .game-header h1 {
            font-size: 2.5rem;
            margin-bottom: 24px;
            color: #343a40;
            font-weight: 600;
            letter-spacing: -0.025em;
        }

        .game-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 24px;
            gap: 16px;
        }

        .score, .high-score {
            background: #6c757d;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            flex: 1;
        }

        .game-area {
            margin: 24px 0;
            display: flex;
            justify-content: center;
        }

        #gameCanvas {
            border: 3px solid #495057;
            border-radius: 8px;
            background: #e9ecef;
            max-width: 100%;
            height: auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .game-controls {
            margin-top: 24px;
        }

        .instructions {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 24px;
            border: 1px solid #e9ecef;
        }

        .instructions h3 {
            color: #495057;
            margin-bottom: 12px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .instructions p {
            margin: 8px 0;
            color: #6c757d;
            font-size: 0.95rem;
        }

        .game-status {
            background: #e9ecef;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
            color: #495057;
        }

        .map-size-selector {
            margin-bottom: 24px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .map-size-selector h3 {
            color: #495057;
            margin-bottom: 16px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .size-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .size-btn {
            padding: 12px 20px;
            font-size: 0.95rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 120px;
        }

        .size-btn:hover {
            background: #6c757d;
            color: white;
        }

        .size-btn.active {
            background: #495057;
            color: white;
            border-color: #495057;
        }

        .control-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }

        .control-buttons button {
            padding: 12px 24px;
            font-size: 1rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 100px;
        }

        .control-buttons button:hover {
            background: #6c757d;
            color: white;
        }

        .control-buttons button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        #startBtn.active {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }

        #pauseBtn.active {
            background: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }

        #resetBtn:hover {
            background: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .mobile-controls {
            display: none;
            grid-template-rows: repeat(2, 1fr);
            gap: 12px;
            max-width: 200px;
            margin: 0 auto;
        }

        .control-row {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .control-btn {
            width: 48px;
            height: 48px;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            font-size: 1.25rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .control-btn:hover {
            background: #6c757d;
            color: white;
        }

        .game-over {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #343a40;
            padding: 40px;
            border-radius: 12px;
            border: 2px solid #495057;
            text-align: center;
            z-index: 1000;
            min-width: 320px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .game-over h2 {
            color: #f8f9fa;
            font-size: 2.2rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .game-over p {
            font-size: 1.25rem;
            margin-bottom: 28px;
            color: #adb5bd;
            font-weight: 500;
        }

        #playAgainBtn {
            padding: 14px 28px;
            font-size: 1.1rem;
            font-weight: 600;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: #495057;
            color: #f8f9fa;
            cursor: pointer;
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        #playAgainBtn:hover {
            background: #6c757d;
            border-color: #6c757d;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .hidden {
            display: none;
        }

        .speed-selector {
            margin-bottom: 24px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .speed-selector h3 {
            color: #495057;
            margin-bottom: 16px;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .speed-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .speed-btn {
            padding: 10px 16px;
            font-size: 0.9rem;
            font-weight: 500;
            border: 2px solid #6c757d;
            border-radius: 8px;
            background: white;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            min-width: 80px;
        }

        .speed-btn:hover {
            background: #6c757d;
            color: white;
        }

        .speed-btn.active {
            background: #495057;
            color: white;
            border-color: #495057;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .game-container {
                padding: 20px;
                margin: 10px;
            }
            
            .game-header h1 {
                font-size: 2rem;
            }
            
            .game-info {
                flex-direction: column;
                gap: 12px;
            }
            
            #gameCanvas {
                width: 100%;
                max-width: 100%;
            }
            
            .control-buttons {
                flex-direction: column;
                align-items: center;
            }

            .control-buttons button {
                min-width: 200px;
            }
            
            .mobile-controls {
                display: grid;
                margin-top: 20px;
            }

            .size-buttons, .speed-buttons {
                flex-direction: column;
                align-items: center;
            }

            .size-btn, .speed-btn {
                min-width: 200px;
            }
        }

        @media (min-width: 769px) {
            .mobile-controls {
                display: none;
            }
        }

        /* Focus styles for accessibility */
        button:focus {
            outline: 2px solid #495057;
            outline-offset: 2px;
        }

        /* Smooth animations */
        .game-container {
            animation: fadeIn 0.3s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="game-container">
        <div class="game-header">
            <h1>🐍 Snake Game</h1>
            <div class="game-info">
                <div class="score">Score: <span id="score">0</span></div>
                <div class="high-score">High Score: <span id="high-score">0</span></div>
            </div>
        </div>
        
        <div class="game-area">
            <canvas id="gameCanvas" width="400" height="400"></canvas>
        </div>
        
        <div class="game-controls">
            <div class="instructions">
                <h3>🎮 How to Play</h3>
                <p>Use arrow keys or WASD to move and auto-start the game</p>
                <p>Eat the red food to grow and increase your score</p>
                <p>Avoid hitting walls or yourself!</p>
            </div>

            <div class="game-status" id="gameStatus">
                Press any arrow key or WASD to start playing
            </div>
            
            <div class="map-size-selector">
                <h3>Map Size (Number of Cells)</h3>
                <div class="size-buttons">
                    <button class="size-btn" data-size="small">Small (15×15)</button>
                    <button class="size-btn active" data-size="medium">Medium (20×20)</button>
                    <button class="size-btn" data-size="large">Large (25×25)</button>
                </div>
            </div>

            <div class="speed-selector">
                <h3>Game Speed</h3>
                <div class="speed-buttons">
                    <button class="speed-btn" data-speed="slow">Slow</button>
                    <button class="speed-btn active" data-speed="normal">Normal</button>
                    <button class="speed-btn" data-speed="fast">Fast</button>
                    <button class="speed-btn" data-speed="extreme">Extreme</button>
                </div>
            </div>
            
            <div class="control-buttons">
                <button id="startBtn">Start Game</button>
                <button id="pauseBtn" disabled>Pause</button>
                <button id="resetBtn">Reset Game</button>
            </div>
            
            <div class="mobile-controls">
                <div class="control-row">
                    <button class="control-btn" data-direction="up">↑</button>
                </div>
                <div class="control-row">
                    <button class="control-btn" data-direction="left">←</button>
                    <button class="control-btn" data-direction="down">↓</button>
                    <button class="control-btn" data-direction="right">→</button>
                </div>
            </div>
        </div>
        
        <div id="gameOver" class="game-over hidden">
            <h2>Game Over!</h2>
            <p>Final Score: <span id="finalScore">0</span></p>
            <button id="playAgainBtn">Play Again</button>
        </div>
    </div>
    
    <script>
        // Game variables
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        const scoreElement = document.getElementById('score');
        const highScoreElement = document.getElementById('high-score');
        const gameOverDiv = document.getElementById('gameOver');
        const finalScoreElement = document.getElementById('finalScore');

        // Game settings - Map sizes (proper canvas dimensions for each size)
        const mapSizes = {
            small: { gridSize: 26, tileCount: 15, canvasSize: 390 },    // 15x15 cells, 26px cells = 390px
            medium: { gridSize: 20, tileCount: 20, canvasSize: 400 },   // 20x20 cells, 20px cells = 400px  
            large: { gridSize: 16, tileCount: 25, canvasSize: 400 }     // 25x25 cells, 16px cells = 400px
        };

        const gameSpeeds = {
            slow: 200,
            normal: 150,
            fast: 100,
            extreme: 60
        };

        let currentMapSize = 'medium';
        let currentSpeed = 'normal';
        let gridSize = mapSizes[currentMapSize].gridSize;
        let tileCount = mapSizes[currentMapSize].tileCount;
        let canvasSize = mapSizes[currentMapSize].canvasSize;
        let gameSpeed = gameSpeeds[currentSpeed];

        // Snake variables
        let snake = [
            { x: Math.floor(tileCount / 2), y: Math.floor(tileCount / 2) }
        ];
        let food = {};
        let dx = 0;
        let dy = 0;
        let score = 0;
        let highScore = localStorage.getItem('snakeHighScore') || 0;
        let gameRunning = false;
        let gamePaused = false;
        let gameLoop;
        let autoStarted = false;

        // UI Elements
        const gameStatus = document.getElementById('gameStatus');
        const startBtn = document.getElementById('startBtn');
        const pauseBtn = document.getElementById('pauseBtn');
        const resetBtn = document.getElementById('resetBtn');

        // Initialize the game
        function init() {
            console.log('Initializing Snake Game...');
            highScoreElement.textContent = highScore;
            updateCanvasSize();
            generateFood();
            drawGame();
            updateGameStatus();
            
            // Add event listeners
            document.addEventListener('keydown', handleKeyPress);
            startBtn.addEventListener('click', startGame);
            pauseBtn.addEventListener('click', togglePause);
            resetBtn.addEventListener('click', resetGame);
            document.getElementById('playAgainBtn').addEventListener('click', resetGame);
            
            // Mobile controls
            document.querySelectorAll('.control-btn').forEach(btn => {
                btn.addEventListener('click', handleMobileControl);
            });

            // Map size controls
            document.querySelectorAll('.size-btn').forEach(btn => {
                btn.addEventListener('click', handleMapSizeChange);
            });

            // Speed controls
            document.querySelectorAll('.speed-btn').forEach(btn => {
                btn.addEventListener('click', handleSpeedChange);
            });
        }

        // Update game status display
        function updateGameStatus() {
            if (gameRunning && !gamePaused) {
                gameStatus.textContent = 'Game in progress - Use WASD or arrow keys to move';
                gameStatus.style.background = '#d4edda';
                gameStatus.style.color = '#155724';
                startBtn.textContent = 'Playing...';
                startBtn.classList.add('active');
                startBtn.disabled = true;
                pauseBtn.disabled = false;
            } else if (gamePaused) {
                gameStatus.textContent = 'Game paused - Click Resume to continue';
                gameStatus.style.background = '#fff3cd';
                gameStatus.style.color = '#856404';
                startBtn.disabled = true;
                pauseBtn.disabled = false;
            } else {
                gameStatus.textContent = 'Press any arrow key or WASD to start playing';
                gameStatus.style.background = '#e9ecef';
                gameStatus.style.color = '#495057';
                startBtn.textContent = 'Start Game';
                startBtn.classList.remove('active');
                startBtn.disabled = false;
                pauseBtn.disabled = true;
                pauseBtn.textContent = 'Pause';
            }
        }

        // Handle speed change
        function handleSpeedChange(e) {
            if (gameRunning) {
                alert('Please reset the game before changing speed!');
                return;
            }

            document.querySelectorAll('.speed-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            e.target.classList.add('active');
            currentSpeed = e.target.dataset.speed;
            gameSpeed = gameSpeeds[currentSpeed];
            
            console.log('Speed changed to:', currentSpeed, 'Interval:', gameSpeed + 'ms');
        }

        // Update canvas size based on selected map size
        function updateCanvasSize() {
            const size = mapSizes[currentMapSize];
            // Set canvas size to properly fit the grid
            canvas.width = size.canvasSize;
            canvas.height = size.canvasSize;
            gridSize = size.gridSize;
            tileCount = size.tileCount;
            canvasSize = size.canvasSize;
            console.log(`Map updated: ${tileCount}x${tileCount} cells, Grid: ${gridSize}px per cell, Canvas: ${canvasSize}x${canvasSize}px`);
        }

        // Handle map size change
        function handleMapSizeChange(e) {
            console.log('Map size button clicked:', e.target.dataset.size);
            
            if (gameRunning) {
                alert('Please reset the game before changing map size!');
                return;
            }

            // Remove active class from all buttons
            document.querySelectorAll('.size-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            // Add active class to clicked button
            e.target.classList.add('active');

            // Update map size
            const newSize = e.target.dataset.size;
            currentMapSize = newSize;
            console.log('Map size changed to:', currentMapSize);
            
            updateCanvasSize();
            
            // Reset snake position to center
            snake = [{ x: Math.floor(tileCount / 2), y: Math.floor(tileCount / 2) }];
            
            // Reset game state
            dx = 0;
            dy = 0;
            score = 0;
            scoreElement.textContent = score;
            autoStarted = false;
            
            generateFood();
            drawGame();
            updateGameStatus();
        }

        // Handle keyboard input
        function handleKeyPress(e) {
            const key = e.key.toLowerCase();
            
            // Check if it's a valid movement key
            const isMovementKey = ['arrowleft', 'arrowup', 'arrowright', 'arrowdown', 'a', 'w', 'd', 's'].includes(key);
            
            if (isMovementKey) {
                // Auto-start game on first movement key press
                if (!gameRunning && !autoStarted) {
                    autoStarted = true;
                    startGame();
                }
                
                // Handle direction change only if game is running and not paused
                if (gameRunning && !gamePaused) {
                    // Prevent reverse direction
                    if ((key === 'arrowleft' || key === 'a') && dx !== 1) {
                        dx = -1;
                        dy = 0;
                    } else if ((key === 'arrowup' || key === 'w') && dy !== 1) {
                        dx = 0;
                        dy = -1;
                    } else if ((key === 'arrowright' || key === 'd') && dx !== -1) {
                        dx = 1;
                        dy = 0;
                    } else if ((key === 'arrowdown' || key === 's') && dy !== -1) {
                        dx = 0;
                        dy = 1;
                    }
                }
            }
            
            // Handle other keys
            if (key === ' ' || key === 'spacebar') {
                e.preventDefault();
                if (gameRunning) {
                    togglePause();
                }
            } else if (key === 'r') {
                resetGame();
            }
        }

        // Handle mobile controls
        function handleMobileControl(e) {
            const direction = e.target.dataset.direction;
            
            // Auto-start game on mobile control
            if (!gameRunning && !autoStarted) {
                autoStarted = true;
                startGame();
            }
            
            if (!gameRunning || gamePaused) return;
            
            switch (direction) {
                case 'up':
                    if (dy !== 1) { dx = 0; dy = -1; }
                    break;
                case 'down':
                    if (dy !== -1) { dx = 0; dy = 1; }
                    break;
                case 'left':
                    if (dx !== 1) { dx = -1; dy = 0; }
                    break;
                case 'right':
                    if (dx !== -1) { dx = 1; dy = 0; }
                    break;
            }
        }

        // Start the game
        function startGame() {
            if (gameRunning && !gamePaused) return;
            
            gameRunning = true;
            gamePaused = false;
            gameOverDiv.classList.add('hidden');
            
            // Only set initial direction if snake isn't moving
            if (dx === 0 && dy === 0) {
                dx = 1; // Start moving right
                dy = 0;
            }
            
            gameLoop = setInterval(updateGame, gameSpeed);
            updateGameStatus();
        }

        // Toggle pause
        function togglePause() {
            if (!gameRunning) return;
            
            gamePaused = !gamePaused;
            
            if (gamePaused) {
                clearInterval(gameLoop);
                pauseBtn.textContent = 'Resume';
                pauseBtn.classList.add('active');
            } else {
                gameLoop = setInterval(updateGame, gameSpeed);
                pauseBtn.textContent = 'Pause';
                pauseBtn.classList.remove('active');
            }
            
            updateGameStatus();
        }

        // Reset the game
        function resetGame() {
            clearInterval(gameLoop);
            gameRunning = false;
            gamePaused = false;
            autoStarted = false;
            
            // Reset game state
            snake = [{ x: Math.floor(tileCount / 2), y: Math.floor(tileCount / 2) }];
            dx = 0;
            dy = 0;
            score = 0;
            scoreElement.textContent = score;
            
            // Reset UI
            gameOverDiv.classList.add('hidden');
            
            generateFood();
            drawGame();
            updateGameStatus();
        }

        // Generate food at random position
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

        // Update game state
        function updateGame() {
            if (gamePaused || !gameRunning) return;
            
            moveSnake();
            
            if (checkCollision()) {
                gameOver();
                return;
            }
            
            if (checkFoodCollision()) {
                score += 10;
                scoreElement.textContent = score;
                
                // Update high score
                if (score > highScore) {
                    highScore = score;
                    highScoreElement.textContent = highScore;
                    localStorage.setItem('snakeHighScore', highScore);
                }
                
                generateFood();
            }
            
            drawGame();
        }

        // Move the snake
        function moveSnake() {
            const head = { x: snake[0].x + dx, y: snake[0].y + dy };
            snake.unshift(head);
            
            // Remove tail if no food was eaten
            if (head.x !== food.x || head.y !== food.y) {
                snake.pop();
            }
        }

        // Check for collisions
        function checkCollision() {
            const head = snake[0];
            
            // Wall collision
            if (head.x < 0 || head.x >= tileCount || head.y < 0 || head.y >= tileCount) {
                return true;
            }
            
            // Self collision
            for (let i = 1; i < snake.length; i++) {
                if (head.x === snake[i].x && head.y === snake[i].y) {
                    return true;
                }
            }
            
            return false;
        }

        // Check if snake ate food
        function checkFoodCollision() {
            return snake[0].x === food.x && snake[0].y === food.y;
        }

        // Game over
        function gameOver() {
            clearInterval(gameLoop);
            gameRunning = false;
            gamePaused = false;
            autoStarted = false;
            
            finalScoreElement.textContent = score;
            gameOverDiv.classList.remove('hidden');
            
            // Reset direction
            dx = 0;
            dy = 0;
            
            updateGameStatus();
        }

        // Draw the game
        function drawGame() {
            // Clear canvas with medium grey background
            ctx.fillStyle = '#e9ecef';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Draw visible grid lines with darker grey
            ctx.strokeStyle = '#adb5bd';
            ctx.lineWidth = 1;
            for (let i = 0; i <= tileCount; i++) {
                ctx.beginPath();
                ctx.moveTo(i * gridSize, 0);
                ctx.lineTo(i * gridSize, canvas.height);
                ctx.stroke();
                
                ctx.beginPath();
                ctx.moveTo(0, i * gridSize);
                ctx.lineTo(canvas.width, i * gridSize);
                ctx.stroke();
            }
            
            // Draw snake with dark grey tones
            for (let i = 0; i < snake.length; i++) {
                const segment = snake[i];
                
                // Different colors for head and body
                if (i === 0) {
                    ctx.fillStyle = '#212529'; // Head - darkest grey
                } else {
                    ctx.fillStyle = '#343a40'; // Body - dark grey
                }
                
                ctx.fillRect(
                    segment.x * gridSize + 2,
                    segment.y * gridSize + 2,
                    gridSize - 4,
                    gridSize - 4
                );
            }
            
            // Draw food as a dark circle with light border
            ctx.fillStyle = '#495057';
            ctx.beginPath();
            ctx.arc(
                food.x * gridSize + gridSize / 2,
                food.y * gridSize + gridSize / 2,
                (gridSize / 2) - 4,
                0,
                2 * Math.PI
            );
            ctx.fill();
            
            // Add a light border to food for better visibility
            ctx.strokeStyle = '#6c757d';
            ctx.lineWidth = 2;
            ctx.stroke();
        }

        // Add some visual effects
        function drawSnakeWithGradient() {
            for (let i = 0; i < snake.length; i++) {
                const segment = snake[i];
                const alpha = 1 - (i / snake.length) * 0.6; // Fade tail
                
                if (i === 0) {
                    ctx.fillStyle = `rgba(56, 161, 105, ${alpha})`;
                } else {
                    ctx.fillStyle = `rgba(72, 187, 120, ${alpha})`;
                }
                
                ctx.fillRect(
                    segment.x * gridSize + 1,
                    segment.y * gridSize + 1,
                    gridSize - 2,
                    gridSize - 2
                );
            }
        }

        // Add particle effects for food consumption
        function createParticles(x, y) {
            const particles = [];
            for (let i = 0; i < 8; i++) {
                particles.push({
                    x: x * gridSize + gridSize / 2,
                    y: y * gridSize + gridSize / 2,
                    vx: (Math.random() - 0.5) * 4,
                    vy: (Math.random() - 0.5) * 4,
                    life: 20,
                    color: '#e53e3e'
                });
            }
            
            // Animate particles
            const animateParticles = () => {
                ctx.save();
                for (let particle of particles) {
                    if (particle.life > 0) {
                        ctx.globalAlpha = particle.life / 20;
                        ctx.fillStyle = particle.color;
                        ctx.fillRect(particle.x, particle.y, 3, 3);
                        
                        particle.x += particle.vx;
                        particle.y += particle.vy;
                        particle.life--;
                    }
                }
                ctx.restore();
                
                if (particles.some(p => p.life > 0)) {
                    requestAnimationFrame(animateParticles);
                }
            };
            
            animateParticles();
        }

        // Initialize the game when page loads
        document.addEventListener('DOMContentLoaded', init);

        // Prevent arrow keys from scrolling the page
        window.addEventListener('keydown', function(e) {
            if(['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'].includes(e.key)) {
                e.preventDefault();
            }
        });

        // Add touch support for mobile
        let touchStartX = 0;
        let touchStartY = 0;

        canvas.addEventListener('touchstart', function(e) {
            e.preventDefault();
            touchStartX = e.touches[0].clientX;
            touchStartY = e.touches[0].clientY;
        });

        canvas.addEventListener('touchend', function(e) {
            e.preventDefault();
            if (!gameRunning || gamePaused) return;
            
            const touchEndX = e.changedTouches[0].clientX;
            const touchEndY = e.changedTouches[0].clientY;
            
            const deltaX = touchEndX - touchStartX;
            const deltaY = touchEndY - touchStartY;
            
            // Minimum swipe distance to register
            const minSwipeDistance = 30;
            
            if (Math.abs(deltaX) > minSwipeDistance || Math.abs(deltaY) > minSwipeDistance) {
                if (Math.abs(deltaX) > Math.abs(deltaY)) {
                    // Horizontal swipe
                    if (deltaX > 0 && dx !== -1) {
                        dx = 1; dy = 0; // Right
                    } else if (deltaX < 0 && dx !== 1) {
                        dx = -1; dy = 0; // Left
                    }
                } else {
                    // Vertical swipe
                    if (deltaY > 0 && dy !== -1) {
                        dx = 0; dy = 1; // Down
                    } else if (deltaY < 0 && dy !== 1) {
                        dx = 0; dy = -1; // Up
                    }
                }
            }
        });
    </script>
</body>
</html>
