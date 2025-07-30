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
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .game-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }

        .game-header h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #4a5568;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .game-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 1.2em;
            font-weight: bold;
        }

        .score, .high-score {
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            box-shadow: 0 4px 15px rgba(238, 90, 82, 0.3);
        }

        .game-area {
            margin: 20px 0;
            display: flex;
            justify-content: center;
        }

        #gameCanvas {
            border: 3px solid #4a5568;
            border-radius: 10px;
            background: #2d3748;
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.3);
        }

        .game-controls {
            margin-top: 20px;
        }

        .instructions {
            background: #f7fafc;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
        }

        .instructions h3 {
            color: #4a5568;
            margin-bottom: 10px;
        }

        .instructions p {
            margin: 5px 0;
            color: #718096;
        }

        .control-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .control-buttons button {
            padding: 12px 24px;
            font-size: 1em;
            font-weight: bold;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 100px;
        }

        #startBtn {
            background: linear-gradient(45deg, #48bb78, #38a169);
            color: white;
            box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
        }

        #startBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.4);
        }

        #pauseBtn {
            background: linear-gradient(45deg, #ed8936, #dd6b20);
            color: white;
            box-shadow: 0 4px 15px rgba(237, 137, 54, 0.3);
        }

        #pauseBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(237, 137, 54, 0.4);
        }

        #resetBtn {
            background: linear-gradient(45deg, #e53e3e, #c53030);
            color: white;
            box-shadow: 0 4px 15px rgba(229, 62, 62, 0.3);
        }

        #resetBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(229, 62, 62, 0.4);
        }

        .mobile-controls {
            display: grid;
            grid-template-rows: repeat(2, 1fr);
            gap: 10px;
            max-width: 200px;
            margin: 0 auto;
        }

        .control-row {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .control-btn {
            width: 50px;
            height: 50px;
            border: none;
            border-radius: 50%;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            font-size: 1.5em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);
        }

        .control-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(102, 126, 234, 0.4);
        }

        .control-btn:active {
            transform: translateY(0);
        }

        .game-over {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            z-index: 1000;
        }

        .game-over h2 {
            color: #e53e3e;
            font-size: 2em;
            margin-bottom: 20px;
        }

        .game-over p {
            font-size: 1.2em;
            margin-bottom: 20px;
            color: #4a5568;
        }

        #playAgainBtn {
            padding: 15px 30px;
            font-size: 1.1em;
            font-weight: bold;
            border: none;
            border-radius: 25px;
            background: linear-gradient(45deg, #48bb78, #38a169);
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
        }

        #playAgainBtn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.4);
        }

        .hidden {
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .game-container {
                padding: 20px;
                margin: 10px;
            }
            
            .game-header h1 {
                font-size: 2em;
            }
            
            .game-info {
                flex-direction: column;
                gap: 10px;
            }
            
            #gameCanvas {
                width: 100%;
                max-width: 350px;
                height: auto;
            }
            
            .control-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .mobile-controls {
                display: grid;
            }
        }

        @media (min-width: 769px) {
            .mobile-controls {
                display: none;
            }
        }

        /* Animations */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .game-header h1 {
            animation: pulse 2s infinite;
        }

        @keyframes glow {
            0% { box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3); }
            50% { box-shadow: 0 4px 25px rgba(102, 126, 234, 0.6); }
            100% { box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3); }
        }

        #gameCanvas {
            animation: glow 3s infinite;
        }

        /* Map Size Selector Styles */
        .map-size-selector {
            margin-bottom: 25px;
            background: #e6f3ff;
            padding: 20px;
            border-radius: 15px;
            border: 3px solid #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        .map-size-selector h3 {
            color: #4a5568;
            margin-bottom: 15px;
            font-size: 1.3em;
            font-weight: bold;
        }

        .size-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .size-btn {
            padding: 12px 24px;
            font-size: 1.1em;
            font-weight: bold;
            border: 3px solid #667eea;
            border-radius: 25px;
            background: white;
            color: #667eea;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 100px;
            position: relative;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .size-btn:hover {
            background: #667eea;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .size-btn.active {
            background: #667eea;
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.5);
            transform: translateY(-2px);
        }

        .size-btn.active::after {
            content: '✓';
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1em;
            font-weight: bold;
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
                <h3>How to Play:</h3>
                <p>Use arrow keys or WASD to control the snake</p>
                <p>Eat the red food to grow and increase your score</p>
                <p>Don't hit the walls or yourself!</p>
            </div>
            
            <div class="map-size-selector">
                <h3>Map Size (Number of Cells):</h3>
                <div class="size-buttons">
                    <button class="size-btn" data-size="small">Small (15x15)</button>
                    <button class="size-btn active" data-size="medium">Medium (20x20)</button>
                    <button class="size-btn" data-size="large">Large (25x25)</button>
                </div>
            </div>
            
            <div class="control-buttons">
                <button id="startBtn">Start Game</button>
                <button id="pauseBtn">Pause</button>
                <button id="resetBtn">Reset</button>
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

        // Game settings - Map sizes (different number of cells, same canvas size)
        const mapSizes = {
            small: { gridSize: 30, tileCount: 15 },    // 15x15 cells, larger cells
            medium: { gridSize: 20, tileCount: 20 },   // 20x20 cells, medium cells  
            large: { gridSize: 16, tileCount: 25 }     // 25x25 cells, smaller cells
        };

        let currentMapSize = 'medium';
        let gridSize = mapSizes[currentMapSize].gridSize;
        let tileCount = mapSizes[currentMapSize].tileCount;

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
        let gameSpeed = 150; // milliseconds

        // Initialize the game
        function init() {
            console.log('Initializing Snake Game...');
            highScoreElement.textContent = highScore;
            updateCanvasSize();
            generateFood();
            drawGame();
            
            // Add event listeners
            document.addEventListener('keydown', handleKeyPress);
            document.getElementById('startBtn').addEventListener('click', startGame);
            document.getElementById('pauseBtn').addEventListener('click', togglePause);
            document.getElementById('resetBtn').addEventListener('click', resetGame);
            document.getElementById('playAgainBtn').addEventListener('click', resetGame);
            
            // Mobile controls
            document.querySelectorAll('.control-btn').forEach(btn => {
                btn.addEventListener('click', handleMobileControl);
            });

            // Map size controls - with debugging
            const sizeButtons = document.querySelectorAll('.size-btn');
            console.log('Found map size buttons:', sizeButtons.length);
            sizeButtons.forEach((btn, index) => {
                console.log(`Map button ${index}:`, btn.textContent, btn.dataset.size);
                btn.addEventListener('click', handleMapSizeChange);
            });
        }

        // Update canvas size based on selected map size
        function updateCanvasSize() {
            const size = mapSizes[currentMapSize];
            // Keep canvas size fixed at 400x400, only change grid size and tile count
            canvas.width = 400;
            canvas.height = 400;
            gridSize = size.gridSize;
            tileCount = size.tileCount;
            console.log(`Map updated: ${tileCount}x${tileCount} cells, Grid: ${gridSize}px per cell`);
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
            
            generateFood();
            drawGame();
            
            // Show confirmation
            alert(`Map size changed to ${newSize.toUpperCase()}!\nGrid: ${tileCount}x${tileCount} cells\nCell size: ${gridSize}px`);
        }

        // Handle keyboard input
        function handleKeyPress(e) {
            if (!gameRunning || gamePaused) return;
            
            const key = e.key.toLowerCase();
            
            // Prevent reverse direction and ensure snake is moving
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

        // Handle mobile controls
        function handleMobileControl(e) {
            if (!gameRunning || gamePaused) return;
            
            const direction = e.target.dataset.direction;
            
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
        }

        // Toggle pause
        function togglePause() {
            if (!gameRunning) return;
            
            gamePaused = !gamePaused;
            
            if (gamePaused) {
                clearInterval(gameLoop);
                document.getElementById('pauseBtn').textContent = 'Resume';
            } else {
                gameLoop = setInterval(updateGame, gameSpeed);
                document.getElementById('pauseBtn').textContent = 'Pause';
            }
        }

        // Reset the game
        function resetGame() {
            clearInterval(gameLoop);
            gameRunning = false;
            gamePaused = false;
            
            // Reset game state
            snake = [{ x: Math.floor(tileCount / 2), y: Math.floor(tileCount / 2) }];
            dx = 0;
            dy = 0;
            score = 0;
            scoreElement.textContent = score;
            
            // Reset UI
            document.getElementById('pauseBtn').textContent = 'Pause';
            gameOverDiv.classList.add('hidden');
            
            generateFood();
            drawGame();
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
            
            finalScoreElement.textContent = score;
            gameOverDiv.classList.remove('hidden');
            
            // Reset direction
            dx = 0;
            dy = 0;
        }

        // Draw the game
        function drawGame() {
            // Clear canvas
            ctx.fillStyle = '#2d3748';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Draw grid lines (optional)
            ctx.strokeStyle = '#4a5568';
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
            
            // Draw snake
            ctx.fillStyle = '#48bb78';
            for (let i = 0; i < snake.length; i++) {
                const segment = snake[i];
                
                // Make head slightly different
                if (i === 0) {
                    ctx.fillStyle = '#38a169';
                } else {
                    ctx.fillStyle = '#48bb78';
                }
                
                ctx.fillRect(
                    segment.x * gridSize + 1,
                    segment.y * gridSize + 1,
                    gridSize - 2,
                    gridSize - 2
                );
                
                // Add some styling to segments
                ctx.strokeStyle = '#2d3748';
                ctx.lineWidth = 2;
                ctx.strokeRect(
                    segment.x * gridSize + 1,
                    segment.y * gridSize + 1,
                    gridSize - 2,
                    gridSize - 2
                );
            }
            
            // Draw food
            ctx.fillStyle = '#e53e3e';
            ctx.beginPath();
            ctx.arc(
                food.x * gridSize + gridSize / 2,
                food.y * gridSize + gridSize / 2,
                gridSize / 2 - 2,
                0,
                2 * Math.PI
            );
            ctx.fill();
            
            // Add food glow effect
            ctx.shadowColor = '#e53e3e';
            ctx.shadowBlur = 10;
            ctx.fill();
            ctx.shadowBlur = 0;
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
