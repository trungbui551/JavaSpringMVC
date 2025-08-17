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
                        <main>
                            <div>
                                <h1 class="mt-5">Create a Product</h1>
                            </div>
                            <hr />
                        </main>
                        <div class="container mt-5">
                            <div class="row">

                                <form:form class="container mx-auto mt-5" style="max-width: 500px;"
                                    action="/admin/product/create" method="post" modelAttribute="newProduct"
                                    enctype="multipart/form-data">
                                    <div class="row">

                                        <div class="mb-3 col-12 col-md-6">
                                            <c:set var="nameError">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Name:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty nameError ? 'is-invalid' : ''}"
                                                path="name" />

                                            ${nameError}
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <c:set var="priceError">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Price:</label>
                                            <form:input type="number"
                                                class="form-control ${not empty priceError ? 'is-invalid' : ''}"
                                                path="price" />

                                            ${priceError}
                                        </div>
                                    </div>

                                    <div class="row">
                                        <c:set var="detailDescError">
                                            <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Detail Descripton:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty detailDescError ? 'is-invalid' : ''}"
                                            path="detailDesc" />

                                        ${detailDescError}
                                    </div>
                                    <div class="row">


                                        <div class="mb-3 col-12 col-md-6">
                                            <c:set var="shortDetailError">
                                                <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Short Description:</label>
                                            <form:input type="text"
                                                class="form-control ${not empty shortDetailError ? 'is-invalid' : ''}"
                                                path="shortDesc" />

                                            ${shortDetailError}
                                        </div>


                                        <div class="mb-3 col-12 col-md-6">
                                            <c:set var="quantityError">
                                                <form:errors path="quantity" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label">Quantity:</label>
                                            <form:input type="number"
                                                class="form-control ${not empty quantityError ? 'is-invalid' : ''}"
                                                path="quantity" />

                                            ${quantityError}
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Factory:</label>

                                            <form:select class="form-select" path="factory">

                                                <form:option value="Apple">Apple(MACBOOK)</form:option>
                                                <form:option value="SUS">SUS</form:option>
                                                <form:option value="ALENOVO">ALENOVO</form:option>
                                                <form:option value="DELL">DELL</form:option>

                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Target:</label>

                                            <form:select class="form-select" path="target">

                                                <form:option value="Gaming">Gaming</form:option>
                                                <form:option value="Business">Business</form:option>
                                                <form:option value="Student">Student</form:option>
                                                <form:option value="Design">Design</form:option>

                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="avatarFile" class="form-label" class="mb-3 col-12 col-md-6">Image:
                                        </label>
                                        <input class="form-control" type="file" id="avatarFile"
                                            accept=".png, jpg, .jpeg" name="trungImg">
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <img style="max-height: 250px;display: none;" alt="avatarPreview"
                                            id="avatarPreview" />
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form:form>
                            </div>
                        </div>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>

                </div>
                </div>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");

                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>

            </body>

            </html>