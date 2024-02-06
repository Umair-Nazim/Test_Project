package Demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

public class Main {

	private static final Logger LGR = Logger.getLogger(Main.class);
	public static void main(String[] args) {
		Map<String, String> map = null;
		map.put("1", "majid");
		map.put("2", "aziz");
		map.put("3", "Nazim");
		itMap(map);
		
		 try {
            FileOutputStream fos = new FileOutputStream("");
            fos.write(fileData);
            fos.close();
        } catch (java.io.IOException e) {
            
        }
	}
	
	private static void itMap(Map<String, String> map) {
		for (Entry<String, String> string : map.entrySet()) {
			LGR.info(LGR.isInfoEnabled() ?  string : null);
		}
		
		
	}
	
	public static String fetchQuestionDesc(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	public static String fetchQuestionDesc(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	
	public static String fetchQuestionDesc1(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}

	public static String fetchQuestionDesc2(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	
	public static String fetchQuestionDesc3(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	public static String fetchQuestionDesc4(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}

	public static String fetchQuestionDesc5(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	
	public static String fetchQuestionDesc6(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
	public static String fetchQuestionDesc7(String questionCode, Connection siConnection) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rs = null;
		int index = 0;
		String questDesc = null;
		String statement = "select * from questions where question_code = ?";
		try {
			LGR.info(LGR.isInfoEnabled() ? "Fetching question desc :- "+questionCode+" using query:- "+ statement : null);
			pStmt = siConnection.prepareStatement(statement);
			pStmt.setString(++index, questionCode);			
			rs = pStmt.executeQuery();
			if (rs.next()){
				questDesc = rs.getString(1);
			} 
		}catch(Exception e) {
			LGR.error(e);
		}

		
		return questDesc;
	}
}
