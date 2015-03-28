<html>
    <head>
        <title>Logout</title>
    </head>
    <body>
        <%
            session.removeAttribute("class");
            session.removeAttribute("pid");

            response.setHeader("Refresh", "3;url=login.jsp");
        %>
    </body>
</html>
