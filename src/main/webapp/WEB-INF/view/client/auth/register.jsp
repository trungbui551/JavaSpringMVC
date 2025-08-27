<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đăng Ký - TechStore</title>
                <!-- Bootstrap CDN -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Google Fonts -->
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap"
                    rel="stylesheet">
                <!-- FontAwesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <style>
                    :root {
                        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                        --tech-blue: #4f46e5;
                        --tech-purple: #7c3aed;
                        --tech-cyan: #06b6d4;
                        --dark-bg: #0f172a;
                        --glass-bg: rgba(255, 255, 255, 0.1);
                        --glass-border: rgba(255, 255, 255, 0.2);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Inter', sans-serif;
                        background: var(--dark-bg);
                        color: #fff;
                        min-height: 100vh;
                        overflow-x: hidden;
                        position: relative;
                    }

                    /* Animated Background */
                    .tech-background {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: -2;
                        background: linear-gradient(45deg, #0f172a 0%, #1e293b 50%, #334155 100%);
                    }

                    .circuit-pattern {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: -1;
                        opacity: 0.1;
                        background-image:
                            linear-gradient(90deg, var(--tech-cyan) 1px, transparent 1px),
                            linear-gradient(180deg, var(--tech-cyan) 1px, transparent 1px);
                        background-size: 50px 50px;
                        animation: circuitMove 20s linear infinite;
                    }

                    @keyframes circuitMove {
                        0% {
                            transform: translate(0, 0);
                        }

                        100% {
                            transform: translate(50px, 50px);
                        }
                    }

                    /* Floating Elements */
                    .tech-particles {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: -1;
                        pointer-events: none;
                    }

                    .particle {
                        position: absolute;
                        width: 4px;
                        height: 4px;
                        background: var(--tech-cyan);
                        border-radius: 50%;
                        animation: float 6s ease-in-out infinite;
                        box-shadow: 0 0 10px var(--tech-cyan);
                    }

                    @keyframes float {

                        0%,
                        100% {
                            transform: translateY(0px) rotate(0deg);
                            opacity: 0.7;
                        }

                        50% {
                            transform: translateY(-20px) rotate(180deg);
                            opacity: 1;
                        }
                    }

                    /* Main Container */
                    .register-container {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        min-height: 100vh;
                        padding: 2rem 1rem;
                    }

                    .register-card {
                        background: var(--glass-bg);
                        backdrop-filter: blur(20px);
                        border: 1px solid var(--glass-border);
                        border-radius: 24px;
                        padding: 3rem;
                        max-width: 500px;
                        width: 100%;
                        box-shadow:
                            0 25px 50px -12px rgba(0, 0, 0, 0.5),
                            0 0 0 1px rgba(255, 255, 255, 0.1);
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                        position: relative;
                        overflow: hidden;
                    }

                    .register-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 2px;
                        background: var(--primary-gradient);
                        border-radius: 24px 24px 0 0;
                    }

                    .register-card:hover {
                        transform: translateY(-5px);
                        box-shadow:
                            0 35px 70px -12px rgba(0, 0, 0, 0.6),
                            0 0 0 1px rgba(255, 255, 255, 0.2);
                    }

                    /* Header */
                    .register-header {
                        text-align: center;
                        margin-bottom: 2.5rem;
                    }

                    .register-title {
                        font-size: 2rem;
                        font-weight: 700;
                        background: var(--primary-gradient);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        margin-bottom: 0.5rem;
                        position: relative;
                    }

                    .register-subtitle {
                        color: #94a3b8;
                        font-size: 0.95rem;
                        font-weight: 400;
                    }

                    .tech-icon {
                        font-size: 3rem;
                        background: var(--primary-gradient);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        margin-bottom: 1rem;
                        animation: pulse 2s ease-in-out infinite;
                    }

                    @keyframes pulse {

                        0%,
                        100% {
                            transform: scale(1);
                        }

                        50% {
                            transform: scale(1.05);
                        }
                    }

                    /* Form Styles */
                    .form-floating {
                        position: relative;
                        margin-bottom: 1.5rem;
                    }

                    .form-control {
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid rgba(255, 255, 255, 0.15);
                        border-radius: 12px;
                        color: #fff;
                        font-size: 0.95rem;
                        padding: 1rem;
                        height: auto;
                        transition: all 0.3s ease;
                        font-family: 'Inter', sans-serif;
                    }

                    .form-control:focus {
                        background: rgba(255, 255, 255, 0.1);
                        border-color: var(--tech-cyan);
                        box-shadow:
                            0 0 0 0.2rem rgba(6, 182, 212, 0.25),
                            0 0 20px rgba(6, 182, 212, 0.3);
                        color: #fff;
                    }

                    .form-control::placeholder {
                        color: #94a3b8;
                        opacity: 1;
                    }

                    .form-label {
                        color: #e2e8f0;
                        font-weight: 500;
                        margin-bottom: 0.5rem;
                        font-size: 0.9rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .form-label i {
                        color: var(--tech-cyan);
                        width: 16px;
                    }

                    /* Input Icons */
                    .input-group {
                        position: relative;
                    }

                    .input-icon {
                        position: absolute;
                        right: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        color: #64748b;
                        z-index: 5;
                        transition: all 0.3s ease;
                    }

                    .form-control:focus+.input-icon {
                        color: var(--tech-cyan);
                    }

                    /* Error Styles */
                    .is-invalid {
                        border-color: #ef4444 !important;
                        box-shadow: 0 0 0 0.2rem rgba(239, 68, 68, 0.25) !important;
                    }

                    .invalid-feedback {
                        color: #fca5a5;
                        font-size: 0.85rem;
                        margin-top: 0.5rem;
                        display: block;
                    }

                    /* Button */
                    .btn-register {
                        background: var(--primary-gradient);
                        border: none;
                        border-radius: 12px;
                        color: #fff;
                        font-weight: 600;
                        padding: 1rem 2rem;
                        font-size: 1rem;
                        width: 100%;
                        transition: all 0.3s ease;
                        position: relative;
                        overflow: hidden;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .btn-register::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: -100%;
                        width: 100%;
                        height: 100%;
                        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                        transition: left 0.5s;
                    }

                    .btn-register:hover::before {
                        left: 100%;
                    }

                    .btn-register:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
                    }

                    .btn-register:active {
                        transform: translateY(0);
                    }

                    /* Loading State */
                    .btn-register.loading {
                        pointer-events: none;
                        opacity: 0.8;
                    }

                    .btn-register.loading::after {
                        content: '';
                        position: absolute;
                        width: 20px;
                        height: 20px;
                        border: 2px solid transparent;
                        border-top: 2px solid #fff;
                        border-radius: 50%;
                        animation: spin 1s linear infinite;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                    }

                    @keyframes spin {
                        0% {
                            transform: translate(-50%, -50%) rotate(0deg);
                        }

                        100% {
                            transform: translate(-50%, -50%) rotate(360deg);
                        }
                    }

                    /* Login Link */
                    .login-link {
                        text-align: center;
                        margin-top: 2rem;
                        padding-top: 1.5rem;
                        border-top: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .login-link a {
                        color: var(--tech-cyan);
                        text-decoration: none;
                        font-weight: 500;
                        transition: all 0.3s ease;
                    }

                    .login-link a:hover {
                        color: #67e8f9;
                        text-shadow: 0 0 10px rgba(6, 182, 212, 0.5);
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .register-card {
                            padding: 2rem 1.5rem;
                            margin: 1rem;
                            border-radius: 20px;
                        }

                        .register-title {
                            font-size: 1.75rem;
                        }

                        .tech-icon {
                            font-size: 2.5rem;
                        }
                    }

                    @media (max-width: 480px) {
                        .register-card {
                            padding: 1.5rem 1rem;
                        }

                        .register-title {
                            font-size: 1.5rem;
                        }
                    }

                    /* Success Animation */
                    .success-animation {
                        position: fixed;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        z-index: 1000;
                        pointer-events: none;
                    }

                    .checkmark {
                        width: 80px;
                        height: 80px;
                        border-radius: 50%;
                        background: var(--primary-gradient);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        animation: successPop 0.6s ease-out;
                    }

                    .checkmark i {
                        font-size: 2rem;
                        color: #fff;
                        animation: checkmarkDraw 0.3s ease-out 0.3s both;
                    }

                    @keyframes successPop {
                        0% {
                            transform: translate(-50%, -50%) scale(0);
                            opacity: 0;
                        }

                        50% {
                            transform: translate(-50%, -50%) scale(1.2);
                            opacity: 1;
                        }

                        100% {
                            transform: translate(-50%, -50%) scale(1);
                            opacity: 1;
                        }
                    }

                    @keyframes checkmarkDraw {
                        0% {
                            transform: scale(0);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Animated Background -->
                <div class="tech-background"></div>
                <div class="circuit-pattern"></div>

                <!-- Floating Particles -->
                <div class="tech-particles" id="particles"></div>

                <!-- Main Content -->
                <div class="register-container">
                    <div class="register-card">
                        <div class="register-header">
                            <div class="tech-icon">
                                <i class="fas fa-laptop-code"></i>
                            </div>
                            <h1 class="register-title">Tạo Tài Khoản</h1>
                            <p class="register-subtitle">Tham gia cộng đồng công nghệ hàng đầu</p>
                        </div>

                        <form:form method="post" modelAttribute="newRegisterDTO" action="/register"
                            class="register-form">
                            <c:set var="errorPassword">
                                <form:errors path="repeatPassword" cssClass="invalid-feedback" />
                            </c:set>
                            <c:set var="errorEmail">
                                <form:errors path="email" cssClass="invalid-feedback" />
                            </c:set>

                            <div class="row">
                                <div class="col-md-12 md-6">
                                    <div class="form-floating">
                                        <tr>
                                            <td>Tên</td>
                                            <td><label class="form-label" for="firstName">
                                                    <i class="fas fa-user" value="Tên"></i>

                                                </label>
                                                <form:input type="text" id="firstName" class="form-control"
                                                    path="firstName" placeholder="Nhập tên của bạn" />
                                            </td>
                                        </tr>
                                    </div>
                                </div>
                                <div class="col-md-12 md-6">
                                    <div class="form-floating">
                                        <tr>
                                            <td>Họ:</td>
                                            <label class="form-label" for="lastName">
                                                <i class="fas fa-user-tag"></i>

                                            </label>
                                            <form:input type="text" id="lastName" class="form-control" path="lastName"
                                                placeholder="Nhập họ của bạn" />
                                        </tr>
                                    </div>
                                </div>
                            </div>

                            <div class="form-floating">
                                <tr>
                                    Email
                                    <label class="form-label" for="email">
                                        <i class="fas fa-envelope"></i>

                                    </label>
                                    <div class="input-group">
                                        <form:input type="email" id="email"
                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                            path="email" placeholder="your@email.com" />
                                        <i class="input-icon fas fa-at"></i>
                                    </div>
                                    ${errorEmail}
                                </tr>
                            </div>

                            <div class="form-floating">
                                Mật khẩu:
                                <label class="form-label" for="password">
                                    <i class="fas fa-lock"></i>

                                </label>
                                <div class="input-group">
                                    <form:input type="password" id="password" class="form-control" path="password"
                                        placeholder="Tạo mật khẩu mạnh" />
                                    <i class="input-icon fas fa-eye-slash" id="togglePassword"
                                        style="cursor: pointer;"></i>
                                </div>
                            </div>

                            <div class="form-floating">
                                Xác nhận mật khẩu
                                <label class="form-label" for="repeatPassword">
                                    <i class="fas fa-shield-alt"></i>

                                </label>
                                <div class="input-group">
                                    <form:input type="password" id="repeatPassword"
                                        class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                        path="repeatPassword" placeholder="Nhập lại mật khẩu" />
                                    <i class="input-icon fas fa-eye-slash" id="toggleRepeatPassword"
                                        style="cursor: pointer;"></i>
                                </div>
                                ${errorPassword}
                            </div>

                            <button type="submit" class="btn btn-register" id="registerBtn">
                                <span class="btn-text">
                                    <i class="fas fa-rocket me-2"></i>
                                    Tạo Tài Khoản
                                </span>
                            </button>
                        </form:form>

                        <div class="login-link">
                            <p class="text-muted mb-0">
                                Đã có tài khoản?
                                <a href="/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>
                                    Đăng nhập ngay
                                </a>
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS CDN -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    // Create floating particles
                    function createParticles() {
                        const container = document.getElementById("particles");
                        const particleCount = window.innerWidth > 768 ? 50 : 25;

                        for (let i = 0; i < particleCount; i++) {
                            const particle = document.createElement("div");
                            particle.classList.add("particle");
                            particle.style.top = `${Math.random() * 100}vh`;
                            particle.style.left = `${Math.random() * 100}vw`;
                            particle.style.animationDuration = `${4 + Math.random() * 4}s`;
                            particle.style.animationDelay = `${Math.random() * 2}s`;

                            // Random colors
                            const colors = ['#06b6d4', '#667eea', '#764ba2', '#f093fb'];
                            particle.style.background = colors[Math.floor(Math.random() * colors.length)];
                            particle.style.boxShadow = `0 0 10px ${particle.style.background}`;

                            container.appendChild(particle);
                        }
                    }

                    // Toggle password visibility
                    function setupPasswordToggle() {
                        const togglePassword = document.getElementById('togglePassword');
                        const toggleRepeatPassword = document.getElementById('toggleRepeatPassword');
                        const password = document.getElementById('password');
                        const repeatPassword = document.getElementById('repeatPassword');

                        togglePassword.addEventListener('click', function () {
                            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                            password.setAttribute('type', type);
                            this.classList.toggle('fa-eye');
                            this.classList.toggle('fa-eye-slash');
                        });

                        toggleRepeatPassword.addEventListener('click', function () {
                            const type = repeatPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                            repeatPassword.setAttribute('type', type);
                            this.classList.toggle('fa-eye');
                            this.classList.toggle('fa-eye-slash');
                        });
                    }

                    // Form validation and submission
                    function setupFormValidation() {
                        const form = document.querySelector('form');
                        const submitBtn = document.getElementById('registerBtn');

                        form.addEventListener('submit', function (e) {
                            submitBtn.classList.add('loading');
                            submitBtn.querySelector('.btn-text').style.opacity = '0';

                            // Re-enable after 3 seconds if no redirect happens
                            setTimeout(() => {
                                submitBtn.classList.remove('loading');
                                submitBtn.querySelector('.btn-text').style.opacity = '1';
                            }, 3000);
                        });

                        // Real-time validation
                        const inputs = form.querySelectorAll('input');
                        inputs.forEach(input => {
                            input.addEventListener('blur', function () {
                                if (this.value.trim() !== '') {
                                    this.classList.add('has-value');
                                } else {
                                    this.classList.remove('has-value');
                                }
                            });

                            input.addEventListener('focus', function () {
                                this.parentElement.classList.add('focused');
                            });

                            input.addEventListener('blur', function () {
                                if (this.value.trim() === '') {
                                    this.parentElement.classList.remove('focused');
                                }
                            });
                        });
                    }

                    // Enhanced interactions
                    function setupEnhancedInteractions() {
                        // Card tilt effect on mouse move
                        const card = document.querySelector('.register-card');

                        card.addEventListener('mousemove', function (e) {
                            const rect = this.getBoundingClientRect();
                            const x = e.clientX - rect.left;
                            const y = e.clientY - rect.top;
                            const centerX = rect.width / 2;
                            const centerY = rect.height / 2;
                            const rotateX = (y - centerY) / 20;
                            const rotateY = (centerX - x) / 20;

                            this.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-5px)`;
                        });

                        card.addEventListener('mouseleave', function () {
                            this.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) translateY(0px)';
                        });

                        // Input focus effects
                        const inputs = document.querySelectorAll('.form-control');
                        inputs.forEach(input => {
                            input.addEventListener('focus', function () {
                                this.parentElement.style.transform = 'scale(1.02)';
                            });

                            input.addEventListener('blur', function () {
                                this.parentElement.style.transform = 'scale(1)';
                            });
                        });
                    }

                    // Initialize everything
                    document.addEventListener('DOMContentLoaded', function () {
                        createParticles();
                        setupPasswordToggle();
                        setupFormValidation();
                        setupEnhancedInteractions();
                    });

                    // Responsive particles
                    window.addEventListener('resize', function () {
                        document.getElementById('particles').innerHTML = '';
                        createParticles();
                    });
                </script>
            </body>

            </html>