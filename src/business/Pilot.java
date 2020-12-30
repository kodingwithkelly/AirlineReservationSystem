package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Pilot extends BaseRelation {

	public Pilot(Connection connection) {
		super(connection);
		// TODO Auto-generated constructor stub
	}
	
	public String[] getAvailablePilots(int aID) {
		try {
			CallableStatement statement = connection.prepareCall("{call getAvailablePilots(?)}");
			statement.setInt(1, aID);
			
			List<String> results = new ArrayList<String>();
			Boolean hasResults = statement.execute();

			while (hasResults) {
				ResultSet rs = statement.getResultSet();
				while (rs.next()) {
					String name = rs.getString("name");
					results.add(name);
				}
				hasResults = statement.getMoreResults(); 
			}
			
			String[] pilotsArray = new String[results.size()];
			pilotsArray = results.toArray(pilotsArray);
			
			statement.close();
			
			return pilotsArray;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

}
