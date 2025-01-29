<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Make a Reservation</title>
</head>
<body>
	<h2>Make a Reservation</h2>

	<form action="reservation.jsp" method="post">
		<!-- Submit to the same JSP page -->
		<label for="email">Email:</label> <input type="email" id="email"
			name="email" required><br>
		<br> <label for="no_of_guests">Number of Guests:</label> <input
			type="number" id="no_of_guests" name="no_of_guests" min="1" required><br>
		<br> <label for="reservation_date">Reservation Date:</label> <input
			type="date" id="reservation_date" name="reservation_date" required><br>
		<br> <label for="reservation_time">Reservation Time:</label> <input
			type="time" id="reservation_time" name="reservation_time" required><br>
		<br> <input type="submit" value="Submit Reservation">
	</form>
</body>
</html>
