<html>
<title>Upload Image</title>
<body>
	<H1>Upload Image</H1>
        <%
        if (!request.isRequestedSessionIdValid()){
            out.print("Appropriate authorization required."); 
            return;
        }
        String auth = (String) session.getAttribute("class");
        if (auth == null) {
            auth = "null";
        }
        if(auth.equals("r")) {
        %>
	<form name="upload-image" method="POST" enctype="multipart/form-data"
		action="UploadImage">
		<table>
			<tr>
				<th>Radiology Record ID:</th>
				<td><input name="recordID" type="text" pattern="[0-9]+"
					title="ID number"></td>
			</tr>
		</table>
		Please input or select the path of the image:
		<table>
			<tr>
				<th>File path:</th>
				<td><input name="file-path" type="file" size="30"></input></td>
			</tr>
			<tr>
				<td ALIGN=LEFT COLSPAN="2"><input type="submit" name="Isubmit"
					value="Upload"></td>
			</tr>
		</table>
	</form>
	<%
		
        }
        else {
            out.print("Appropriate authorization required.");     
        }
	%>

</body>
</html>

