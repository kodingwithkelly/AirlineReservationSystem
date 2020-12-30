package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class Booking extends BaseRelation {

	private static final String[] USER_OPTIONS = {
		"Book flight",
		"Get bookings",
		"Cancel flight",
		"Upgrade class",
		"Exit"
	};
	
	public Booking(Connection connection) {
		super(connection);
		// TODO Auto-generated constructor stub
	}
	
	public String[] getUserOptions() {
		return USER_OPTIONS;
	}
	
	public void bookRes(int userId, int fID, int rID, String seatClass, double totalAmount) {
		try {
			String sql = "{call BookRes(?, ?, ?, ?, ?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, userId);
			statement.setInt(2, fID);
			statement.setInt(3, rID);
			statement.setDouble(4, totalAmount);
			statement.setString(5, seatClass);
			statement.execute();
			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public void cancelFlightRes(int ticketID) {
		try {
			String sql = "{call CancelFlightRes(?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, ticketID);
			statement.execute();
			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public BookingResultSet[] getUserBookings(int userId) {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Booking WHERE uID=" + userId + ";";
			Boolean hasResults = statement.execute(sql);
			List<BookingResultSet> bookingsArrayList = new ArrayList<BookingResultSet>(); 
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					
					int uid = rs.getInt("uID");
					int ticketID = rs.getInt("ticketID");
					int flightID = rs.getInt("flightID");
					int routeID = rs.getInt("routeID");
					int totalFare = rs.getInt("totalFare");
					String seatClass = rs.getString("class");
					String updatedAt = rs.getString("updatedAT");
					
					bookingsArrayList.add(new BookingResultSet(uid, ticketID, flightID, routeID, totalFare, seatClass, updatedAt));
					
				}
				hasResults = statement.getMoreResults(); 
			}
			
			BookingResultSet[] bookingsArray = new BookingResultSet[bookingsArrayList.size()];
			bookingsArray = bookingsArrayList.toArray(bookingsArray);
			
			statement.close();
			
			return bookingsArray;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public void upgradeClass(int ticketID, String newClass) {
		try {
			String sql = "{call upgradeClass(?, ?, ?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setInt(1, ticketID);
			statement.setString(2, newClass);
			statement.setInt(3, 0);
			statement.execute();
			statement.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
}
