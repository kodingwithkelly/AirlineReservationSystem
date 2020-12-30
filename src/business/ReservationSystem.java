package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;


public class ReservationSystem {
	
	private Airline airline;
	private Airport airport;
	private Booking booking;
	private BookingArchive bookingArchive;
	private Flight flight;
	private Pilot pilot;
	private Route route;
	private User user;
	private Connection connection;
	
	
	public ReservationSystem(Connection connection) {
		this.connection = connection;
		airline = new Airline(connection);
		airport = new Airport(connection);
		booking = new Booking(connection);
		bookingArchive = new BookingArchive(connection);
		flight = new Flight(connection);
		pilot = new Pilot(connection);
		route = new Route(connection);
		user = new User(connection);
	}
	
	
	public Airline getAirline() {
		return airline;
	}
	
	public Airport getAirport() {
		return airport;
	}
	
	public Booking getBooking() {
		return booking;
	}
	
	public BookingArchive getBookingArchive() {
		return bookingArchive;
	}
	
	public Flight getFlight() {
		return flight;
	}
	
	public Pilot getPilot() {
		return pilot;
	}
	
	public Route getRoute() {
		return route;
	}
	
	public User getUser() {
		return user;
	}
	
	private UserResultSet[] getPassengersByClass(String sql, int fID) {
		try {
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, fID);
			List<UserResultSet> results = new ArrayList<UserResultSet>();
			Boolean hasResults = statement.execute();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int uID = rs.getInt("uID");
					String firstName = rs.getString("firstName");
					String lastName = rs.getString("lastName");
					String birthDate = rs.getString("birthDate");
					
					results.add(new UserResultSet(uID, firstName, lastName, birthDate));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			UserResultSet[] usersArray = new UserResultSet[results.size()];
			usersArray = results.toArray(usersArray);
			
			statement.close();
			
			return usersArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public UserResultSet[] getBusinessPassengers(int fID) {
		return getPassengersByClass("{call getBusinessPassengers(?)}", fID);
	}
	
	public UserResultSet[] getEconomyPassengers(int fID) {
		return getPassengersByClass("{call getEconomyPassengers(?)}", fID);
	}
	
	public UserResultSet[] getFirstClassPassengers(int fID) {
		return getPassengersByClass("{call getFirstClassPassengers(?)}", fID);
	}
	
	
	
}
