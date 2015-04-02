<html>
<head>
</head>
<body>
	<div align="center">
		<%
			String image_id = request.getQueryString();
			String path2="GetBigPic?regular"+image_id;
			String path3="GetBigPic?big"+image_id;
			out.println("<img src="+ path2 + "></img>");
			out.println("<img src="+ path3 + "></img>");
			
		%>
	</div>
</body>
</html>
