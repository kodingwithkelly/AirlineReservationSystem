package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class BookingArchive extends BaseRelation {

	public BookingArchive(Connection connection) {
		super(connection);
		// TODO Auto-generated constructor stub
	}
	
	public void archiveBooking(String cutOff) {
		try {
			String sql = "{call archiveBooking(?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setString(1, cutOff);
			statement.execute();
			statement.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public BookingArchiveResultSet[] getArchivedFlights() {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM BookingArchive;";
			Boolean hasResults = statement.execute(sql);
			List<BookingArchiveResultSet> results = new ArrayList<BookingArchiveResultSet>();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					 int uID = rs.getInt("uID");
					 int ticketID = rs.getInt("ticketID");
					 int flightID = rs.getInt("flightID");
					 int routeID = rs.getInt("routeID");
					 double totalFare = rs.getDouble("totalFare");
					 String passengerClass = rs.getString("passengerClass");
					 
					 results.add(new BookingArchiveResultSet(uID, ticketID, flightID, routeID, totalFare, passengerClass));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			BookingArchiveResultSet[] bookingArchiveArray = new BookingArchiveResultSet[results.size()];
			bookingArchiveArray = results.toArray(bookingArchiveArray);
			
			statement.close();
			
			return bookingArchiveArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
