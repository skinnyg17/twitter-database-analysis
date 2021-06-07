<%
// Author - Karthik Subbarao, Ganesh Prasad
%>

<!DOCTYPE html>
  <head>
    <title>Login</title>

  <style>
  div 
  {
  width: 320px;
  padding: 10px;
  border: 5px solid gray;
  margin: auto;
  }
  body
  {
    background-color: rgba(50, 115, 220, 0.3);
  }
  </style>
  </head>


  <body>
	<font size = 28> <center> <b> Login </b> </center> </font> <br> <br>

	<div>
	<center>
    <h3>Enter Login Details</h3> <br>
    <form action="query.jsp" method="post">
      Username:<input name="username" type= "text"/> <br>
      Password:<input name="password" type ="password"/> <br>
      <input type="submit" value="Login">


    </form>
	</center>
	</div>
  </body>
</html>