package business;

public class BookingResultSet {
	
	private int uid;
	private int ticketId;
	private int flightId;
	private int routeId;
	private int totalFare;
	private String seatClass;
	private String updatedAt;
	
	public BookingResultSet(int uid, int ticketId, int flightId, int routeId, int totalFare, String seatClass, String updatedAt) {
		this.uid = uid;
		this.ticketId = ticketId;
		this.flightId = flightId;
		this.routeId = routeId;
		this.totalFare = totalFare;
		this.seatClass = seatClass;
		this.updatedAt = updatedAt;
	}

	public int getTotalFare() {
		return totalFare;
	}

	public int getFlightId() {
		return flightId;
	}

	public int getTicketId() {
		return ticketId;
	}

	public int getUid() {
		return uid;
	}

	public int getRouteId() {
		return routeId;
	}

	public String getSeatClass() {
		return seatClass;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

}
