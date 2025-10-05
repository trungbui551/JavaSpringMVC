<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Cập Nhật Thông Tin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
                <style>
                    :root {
                        --primary-color: #84bd00;
                        --primary-dark: #6a9700;
                        --primary-light: #9dd600;
                    }

                    body {
                        background: linear-gradient(135deg, #f5f7fa 0%, #e8f5e9 100%);
                        min-height: 100vh;
                        padding: 2rem 0;
                    }

                    .profile-card {
                        background: white;
                        border-radius: 20px;
                        box-shadow: 0 10px 40px rgba(132, 189, 0, 0.1);
                        overflow: hidden;
                        max-width: 600px;
                        margin: 0 auto;
                    }

                    .profile-header {
                        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                        padding: 2rem;
                        text-align: center;
                        color: white;
                    }

                    .profile-header h2 {
                        margin: 0;
                        font-weight: 600;
                        font-size: 1.8rem;
                    }

                    .avatar-container {
                        position: relative;
                        width: 120px;
                        height: 120px;
                        margin: 1.5rem auto 0;
                    }

                    .avatar-preview {
                        width: 120px;
                        height: 120px;
                        border-radius: 50%;
                        object-fit: cover;
                        border: 4px solid white;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                    }

                    .avatar-upload-btn {
                        position: absolute;
                        bottom: 0;
                        right: 0;
                        width: 36px;
                        height: 36px;
                        background: white;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                        transition: all 0.3s;
                    }

                    .avatar-upload-btn:hover {
                        transform: scale(1.1);
                        background: var(--primary-light);
                    }

                    .avatar-upload-btn i {
                        color: var(--primary-color);
                        font-size: 16px;
                    }

                    .profile-body {
                        padding: 2rem;
                    }

                    .form-group {
                        margin-bottom: 1.5rem;
                    }

                    .form-label {
                        font-weight: 600;
                        color: #333;
                        margin-bottom: 0.5rem;
                        font-size: 0.9rem;
                    }

                    .form-control {
                        border: 2px solid #e0e0e0;
                        border-radius: 10px;
                        padding: 0.75rem 1rem;
                        transition: all 0.3s;
                    }

                    .form-control:focus {
                        border-color: var(--primary-color);
                        box-shadow: 0 0 0 0.2rem rgba(132, 189, 0, 0.15);
                    }

                    .form-control:disabled {
                        background-color: #f8f9fa;
                    }

                    .input-icon {
                        position: relative;
                    }

                    .input-icon i {
                        position: absolute;
                        left: 15px;
                        top: 50%;
                        transform: translateY(-50%);
                        color: var(--primary-color);
                    }

                    .input-icon .form-control {
                        padding-left: 45px;
                    }

                    .btn-update {
                        background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                        border: none;
                        color: white;
                        padding: 0.75rem 2rem;
                        border-radius: 10px;
                        font-weight: 600;
                        width: 100%;
                        transition: all 0.3s;
                        box-shadow: 0 4px 15px rgba(132, 189, 0, 0.3);
                    }

                    .btn-update:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(132, 189, 0, 0.4);
                    }

                    #avatarFile {
                        display: none;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <div class="profile-card">
                        <div class="profile-header">
                            <h2><i class="fas fa-user-edit me-2"></i>Cập Nhật Thông Tin</h2>

                        </div>

                        <div class="profile-body">
                            <form:form action="/client/update" method="post" modelAttribute="presentUser"
                                enctype="multipart/form-data">
                                <form:input type="hidden" path="id" />
                                <form:input type="hidden" path="passWord" />
                                <div class="avatar-container">
                                    <img src="/images/avatar/${presentUser.avatar}" alt="Avatar" class="avatar-preview"
                                        id="avatarPreview">
                                    <label for="avatarFile" class="avatar-upload-btn">
                                        <i class="fas fa-camera"></i>
                                    </label>
                                </div>

                                <div class="form-group">
                                    <label class="form-label"><i
                                            class="fas fa-envelope text-success me-2"></i>Email</label>
                                    <div class="input-icon">
                                        <i class="fas fa-at"></i>
                                        <form:input type="email" class="form-control" path="email" disabled="true" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label"><i class="fas fa-user text-success me-2"></i>Họ và
                                        Tên</label>
                                    <div class="input-icon">
                                        <i class="fas fa-signature"></i>
                                        <form:input type="text" class="form-control" path="fullName"
                                            required="required" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label"><i class="fas fa-phone text-success me-2"></i>Số Điện
                                        Thoại</label>
                                    <div class="input-icon">
                                        <i class="fas fa-mobile-alt"></i>
                                        <form:input type="text" class="form-control" path="phone" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label"><i class="fas fa-map-marker-alt text-success me-2"></i>Địa
                                        Chỉ</label>
                                    <div class="input-icon">
                                        <i class="fas fa-home"></i>
                                        <form:input type="text" class="form-control" path="address" />
                                    </div>
                                </div>

                                <input type="file" id="avatarFile" name="newimg" accept=".png,.jpg,.jpeg">

                                <button type="submit" class="btn-update">
                                    <i class="fas fa-save me-2"></i>Cập Nhật Thông Tin
                                </button>
                            </form:form>
                        </div>
                    </div>
                </div>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        $("#avatarFile").change(function (e) {
                            if (e.target.files && e.target.files[0]) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#avatarPreview").attr("src", imgURL);
                            }
                        });
                    });
                </script>
            </body>

            </html>