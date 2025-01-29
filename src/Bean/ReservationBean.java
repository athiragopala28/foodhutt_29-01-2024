package Bean;

public class ReservationBean {
	private int id;
	private String email;
	private int noOfGuests;
	private String reservationDate;
	private String reservationTime;

	// Constructor
	public ReservationBean(int id, String email, int noOfGuests, String reservationDate, String reservationTime) {
		this.id = id;
		this.email = email;
		this.noOfGuests = noOfGuests;
		this.reservationDate = reservationDate;
		this.reservationTime = reservationTime;
	}

	// Getters
	public int getId() {
		return id;
	}

	public String getEmail() {
		return email;
	}

	public int getNoOfGuests() {
		return noOfGuests;
	}

	public String getReservationDate() {
		return reservationDate;
	}

	public String getReservationTime() {
		return reservationTime;
	}
}