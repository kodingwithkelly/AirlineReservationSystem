package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class Flight extends BaseRelation {

	public Flight(Connection connection) {
		super(connection);
		// TODO Auto-generated constructor stub
	}
	
	private static FlightResultSet createFlightResultSetFromResultSet(ResultSet rs) throws SQLException {
		 int flightID = rs.getInt("flightID");
		 int pilotID = rs.getInt("pilotID");
		 String departureDate = rs.getString("departureDate");
		 String departureTime = rs.getString("departureTime");
		 String arrivalTime = rs.getString("arrivalTime");
		 int rid = rs.getInt("routeID");
		 int maxNumSeats = rs.getInt("maxNumSeats");
		 int status = rs.getInt("status");
		 
		 return new FlightResultSet(flightID, pilotID, departureDate, departureTime, arrivalTime, rid, maxNumSeats, status);
	}
	
	public FlightResultSet[] getFlightsByRouteID(int routeID) {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Flight WHERE routeID=" + routeID + ";";
			Boolean hasResults = statement.execute(sql);
			List<FlightResultSet> results = new ArrayList<FlightResultSet>();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					 int flightID = rs.getInt("flightID");
					 int pilotID = rs.getInt("pilotID");
					 String departureDate = rs.getString("departureDate");
					 String departureTime = rs.getString("departureTime");
					 String arrivalTime = rs.getString("arrivalTime");
					 int rid = rs.getInt("routeID");
					 int maxNumSeats = rs.getInt("maxNumSeats");
					 int status = rs.getInt("status");
					 
					 results.add(createFlightResultSetFromResultSet(rs));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightResultSet[] flightsArray = new FlightResultSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public FlightResultSet[] getAllFlights() {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Flight;";
			Boolean hasResults = statement.execute(sql);
			List<FlightResultSet> results = new ArrayList<FlightResultSet>();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					 int flightID = rs.getInt("flightID");
					 int pilotID = rs.getInt("pilotID");
					 String departureDate = rs.getString("departureDate");
					 String departureTime = rs.getString("departureTime");
					 String arrivalTime = rs.getString("arrivalTime");
					 int rid = rs.getInt("routeID");
					 int maxNumSeats = rs.getInt("maxNumSeats");
					 int status = rs.getInt("status");
					 
					 results.add(createFlightResultSetFromResultSet(rs));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightResultSet[] flightsArray = new FlightResultSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public FlightResultSet getFlightByFID(int flightID) {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Flight WHERE flightID=" + flightID + ";";
			Boolean hasResults = statement.execute(sql);
			
			if (hasResults) {
				ResultSet rs = statement.getResultSet();
				rs.next();
				return createFlightResultSetFromResultSet(rs);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public FlightInformationSet[] getFlightsByDestination(String destinCity, String destinState) {
		try {
			CallableStatement statement = connection.prepareCall("{call getFlightByDestination(?, ?)}");
			statement.setString(1, destinCity);
			statement.setString(2,  destinState);
			
			List<FlightInformationSet> results = new ArrayList<FlightInformationSet>();
			Boolean hasResults = statement.execute();
			//SELECT departureDate, al.name, f.flightID, f.routeID, originCity, originState, a2.city, a2.state, f.departureTime, f.arrivalTime
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int flightID = rs.getInt("flightID");
					int routeID = rs.getInt("routeID");
					String departureDate = rs.getString("departureDate");
					String departureTime = rs.getString("departureTime");
					String arrivalTime = rs.getString("arrivalTime");
					String originCity = rs.getString("a2.city");
					String originState = rs.getString("a2.state");
					
					results.add(new FlightInformationSet(
							departureDate, null, flightID, routeID, originCity, destinCity, destinState, originState, departureTime, arrivalTime
					));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightInformationSet[] flightsArray = new FlightInformationSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String getFlightStatus(int fID) {
		try {
			CallableStatement statement = connection.prepareCall("{call getFlightStatus(?)}");
			statement.setInt(1, fID);
			Boolean hasResults = statement.execute();

			if (hasResults) {
				ResultSet rs = statement.getResultSet();
				rs.next();
				int status = rs.getInt("status");
				
				if (status == 1) {
					return "Delayed";
				} else {
					return "Ready";
				}
			}
					
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public UserResultSet[] getSeniorAndChildrenOnFlight(int fID) {
		try {
			CallableStatement statement = connection.prepareCall("{call getSeniorAndChildren(?)}");
			statement.setInt(1, fID);
			
			List<UserResultSet> results = new ArrayList<UserResultSet>();
			Boolean hasResults = statement.execute();
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int uID = rs.getInt("u.uID");
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
	
	public FlightInformationSet[] getFlightsByOrigin(String originCity, String originState) {
		try {
			CallableStatement statement = connection.prepareCall("{call getFlightsByOrigin(?, ?)}");
			statement.setString(1, originCity);
			statement.setString(2,  originState);
			
			List<FlightInformationSet> results = new ArrayList<FlightInformationSet>();
			Boolean hasResults = statement.execute();
			//SELECT departureDate, al.name, f.flightID, f.routeID, originCity, originState, a2.city, a2.state, f.departureTime, f.arrivalTime
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int flightID = rs.getInt("flightID");
					int routeID = rs.getInt("routeID");
					String departureDate = rs.getString("departureDate");
					String departureTime = rs.getString("departureTime");
					String arrivalTime = rs.getString("arrivalTime");
					String name = rs.getString("name");
					String destinCity = rs.getString("a2.city");
					String destinState = rs.getString("a2.state");
					
					results.add(new FlightInformationSet(
							departureDate, name, flightID, routeID, originCity, destinCity, destinState, originState, departureTime, arrivalTime
					));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightInformationSet[] flightsArray = new FlightInformationSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public FlightInformationSet[] getFlightsByAirline(String airline) {
		try {
			CallableStatement statement = connection.prepareCall("{call getFlightsByAirline(?)}");
			statement.setString(1, airline);
			
			List<FlightInformationSet> results = new ArrayList<FlightInformationSet>();
			Boolean hasResults = statement.execute();
			//SELECT flightID, ar1.city, ar1.state, ar2.city, ar2.state, departureTime, arrivalTime 
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int flightID = rs.getInt("flightID");
					int routeID = rs.getInt("routeID");
					String departureTime = rs.getString("departureTime");
					String departureDate = rs.getString("departureDate");
					String arrivalTime = rs.getString("arrivalTime");
					String originCity = rs.getString("ar1.city");
					String originState = rs.getString("ar1.state");
					String destinCity = rs.getString("ar2.city");
					String destinState = rs.getString("ar2.state");
					
					results.add(new FlightInformationSet(
							departureDate, null, flightID, routeID, originCity, destinCity, destinState, originState, departureTime, arrivalTime
					));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightInformationSet[] flightsArray = new FlightInformationSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public FlightInformationSet[] getFlightsByDate(String date) {
		try {
			CallableStatement statement = connection.prepareCall("{call getFlightsByDate(?)}");
			statement.setString(1, date);
			
			List<FlightInformationSet> results = new ArrayList<FlightInformationSet>();
			Boolean hasResults = statement.execute();

			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					int flightID = rs.getInt("flightID");
					int routeID = rs.getInt("routeID");
					String departureDate = rs.getString("departureDate");
					String departureTime = rs.getString("departureTime");
					String arrivalTime = rs.getString("arrivalTime");
					String name = rs.getString("name");
					String originCity = rs.getString("originCity");
					String originState = rs.getString("originState");
					String destinCity = rs.getString("destinCity");
					String destinState = rs.getString("destinState");
					
					results.add(new FlightInformationSet(
							departureDate, name, flightID, routeID, originCity, destinCity, destinState, originState, departureTime, arrivalTime
					));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			FlightInformationSet[] flightsArray = new FlightInformationSet[results.size()];
			flightsArray = results.toArray(flightsArray);
			
			statement.close();
			
			return flightsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int getNumPassengers(int fID) {
		try {
			String sql = "{call getNumPassenger(?, ?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, fID);
			statement.registerOutParameter(2, Types.INTEGER);
			statement.execute();
			int numPassengers = statement.getInt("numPassengers");
			statement.close();
			return numPassengers;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int getNumAvailableSeats(int flightID) {
		try {
			String sql = "{call getNumAvailableSeats(?, ?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, flightID);
			statement.registerOutParameter(2, Types.INTEGER);
			statement.execute();
			int numAvailableSeats = statement.getInt("numAvailableSeats");
			statement.close();
			return numAvailableSeats;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	
}
