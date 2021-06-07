<%
// Author - Karthik Subbarao, Ganesh Prasad
%>

<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
  <head>
    <title>Query</title>

  <style>
  body
  {
    background-color: rgba(50, 115, 220, 0.3);
  }
  </style>
  </head>
  <body>
    <font size="28"> <b> <center> Query List </center> </b></font><br><br>

		<%
		String authcheck ="";
		String DB_URL = "jdbc:mysql://cs363winservdb:3306/Group4?allowPublicKeyRetrieval=false&useSSL=false";
		Connection conn =null;


		try {
			if(request.getParameter("username") != null && request.getParameter("password") != null)
			{
				Class.forName("com.mysql.jdbc.Driver");
				String us = "Group4";
				String pas = "363s2Group4v5543";
				conn = DriverManager.getConnection(DB_URL, us, pas);
				String ucheck = (String) request.getParameter("username");
				String pcheck = (String) request.getParameter("password");
				String mysqlstatement = "select u.userrole from userapp u where u.username = (?) and u.userpassword = SHA1((?))";

				PreparedStatement cstmt = conn.prepareStatement(mysqlstatement);
				cstmt.clearParameters();
				cstmt.setString(1,ucheck);
				cstmt.setString(2,pcheck);
				ResultSet rs = cstmt.executeQuery();
				String urole="";
					while (rs.next()) 
					{
						urole = rs.getString("userrole");
					}
				rs.close();
				if(urole.equals("admin") || urole.equals("other"))
				{
					session.setAttribute("role", urole);	
					session.setAttribute("authenticate", "yes");	
					session.setAttribute("username", request.getParameter("username"));
					session.setAttribute("password", request.getParameter("password"));
				}
				else
				{
					session.setAttribute("role", "NA");	
					session.setAttribute("authenticate", "no");	
				}

				authcheck = (String) session.getAttribute("authenticate");
			}


			authcheck = (String) session.getAttribute("authenticate");
			if(authcheck == null)
			{
				int goodbye = 0/0;
			}

			
			if(authcheck.equals("yes"))
			{

	%>
			<center>
			<h3>
			<form method="post" action="result.jsp">
			<select name="query_selector">
			<option value = 'Q1'> Query 1 </option>
			<option value = "Q2"> Query 2 </option>
			<option value = "Q3"> Query 3 </option>
			<option value = "Q6"> Query 6 </option>
			<option value = "Q10"> Query 10 </option>
			<option value = "Q15"> Query 15 </option>
			<option value = "Q23"> Query 23 </option>
			<option value = "Q27"> Query 27 </option>
			<option value = "I"> Query I </option>
			<option value = "D"> Query D </option>
			</select>
			
			<p></p>
			<input type="submit" value="Go">
			</form>
			</h3>
			</center>

	<%
			}
			else
			{
				%>
				<form action="login.jsp">
				<h2>Either the username or password are incorrect. Please try again!</h2>
				<input type="submit" value="Back"/>
				</form>
				<%
			}

		} catch (Exception e) {

			if(e.getMessage().equals("/ by zero"))
			{
			out.println("<h2>" +"Please Login First."+ "</h2>");
			}
			else
			{
			out.println("<h2>Either the username or password are incorrect. Please try again!</h2>");
			out.println("<h4>An exception occurred: " + e.getMessage()+"</h4>");
			}
	%>
	<form action="login.jsp">
		<input type="submit" value="Back"/>
	</form>
	<%
		} 
		finally 
		{
			if (conn != null) conn.close();
		}
	%>


  </body>
</html>