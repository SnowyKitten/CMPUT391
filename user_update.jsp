<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
    <head>
        <title>User Password Update</title>
    </head>
    <body>
        <%
        //HttpSession session = request.getSession(true);
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required. adopted"); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        if (auth == null) {
            auth = "null";
        } 
        if(auth.equals("a") || auth.equals("r") || auth.equals("d") || auth.equals("p")) {
        %>

    <form name="updatepersonsubmit" method="post" action="updatepersonsubmit">
        <table>

            <input name="person_id" type ="hidden" value =<%out.println(session.getAttribute("pid"));%>></input>

            <tr>
                <th>Update First Name: </th>
                <td>
                <input name="firstname" type="text" size="30" value=""></input></td>
            </tr>

            <tr>
                <th>Update Last Name: </th>
                <td><input name="lastname" type="text" size="30" value=""></input></td>
            </tr>

            <tr>
                <th>Update Address: </th>
                <td><input name="address" type="text" size="30" value=""></input></td>
            </tr>

            <tr>
                <th>Update Email: </th>
                <td><input name="email" type="text" size="30" value=""></input></td>
            </tr>

            <tr><tr>
                <th>Update Phone: </th>
                <td><input name="phone" type="text" size="30" value=""></input></td>
            </tr>

            <td ALIGN=CENTER COLSPAN="2">
                <input type="submit" name=".submit" value="Enter"></td>
            </tr>
        </table>
    </form>
    
    <br><br><br><br>
    <form name="updatepass" method="post" action="updatepassword">
        <table>
            <input name="person_id" type ="hidden" value =<%out.println(session.getAttribute("pid"));%>></input>
            <tr>
                <th>Update Password: </th>
                <td><input name="password" type="text" size="30" value=""></input>
                <input type="submit" name=".submit" value="Enter">
                </td>
            </tr>
        </table>
    </form>


        </table>
        <%            
        }
        else {
            out.print("Appropriate authorization required.");     
        }
        %>


    </body>
</html>        
