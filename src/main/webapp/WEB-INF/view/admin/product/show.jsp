<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <main>
                        Manager Product
                    </main>


                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between">
                                    <h3>Product Table</h3>
                                    <a href="/admin/product/create" class="btn btn-primary">Add a Product</a>
                                </div>
                                <hr />
                                <table class="table table-hover" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price </th>
                                            <th scope="col">Short Description</th>
                                            <th scope="col">Factory</th>
                                            <th scope="col">Quantity</th>
                                        </tr>

                                    </thead>
                                    <tbody>
                                        <tr>
                                            <c:forEach var="pro" items="${pros}">
                                        <tr>
                                            <td>${pro.id}</td>
                                            <td>${pro.name}</td>
                                            <td>${pro.price}</td>
                                            <td>${pro.shortDesc}</td>
                                            <td>${pro.factory}</td>
                                            <td>${pro.quantity}</td>
                                            <td><a href="/admin/product/${pro.id}" class="btn btn-success">View</a>
                                                <a href="/admin/product/update/${pro.id}"
                                                    class="btn btn-warning mx-2">Update</a>
                                                <a href="/admin/user/product/${pro.id}"
                                                    class="btn btn-danger">Delete</a>
                                            </td>
                                        </tr>
                                        </c:forEach>


                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="js/scripts.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                crossorigin="anonymous"></script>

        </body>

        </html>