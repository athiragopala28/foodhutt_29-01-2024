package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import dbconnection.DBConnection;
import Bean.ReservationBean; // Import ReservationBean

public class ReservationDAO {

	// Save reservation to the database
	public boolean saveReservation(ReservationBean reservation) {
		String query = "INSERT INTO reservations (email, no_of_guests, reservation_date, reservation_time) VALUES (?, ?, ?, ?)";
		boolean isSaved = false;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			// Set the parameters using the ReservationBean object
			preparedStatement.setString(1, reservation.getEmail());
			preparedStatement.setInt(2, reservation.getNoOfGuests());
			preparedStatement.setString(3, reservation.getReservationDate());
			preparedStatement.setString(4, reservation.getReservationTime());

			// Execute the update
			int rowsAffected = preparedStatement.executeUpdate();
			isSaved = rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isSaved;
	}

	// Update reservation in the database
	public boolean updateReservation(ReservationBean reservation) {
		String query = "UPDATE reservations SET email = ?, no_of_guests = ?, reservation_date = ?, reservation_time = ? WHERE id = ?";
		boolean isUpdated = false;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			// Set the parameters
			preparedStatement.setString(1, reservation.getEmail());
			preparedStatement.setInt(2, reservation.getNoOfGuests());
			preparedStatement.setString(3, reservation.getReservationDate());
			preparedStatement.setString(4, reservation.getReservationTime());
			preparedStatement.setInt(5, reservation.getId());

			// Execute the update
			int rowsAffected = preparedStatement.executeUpdate();
			isUpdated = rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isUpdated;
	}

	// Delete reservation from the database
	public boolean deleteReservation(int reservationId) {
		String query = "DELETE FROM reservations WHERE id = ?";
		boolean isDeleted = false;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			// Set the parameter
			preparedStatement.setInt(1, reservationId);

			// Execute the update
			int rowsAffected = preparedStatement.executeUpdate();
			isDeleted = rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isDeleted;
	}

	// Import reservation data from a CSV file
	public boolean importReservationsFromCSV(String csvFilePath) {
		String query = "INSERT INTO reservations (email, no_of_guests, reservation_date, reservation_time) VALUES (?, ?, ?, ?)";
		boolean isImported = false;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);
				BufferedReader br = new BufferedReader(new FileReader(csvFilePath))) {

			String line;
			while ((line = br.readLine()) != null) {
				String[] data = line.split(",");

				if (data.length == 4) {
					preparedStatement.setString(1, data[0]); // Email
					preparedStatement.setInt(2, Integer.parseInt(data[1])); // No of guests
					preparedStatement.setString(3, data[2]); // Reservation date
					preparedStatement.setString(4, data[3]); // Reservation time

					// Execute the update
					preparedStatement.executeUpdate();
				}
			}

			isImported = true;

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}

		return isImported;
	}
}
