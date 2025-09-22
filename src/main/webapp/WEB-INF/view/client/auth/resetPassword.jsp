<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Đổi mật khẩu</title>
                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        font-family: Arial, sans-serif;
                        background: linear-gradient(to right, #667eea, #764ba2);
                        height: 100vh;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                    }

                    .login-container {
                        background: white;
                        padding: 40px;
                        border-radius: 12px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                        width: 350px;
                    }

                    h2 {
                        text-align: center;
                        margin-bottom: 20px;
                        color: #333;
                    }

                    input[type="text"],
                    input[type="password"] {
                        width: 100%;
                        padding: 12px 10px;
                        margin: 10px 0;
                        border: 1px solid #ccc;
                        border-radius: 6px;
                    }

                    button {
                        width: 100%;
                        padding: 12px;
                        background-color: #667eea;
                        color: white;
                        border: none;
                        border-radius: 6px;
                        font-size: 16px;
                        cursor: pointer;
                    }

                    button:hover {
                        background-color: #5a67d8;
                    }

                    .text-center {
                        text-align: center;
                    }

                    .mt-3 {
                        margin-top: 1rem;
                    }

                    a {
                        color: #667eea;
                        text-decoration: none;
                    }

                    a:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>

            <body>
                <div class="login-container">
                    <h2>Tạo mật khẩu mới</h2>
                    <form method="post" action="/resetPassword">

                        <input type="password" name="password" id="password" path="passWord" placeholder="Mật khẩu"
                            required />
                        <input type="password" name="repeatpassword" placeholder="Nhập lại mật khẩu" required />
                        <div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        </div>

                        <input type="hidden" name="token" value="${token}" />
                        <button type="submit">Đổi mật khẩu</button>

                    </form>


                </div>
            </body>
            <script type="text/javascript">
                function passwordChecking() {
                    password = document.getElementById("password").value;
                    passwordafter = document.getElementById("repeatpassword").value;
                    if (password !== passwordafter) {
                        document.getElementById("msg").innerHTML = "Mật khẩu không khớp!";
                        return false;
                    } else {
                        document.getElementById("msg").innerHTML = "";
                        return true;
                    }
                }
            </script>

            </html>