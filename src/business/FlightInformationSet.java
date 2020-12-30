package business;

public class FlightInformationSet {
	//departureDate, al.name, flightID, r.routeID, a1.city AS originCity, a1.state AS originState, a2.city AS destinCity,
	//a2.state as destinState, departureTime, arrivalTime
	
	private String departureDate;
	private String name;
	private int flightID;
	private int routeID;
	private String originCity;
	private String originState;
	private String destinCity;
	private String destinState;
	private String departureTime;
	private String arrivalTime;
	
	public FlightInformationSet(String departureDate, String name, int flightID, int routeID, String originCity, String destinCity, String destinState, String originState, String departureTime, String arrivalTime) {
		this.departureDate = departureDate;
		this.name = name;
		this.flightID = flightID;
		this.routeID = routeID;
		this.originCity = originCity;
		this.destinCity = destinCity;
		this.destinState = destinState;
		this.originState= originState;
		this.departureTime = departureTime;
		this.arrivalTime = arrivalTime;
	}

	public String getDepartureDate() {
		return departureDate;
	}
	
	
	public String getName() {
		return name;
	}

	public int getFlightID() {
		return flightID;
	}

	public int getRouteID() {
		return routeID;
	}

	public String getOriginCity() {
		return originCity;
	}

	public String getOriginState() {
		return originState;
	}

	public String getDestinCity() {
		return destinCity;
	}

	public String getDestinState() {
		return destinState;
	}

	public String getDepartureTime() {
		return departureTime;
	}

	public String getArrivalTime() {
		return arrivalTime;
	}
	
	@Override
	public String toString() {
		return String.format("FlightID = %s, RouteID = %s, Origin City = %s, Origin State = %s, Destination City = %s, Destination State = %s, DepartureTime = %s, Departure Date = %s, ArrivalTime = %s",
				flightID, routeID, originCity, originState, destinCity, destinState, departureTime, departureDate, arrivalTime);
	}
	
}
