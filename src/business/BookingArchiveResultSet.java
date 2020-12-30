package business;

public class BookingArchiveResultSet {

	
	private int uID;
	private int ticketID;
	private int flightID;
	private int routeID;
	private double totalFare;
	private String passengerClass;
	
	public BookingArchiveResultSet(int uID, int ticketID, int flightID, int routeID, double totalFare, String passengerClass) {
		this.uID = uID;
		this.ticketID = ticketID;
		this.flightID = flightID;
		this.routeID = routeID;
		this.totalFare = totalFare;
		this.passengerClass = passengerClass;
	}
	
	
	@Override
	public String toString() {
		return String.format("UserID = %s, ticketID = %s, FlightID = %s, RouteID = %s, TotalFare = %s, PassengerClass = %s", uID, ticketID, flightID, routeID, totalFare, passengerClass);
	}

}
