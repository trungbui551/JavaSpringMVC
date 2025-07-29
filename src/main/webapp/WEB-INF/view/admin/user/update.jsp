<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">

                        <div>
                            <h1 class="mt-5">Update User</h1>
                        </div>

                        <hr />
                        <div class="container">
                            <div class="row">
                                <form:form class="container mx-auto mt-5" style="max-width: 500px;"
                                    action="/admin/user/update" method="post" modelAttribute="newUser">
                                    <div class="mb-3">
                                        <label class="form-label" style="display: none;">Id</label>
                                        <form:input type="text" style="display: none;" class="form-control" path="id" />

                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Email address</label>
                                        <form:input type="email" disabled="true" class="form-control" path="email" />

                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" style="display:none;">Password</label>
                                        <form:input type="password" style="display:none;" class="form-control"
                                            path="passWord" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone Number:</label>
                                        <form:input type="text" class="form-control" path="phone" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Full Name:</label>
                                        <form:input type="text" class="form-control" path="fullName" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address:</label>
                                        <form:input type="text" class="form-control" path="address" />
                                    </div>

                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form:form>

                            </div>
                        </div>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>

                </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>

            </body>

            </html>