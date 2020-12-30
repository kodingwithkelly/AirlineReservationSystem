package business;

public class UserResultSet {
	
	private int uID;
	private String email;
	private String firstName;
	private String lastName;
	private String birthDate;
	
	public UserResultSet(int uID, String email) {
		this.uID = uID;
		this.email = email;
	}
	
	public UserResultSet(int uID, String firstName, String lastName, String birthDate) {
		this.uID = uID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthDate = birthDate;
	}
	
	@Override
	public String toString() {
		return String.format("UserID = %s, First Name = %s Last Name = %s, BirthDate = %s", uID, firstName, lastName, birthDate);
	}

}
