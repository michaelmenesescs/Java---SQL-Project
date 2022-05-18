package src;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Main {

	public static void main(String[] args) throws Exception {

		Connection con = getConnection();
		System.out.println("\n ->|| E_community Database Functions||<- \n");
		System.out.println("1) Query ");
		System.out.println("2) Update ");
		System.out.println("3) Insert");
		System.out.println("4) Delete ");
		System.out.println("\n ->|| SQL Repo Database Functions||<- \n");
		System.out.println("5) Execute statements from SQL Repo");
		System.out.println("6) Exit");
		
		while (true) {

			try {
				System.out.print("\n Enter Input:"); 
				InputStreamReader r = new InputStreamReader(System.in);
				BufferedReader sc = new BufferedReader(r);
				Integer ch = Integer.parseInt(sc.readLine());

				switch (ch) {
				case 1:
					try {
						System.out.println("Query function was selected");
						query(con);
					} catch (Exception e) {
						System.out.println(e);
					}
					break;
				case 2:
					try {
						System.out.println("Update function was selected");
						updateSQL(con);
					} catch (Exception e) {
						System.out.println(e);
					}

					break;
				case 3:
					try {
						System.out.println("Insert function was selected");
						insertSQL(con);
					} catch (Exception e) {
						System.out.print(e);
					}
					break;
				case 4:
					try {
						System.out.println("Delete function was selected");
						deleteSQL(con);
					} catch (Exception e) {
						System.out.println(e);
					}
				case 5:	
				try {
					System.out.println("Managing statements");
					statementManager(con);
					break;
				} catch (Exception e) {
					
				}
				
				case 6:	
					System.exit(0);
				default:
					System.out.println("Invalid Entry!\n");
				}

			} catch (Exception e) {
				System.out.println("Enter Valid Entry!");
			}
		}
	}
	
	public static void query(Connection con) throws IOException, SQLException {
		InputStreamReader p = new InputStreamReader(System.in);
		BufferedReader lin = new BufferedReader(p);
		String db = "e_community";

		changeDatabase(con, db);

		System.out.println("Enter table you wish to query: ");

		String table = lin.readLine();

		System.out.println("Enter column(s), you wish to query: ");

		String col = lin.readLine();
		
		System.out.println("Enter condition:  ");
		
		String cond = lin.readLine();
		
		String query;
		
		if (cond.isBlank()) {
			 query = "SELECT " + col + " FROM " + table + ";";

		}
		else {
			query = "SELECT " + col + " FROM " + table + " WHERE " + cond + ";";
		}
		
		System.out.println(query);

		PreparedStatement q = con.prepareStatement(query);
		ResultSet results = q.executeQuery();

		while (results.next()) {
			System.out.print(results.getString(1));
			System.out.println(" \n");

		}
		
		
	}
	
	public static void changeDatabase(Connection con, String db) throws SQLException {
		String database = "use " + db + ";";
		PreparedStatement changeDB = con.prepareStatement(database);
		changeDB.executeQuery();
	}
	
	public static void updateSQL(Connection con) throws SQLException, IOException {
		
		InputStreamReader p = new InputStreamReader(System.in);
		BufferedReader lin = new BufferedReader(p);
		String db = "e_community";

		changeDatabase(con, db);

		System.out.println("Enter table you wish to update: ");

		String table = lin.readLine();

		System.out.println("Enter column(s), you wish to set: ");

		String set = lin.readLine();
		
		System.out.println("Enter condition:  ");
		
		String cond = lin.readLine();
		
		String query;
		
		if (cond.isBlank()) {
			 query = "UPDATE " + table + " SET" + set + ";";

		}
		else {
			query = "UPDATE "+ table + " SET " + set + " WHERE " + cond + ";";
		}
		
		System.out.println(query);

		PreparedStatement q = con.prepareStatement(query);
		int rowCount = q.executeUpdate();
				
		System.out.println("Query OK, " +  rowCount + " row affected");

		
	}
	
	public static void statementManager(Connection con) throws SQLException {
		
		changeDatabase(con, "sqlrepo");
		
		String query = "SELECT statement FROM statements";
		
		PreparedStatement q = con.prepareStatement(query);
		ResultSet results = q.executeQuery();
		
		
		ArrayList<String> statements = new ArrayList<String>();

		while (results.next()) {
			String s = results.getString(1);
			statements.add(s);
		}
		
		int i = 0;
		for (String statement:statements) {
			System.out.println(i + ") - > " + statement);
			i++;
		}
		
		
		System.out.println("Enter statement to run on E_community DB:");
		
		Integer index = 0;
		
		try {
			InputStreamReader p = new InputStreamReader(System.in);
			BufferedReader sc = new BufferedReader(p);
			index = Integer.parseInt(sc.readLine());
			
		} catch (Exception e) {
			System.out.print(e);
		}
		
		String stat = statements.get(index);

		
		changeDatabase(con, "e_community");
		

		
		PreparedStatement sql = con.prepareStatement(stat);
		ResultSet repo = sql.executeQuery();
		
		
		while (repo.next()) {
			String s = repo.getString(1);
			System.out.println(s);
		}
	
		
	}
	
 	public static void insertSQL(Connection con) throws IOException, SQLException {
 		

		InputStreamReader p = new InputStreamReader(System.in);
		BufferedReader lin = new BufferedReader(p);
		
		System.out.println("Enter the table you wish to insert: ");
		
		String table = lin.readLine();

		System.out.println("Enter the values you wish to insert: ");

		String values = lin.readLine();

		PreparedStatement rpo;

		try {
			rpo = con.prepareStatement("USE e_community;");
			rpo.executeQuery();

			String statement = "INSERT INTO " + table + " values " + values + ";";
			
			System.out.println(statement);
			
			PreparedStatement createStatement = con.prepareStatement(statement);
			createStatement.execute();

			PreparedStatement getStatements = con.prepareStatement("SELECT * FROM " + table);
			ResultSet statements = getStatements.executeQuery();

			while (statements.next()) {
				System.out.print(statements.getString(1));
				System.out.println(" \n");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

 	public static void deleteSQL(Connection con) throws IOException, SQLException {
 		System.out.println("Please enter the table from which you wish to delete ");

		InputStreamReader p = new InputStreamReader(System.in);
		BufferedReader lin = new BufferedReader(p);
		String table = lin.readLine();

		System.out.println("Please enter the condition: if deleting all rows, leave blank: ");

		String condition = lin.readLine();

		System.out.println("Please enter the condition parameter: if deleting all rows, leave blank: ");

		String parameter = lin.readLine();

		PreparedStatement rpo = con.prepareStatement("USE e_community;");
		rpo.executeQuery();

		String statement;

		if (condition.isBlank() || parameter.isBlank()) {

			statement = "DELETE FROM " + table + ";";
		} else {
			statement = "DELETE FROM " + table + " WHERE " + condition + "='" + parameter + "';";
		}



		PreparedStatement createStatement = con.prepareStatement(statement);
		createStatement.execute();

		String st = "SELECT * FROM " + table + " ;";

		PreparedStatement getStatements = con.prepareStatement(st);
		ResultSet sta = getStatements.executeQuery();

		while (sta.next()) {
			System.out.print(sta.getString(1));
			System.out.println(" \n");

		}
 		
 	}
 	
	public static Connection getConnection() throws Exception {

		try {
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/";
			String username = "root";
			String password = "mikemike";
			Class.forName(driver);

			Connection conn = DriverManager.getConnection(url, username, password);
			System.out.println("Connected to " + url);

			return conn;
		}

		catch (Exception e) {
			System.out.println("Error: " + e.getMessage());
		}
		return null;

	}

}