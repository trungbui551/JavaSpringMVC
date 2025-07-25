<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Delete User ${id}</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
                    crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.min.js"
                    integrity="sha384-7qAoOXltbVP82dhxHAUje59V5r2YsVfBafyUDxEdApLPmcdhBPg1DKg1ERo0BZlK"
                    crossorigin="anonymous"></script>
            </head>

            <body>
                <div class="container mt-5">
                    <h2>User ${id} is choosed!</h2>
                    <hr />
                    <div class="alert alert-danger" role="alert">
                        Are you sure to delete this user?
                    </div>
                    <form:form class="container mx-auto mt-5" style="max-width: 500px;" action="/admin/user/delete"
                        method="post" modelAttribute="user">
                        <div class="mb-3">
                            <label class="form-label" style="display: none;">Id</label>
                            <form:input type="text" style="display: none;" class="form-control" path="id"
                                value="${id}" />

                        </div>

                        <button type="submit" class="btn btn-primary">Confirm</button>
                    </form:form>
                </div>
            </body>

            </html>