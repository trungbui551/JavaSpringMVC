<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Register</title>
                <!-- Bootstrap CDN -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap" rel="stylesheet">

                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        font-family: 'Orbitron', sans-serif;
                        background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
                        color: #fff;
                        height: 100vh;
                        overflow: hidden;
                    }

                    .bg-glass {
                        background: rgba(255, 255, 255, 0.05);
                        backdrop-filter: blur(15px);
                        border-radius: 15px;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
                        transition: all 0.3s ease;
                    }

                    .bg-glass:hover {
                        box-shadow: 0 0 30px rgba(0, 255, 255, 0.6);
                        transform: translateY(-3px);
                    }

                    .form-control {
                        background: transparent;
                        color: #fff;
                        border: 1px solid #6fffe9;
                    }

                    .form-control:focus {
                        box-shadow: 0 0 10px #6fffe9;
                        background-color: rgba(255, 255, 255, 0.05);
                        border-color: #6fffe9;
                    }

                    .form-label {
                        color: #6fffe9;
                    }

                    .btn-register {
                        background: linear-gradient(to right, #00c9ff, #92fe9d);
                        color: #000;
                        font-weight: bold;
                        border: none;
                        box-shadow: 0 0 15px #00ffcc;
                    }

                    .btn-register:hover {
                        box-shadow: 0 0 25px #00ffcc;
                    }

                    .particle {
                        position: absolute;
                        width: 8px;
                        height: 8px;
                        border-radius: 50%;
                        background: rgba(0, 255, 255, 0.6);
                        animation: floatParticle 5s infinite ease-in-out;
                    }

                    @keyframes floatParticle {
                        0% {
                            transform: translateY(0);
                            opacity: 1;
                        }

                        50% {
                            transform: translateY(-20px);
                            opacity: 0.6;
                        }

                        100% {
                            transform: translateY(0);
                            opacity: 1;
                        }
                    }

                    .particle-bg {
                        position: fixed;
                        width: 100%;
                        height: 100%;
                        top: 0;
                        left: 0;
                        overflow: hidden;
                        z-index: -1;
                    }
                </style>
            </head>

            <body>

                <div class="particle-bg" id="particles"></div>

                <section class="d-flex justify-content-center align-items-center vh-100">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-md-7 col-lg-6">
                                <div class="p-5 bg-glass">
                                    <h2 class="text-uppercase text-center mb-4">Create an account</h2>
                                    <form:form method="post" modelAttribute="newRegisterDTO" action="/register">
                                        <c:set var="errorPassword">
                                            <form:errors path="repeatPassword" cssClass="invalid-feedback" />
                                        </c:set>
                                        <c:set var="errorEmail">
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </c:set>
                                        <div class="mb-3">
                                            <label class="form-label" for="firstName">First Name</label>
                                            <form:input type="text" id="firstName" class="form-control"
                                                path="firstName" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="lastName">Last Name</label>
                                            <form:input type="text" id="lastName" class="form-control"
                                                path="lastName" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="email">Email</label>
                                            <form:input type="email" id="email"
                                                class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                path="email" />
                                            ${errorEmail}
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="password">Password</label>
                                            <form:input type="password" id="password" class="form-control"
                                                path="password" />
                                        </div>
                                        <div class="mb-4">
                                            <label class="form-label" for="repeatPassword">Repeat Password</label>
                                            <form:input type="password" id="repeatPassword"
                                                class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                path="repeatPassword" />
                                            ${errorPassword}
                                        </div>

                                        <div class="d-flex justify-content-center">
                                            <button type="submit" class="btn btn-register w-100">Register</button>
                                        </div>

                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Bootstrap JS CDN -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                <!-- Glowing Particle Script -->
                <script>
                    const container = document.getElementById("particles");
                    for (let i = 0; i < 40; i++) {
                        const particle = document.createElement("div");
                        particle.classList.add("particle");
                        particle.style.top = `${Math.random() * 100}vh`;
                        particle.style.left = `${Math.random() * 100}vw`;
                        particle.style.animationDuration = `${3 + Math.random() * 5}s`;
                        container.appendChild(particle);
                    }
                </script>

            </body>

            </html>