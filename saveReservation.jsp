<%@ page import="java.sql.*, Bean.ReservationBean, Dao.ReservationDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Reservation Confirmation</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #1a1a1a; /* Black background */
	margin: 0;
	padding: 0;
	color: #fff; /* White text for contrast */
}

.container {
	width: 70%;
	max-width: 600px;
	margin: 50px auto;
	padding: 30px;
	background-color: #333; /* Dark gray container */
	border-radius: 8px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
}

h2 {
	text-align: center;
	color: #e74c3c; /* Red color for the title */
	font-size: 28px;
	font-weight: bold;
}

.message {
	font-size: 18px;
	text-align: center;
	margin-top: 30px;
	font-weight: bold;
}

.success {
	color: #28a745; /* Green color for success messages */
}

.error {
	color: #e74c3c; /* Red color for error messages */
}

.reservation-details {
	margin-top: 40px;
	text-align: center;
}

.reservation-details p {
	font-size: 16px;
	margin: 8px 0;
}

.reservation-details p strong {
	color: #e74c3c; /* Red color for labels */
}

a {
	display: block;
	text-align: center;
	margin-top: 30px;
	text-decoration: none;
	background-color: transparent; /* Transparent background */
	color: #e74c3c; /* Red text color */
	padding: 12px 24px;
	font-size: 16px;
	border-radius: 6px;
	border: 2px solid #e74c3c; /* Red border */
	transition: background-color 0.3s ease, color 0.3s ease;
}

a:hover {
	background-color: #e74c3c; /* Red background on hover */
	color: white; /* White text on hover */
}

.back-link {
	margin-top: 25px;
	display: block;
	text-align: center;
	font-size: 14px;
}

.back-link a {
	color: #e74c3c; /* Red color for the link */
	font-size: 14px;
}

.back-link a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>

	<%
		// Initialize message and flag for success
		String message = "";
		boolean isSaved = false;
		String email = "";
		String noOfGuestsStr = "";
		String reservationDate = "";
		String reservationTime = "";

		// Check if the form is submitted (using POST method)
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			try {
				// Retrieve form data
				email = request.getParameter("email");
				noOfGuestsStr = request.getParameter("no_of_guests");
				reservationDate = request.getParameter("reservation_date");
				reservationTime = request.getParameter("reservation_time");

				// Validate inputs
				if (email == null || email.isEmpty()) {
					message = "Email is required!";
				} else if (noOfGuestsStr == null || noOfGuestsStr.isEmpty()) {
					message = "Number of guests is required!";
				} else if (reservationDate == null || reservationDate.isEmpty()) {
					message = "Reservation date is required!";
				} else if (reservationTime == null || reservationTime.isEmpty()) {
					message = "Reservation time is required!";
				} else {
					int noOfGuests = Integer.parseInt(noOfGuestsStr);
					ReservationBean reservation = new ReservationBean(0, email, noOfGuests, reservationDate,
							reservationTime);
					ReservationDAO reservationDAO = new ReservationDAO();
					isSaved = reservationDAO.saveReservation(reservation);

					if (isSaved) {
						message = "Reservation saved successfully!";
					} else {
						message = "Error saving the reservation.";
					}
				}

			} catch (NumberFormatException e) {
				message = "Invalid input for number of guests!";
			} catch (Exception e) {
				message = "An error occurred: " + e.getMessage();
			}
		}
	%>

	<div class="container">
		<h2>Reservation Status</h2>

		<div class="message <%=(isSaved ? "success" : "error")%>">
			<%=message%>
		</div>

		<%-- If saved successfully, show reservation details --%>
		<c:if test="${isSaved}">
			<div class="reservation-details">
				<h3>Your Reservation Details:</h3>
				<p>
					<strong>Email:</strong>
					<%=email%></p>
				<p>
					<strong>Number of Guests:</strong>
					<%=noOfGuestsStr%></p>
				<p>
					<strong>Reservation Date:</strong>
					<%=reservationDate%></p>
				<p>
					<strong>Reservation Time:</strong>
					<%=reservationTime%></p>
			</div>
		</c:if>

		<%-- Provide a back link to the reservation form --%>
		<div class="back-link">
			<a href="index.html">Go back to Reservation Form</a>
		</div>
	</div>

</body>
</html>
