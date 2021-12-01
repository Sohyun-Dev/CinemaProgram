package DB;

import java.sql.*;
import java.util.ArrayList;

import javax.swing.JOptionPane;

public class DB2021Team05_MovieDB {
	public class MovieClass {
		public int movie_id;
		public Date releaseDate;
		public String title;
		public String director;
		public String genre;
		public String production;
		public float score;
		public String actor;
		public String role;
		public String prize;
		public int awardYear;
	}

	public ArrayList<MovieClass> mlist;
	public String order;
	
	public String[] awardList() {					//��ȭ�� ��� ��ȯ
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] str = new String[25];				//�˳��ϰ� ũŰ�� 25�� ��´�
		int i = 0;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "SELECT DISTINCT Award FROM DB2021_Nominations;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				str[i++] = rs.getString("Award");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return str;
	}

	public String[] genreList() {										//�帣 ����Ʈ ��ȯ
		String[] genre = { "���", "�̽��͸�", "������", "���", "����", "�׼�", "�ڹ̵�", "��Ÿ��" };
		return genre;
	}
	
	public ArrayList<MovieClass> search_movie(String s) { 				//���� ��ȭ �˻��� ��� ��ȯ
		Connection conn = null; 										//DB �����ϱ�
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		mlist = null;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "";
			if (order == "Title")										//�����ټ� ����
				sql = "select * " + " from DB2021_ViewMovie" + " where Title like ?" + " order by Title ASC;";
			else if (order == "Score")
				sql = "select * " + " from DB2021_ViewMovie" + " where Title like ?" + " order by Score DESC;";
			else
				sql = "select * " + " from DB2021_ViewMovie" + " where Title like ?" + " order by releaseDate DESC;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + s + "%"); 							//�Ϻ� �˻��� �ݿ�
			rs = pstmt.executeQuery();
			order = "";
			mlist = new ArrayList<MovieClass>();
			while (rs.next()) {											//��� row�� mlist�� �����Ѵ�
				MovieClass rc = new MovieClass();
				rc.releaseDate = rs.getDate("ReleaseDate");
				rc.title = rs.getString("Title");
				rc.genre = rs.getString("Genre");
				rc.director = rs.getString("Director");
				rc.score = rs.getFloat("Score");
				mlist.add(rc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 													
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

	public ArrayList<MovieClass> search_genre(String s) { 				//�帣�� ��ȭ �˻� ��� ��ȯ
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		mlist = null;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "";
			String[] genre = { "���", "�̽��͸�", "������", "���", "����", "�׼�", "�ڹ̵�", "��Ÿ��" };

			if (order == "Title")
				sql = "select * " + " from DB2021_ViewMovie" + " where Genre= ?" + " order by Title ASC;";
			else if (order == "Score")
				sql = "select * " + " from DB2021_ViewMovie" + " where Genre= ?" + " order by Score DESC;";
			else
				sql = "select * " + " from DB2021_ViewMovie" + " where Genre= ?" + " order by releaseDate DESC;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s);
			rs = pstmt.executeQuery();
			order = "";
			mlist = new ArrayList<MovieClass>();
			while (rs.next()) {
				MovieClass rc = new MovieClass();
				rc.releaseDate = rs.getDate("ReleaseDate");
				rc.title = rs.getString("Title");
				rc.genre = rs.getString("Genre");
				rc.director = rs.getString("Director");
				rc.score = rs.getFloat("Score");
				mlist.add(rc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

	public ArrayList<MovieClass> search_actor(String s) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		mlist = null;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "";
			String sql1 = "WITH A AS (SELECT Movie_ID, DB2021_Actor.Name AS Actor, Role FROM DB2021_Movie_cast JOIN DB2021_Actor USING(Actor_ID) )"
					+ " SELECT * FROM DB2021_ViewMovie JOIN (SELECT Title, Actor, Role FROM A JOIN DB2021_Movie USING(Movie_ID)) S"
					+ " USING(Title) WHERE Actor LIKE ?";

			if (order == "Title")
				sql = sql1 + " order by Title ASC;";
			else if (order == "Score")
				sql = sql1 + " order by Score DESC;";
			else
				sql = sql1 + " order by releaseDate DESC;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + s + "%"); 
			rs = pstmt.executeQuery();
			order = "";
			mlist = new ArrayList<MovieClass>();
			while (rs.next()) {
				MovieClass rc = new MovieClass();
				rc.releaseDate = rs.getDate("ReleaseDate");
				rc.title = rs.getString("Title");
				rc.actor = rs.getString("Actor");
				rc.role = rs.getString("Role");
				rc.score = rs.getFloat("Score");
				mlist.add(rc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

	public ArrayList<MovieClass> search_director(String s) { 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		mlist = null;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "";
			String sql1 = "SELECT * FROM DB2021_ViewMovie WHERE Director LIKE ?";

			if (order == "Title")
				sql = sql1 + " order by Title ASC;";
			else if (order == "Score")
				sql = sql1 + " order by Score DESC;";
			else
				sql = sql1 + " order by releaseDate DESC;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + s + "%");
			rs = pstmt.executeQuery();
			order = "";
			mlist = new ArrayList<MovieClass>();
			while (rs.next()) {
				MovieClass rc = new MovieClass();
				rc.releaseDate = rs.getDate("ReleaseDate");
				rc.title = rs.getString("Title");
				rc.director = rs.getString("Director");
				rc.genre = rs.getString("Genre");
				rc.score = rs.getFloat("Score");
				mlist.add(rc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

	public ArrayList<MovieClass> search_award(String s) { 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		mlist = null;
		try {
			conn = DB2021Team05_DBConn.getConnection();
			String sql = "";
			String sql1 = "WITH A AS " + "(SELECT TItle, Award, Prize, YEAR "
					+ "FROM DB2021_Movie JOIN DB2021_Nominations " + "USING(Movie_ID))" + "SELECT * "
					+ "FROM DB2021_ViewMovie JOIN A " + "USING(Title) " + "WHERE Award= ?";

			if (order == "Title")
				sql = sql1 + " order by Title ASC;";
			else if (order == "Score")
				sql = sql1 + " order by prize DESC;";
			else
				sql = sql1 + " order by Year DESC;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s); 
			rs = pstmt.executeQuery();
			order = "";
			mlist = new ArrayList<MovieClass>();
			while (rs.next()) {
				MovieClass rc = new MovieClass();
				rc.awardYear = rs.getInt("Year");
				rc.title = rs.getString("Title");
				rc.director = rs.getString("Director");
				rc.genre = rs.getString("Genre");
				rc.prize = rs.getString("Prize");
				mlist.add(rc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { 
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return mlist;
	}

}//Ŭ������ ��