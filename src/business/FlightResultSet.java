package business;

public class FlightResultSet {
	private int flightID;
	private int pilotID;
	private String departureDate;
	private String departureTime;
	private String arrivalTime;
	private int routeID;
	private int maxNumSeats;
	private int status;
	
	public FlightResultSet(int flightID, int pilotID, String departureDate, String departureTime, String arrivalTime, int routeID, int maxNumSeats, int status) {
		this.flightID = flightID;
		this.pilotID = pilotID;
		this.departureDate = departureDate;
		this.departureTime = departureTime;
		this.arrivalTime = arrivalTime;
		this.routeID = routeID;
		this.maxNumSeats = maxNumSeats;
		this.status = status;
	}

	public int getFlightID() {
		return flightID;
	}

	public String getDepartureDate() {
		return departureDate;
	}

	public int getPilotID() {
		return pilotID;
	}

	public String getDepartureTime() {
		return departureTime;
	}

	public int getMaxNumSeats() {
		return maxNumSeats;
	}

	public int getStatus() {
		return status;
	}

	public int getRouteID() {
		return routeID;
	}

	public String getArrivalTime() {
		return arrivalTime;
	}
	
	/*
	 * private int flightID;
	private int pilotID;
	private String departureDate;
	private String departureTime;
	private String arrivalTime;
	private int routeID;
	private int maxNumSeats;
	private int status;
	 */
	
	@Override
    public String toString() { 
        return String.format("FlightID = %s, PilotID = %s, DepartureDate = %s, Departure Time = %s, ArrivalTime = %s, RouteID = %s, MaxNumSeats = %s, Status = %s",
        flightID, pilotID, departureDate, departureTime, arrivalTime, routeID, maxNumSeats, status); 
    }
}
