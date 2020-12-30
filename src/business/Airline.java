package business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Airline extends BaseRelation {

	private static final String[] OPTIONS = {
			
	};
	
	public Airline(Connection connection) {
		super(connection);
	}
	
	public String[] getUserOptions() {
		return OPTIONS;
	}
	
	public String[] getAdminOptions() {
		return OPTIONS;
	}
	
	public AirlineResultSet[] getAirlineByID(int airlineID) {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Airline WHERE airlineID=" + airlineID + ";";
			Boolean hasResults = statement.execute(sql);
			List<AirlineResultSet> results = new ArrayList<AirlineResultSet>();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					 String name = rs.getString("name");
					 int tailNum = rs.getInt("tailNum");
					 
					 
					 results.add(new AirlineResultSet(airlineID, name, tailNum));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			AirlineResultSet[] airlineArray = new AirlineResultSet[results.size()];
			airlineArray = results.toArray(airlineArray);
			
			statement.close();
			
			return airlineArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public AirlineResultSet[] getAllAirlines() {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT * FROM Airline;";
			Boolean hasResults = statement.execute(sql);
			List<AirlineResultSet> results = new ArrayList<AirlineResultSet>();
			
			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					 String name = rs.getString("name");
					 int tailNum = rs.getInt("tailNum");
					 int airlineID = rs.getInt("airlineID");
					 results.add(new AirlineResultSet(airlineID, name, tailNum));
				}
				hasResults = statement.getMoreResults(); 
			}
			
			AirlineResultSet[] airlineArray = new AirlineResultSet[results.size()];
			airlineArray = results.toArray(airlineArray);
			
			statement.close();
			
			return airlineArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
}
