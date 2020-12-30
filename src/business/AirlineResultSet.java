package business;

public class AirlineResultSet {
	private int airlineID;
	private String name;
	private int tailNum;
	
	public AirlineResultSet(int airlineID, String name, int tailNum) {
		this.airlineID = airlineID;
		this.name = name;
		this.tailNum = tailNum;
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getAirlineID() {
		return this.airlineID;
	}
	
	public int getTailNum() {
		return this.tailNum;
	}
	
	@Override
	public String toString() {
		return String.format("AirlineID = %s, Name = %s, TailNum = %s", airlineID, name, tailNum);
	}

}
