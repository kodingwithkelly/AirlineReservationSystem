package business;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class User extends BaseRelation {

	public User(Connection connection) {
		super(connection);
	}
	
	public void createUser(String firstName, String lastName, String email, String passwd, String birthDate,
			String address, String phoneNum) {
			try {
				String sql = "{call createUser(?,?,?,?,?,?,?)}";
				CallableStatement statement = connection.prepareCall(sql);
				statement.setString(1, email);
				statement.setString(2, passwd);
				statement.setString(3, birthDate);
				statement.setString(4, firstName);
				statement.setString(5, lastName);
				statement.setString(6, address);
				statement.setString(7, phoneNum);
				statement.execute();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	
	public boolean isTaken(String email) {
	
		try {
			String sql = "{call isEMAILTaken(?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setString(1, email);
			ResultSet resultSet = statement.executeQuery();
			resultSet.next(); 
			if(resultSet.getInt("result") == 1) {
				System.out.println("Email is taken, Please use a different email.");
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int getUserIdFromEmail(String email) {
		try {
			Statement statement = this.connection.createStatement();
			String sql = "SELECT uID FROM User WHERE email = " + email + ";";
			ResultSet result = statement.executeQuery(sql);
			
			result.next();
			
			if (result != null) {
				return result.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public boolean Login(String email, String passwd) {
		try {
			String sql = "{call Login(?,?)}";
			CallableStatement statement = connection.prepareCall(sql);
			statement.setString(1, email);
			statement.setString(2, passwd);
			ResultSet resultSet = statement.executeQuery();
			resultSet.next(); 
			if(resultSet.getInt("result") > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	

}
