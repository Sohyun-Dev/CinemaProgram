package DB;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.Connection;
public class DB2021Team05_ReviewDB {
	public class ReviewClass{ //�˻��� ������ �͵�
		public int review_id; //�̰� ������ ���� ��Ű�� ������ ��� ���� .. get set���帯 �����Ƽ�.... public
		public Date date;
		public String title;
		public String writer;
		public String review;
		public float score;
	}
	public class ReviewClass2{ //
		int review_id;
		Date date;
		int movie_id;
		String writer;
		String review;
		float score;
		
	}
	public ArrayList<ReviewClass> mlist;
	public ArrayList<ReviewClass> search_review(String s) { //������ �޾Ƽ� ���並 �����ش�.
		Connection conn = null; //connection ��ü ����
		PreparedStatement pstmt = null;  //SQL ���, ����
		ResultSet rs = null;    //DB ����� ���� ����
		mlist=null;
		try {
			conn=DB2021Team05_DBConn.getConnection();
			String sql="select Review_ID,DATE,Title,Writer,Review,DB2021_Review.Score"
					+ " from DB2021_Movie join DB2021_Review using(Movie_ID)"
					+ " where Title like ?"
					+ " order by DATE;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"%"+s+"%"); //�ش� �� ���� ��ȭ��  ��� ���並 �����ش�.
			rs=pstmt.executeQuery();
			mlist=new ArrayList<ReviewClass>();
			while(rs.next()) {
				ReviewClass rc = new ReviewClass();
				System.out.println(rs.getInt("Review_ID"));
				rc.review_id=rs.getInt("Review_ID");
				rc.date=rs.getDate("DATE");
				rc.title=rs.getString("Title");
				rc.writer=rs.getString("Writer");
				rc.review=rs.getString("Review");
				rc.score=rs.getFloat("Score");
				mlist.add(rc);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		} finally { //��� ���� DB�� ���������� conn�� �ý����� ���� ��� �ݾ��ش�.
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
	public int find_movie_id(String s) {
		Connection conn = null; //connection ��ü ����
		PreparedStatement pstmt = null;  //SQL ���, ����
		ResultSet rs = null;  
		int id=-1;
		try {
			conn=DB2021Team05_DBConn.getConnection();

 			String sql="select Movie_ID from DB2021_Movie where Title=?;"; //��ȭid,date,����, �ۼ���, ����
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,s);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				id=rs.getInt("Movie_ID");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		} finally { //��� ���� DB�� ���������� conn�� �ý����� ���� ��� �ݾ��ش�.
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return id; //���� -1�� ��� ��ȭ�� ����.
	}
	public int insert_update_reviewScore(String tf1,String tf2,String tf3,String tf4) { //����,�ۼ���,��ȭ����,����
		if(tf4.equals("")) return -2;
		Connection conn = null; //connection ��ü ����
		PreparedStatement pstmt1 = null;  //SQL ���, ����
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		ResultSet rs = null;  
		int mv_id;
		try {
			conn=DB2021Team05_DBConn.getConnection();
 			String sql1="insert into DB2021_Review (movie_id,date,score,writer,review) values(?,?,?,?,?);"; //��ȭid,date,����, �ۼ���, ����
 			String sql2="select score,review_cnt from db2021_movie where movie_id=?;";
 			String sql3="update db2021_movie set score=? where movie_id=?;";
 			String sql4="update db2021_movie set review_cnt=? where movie_id=?;";
 			//movie_id�� �ش��ϴ� ��ȭ�� view(score,review_cnt)���� �ش� score,review_cnt�� �˾ƿ´�. 
 			//(Float.parseFloat(tf1)+score)/(review_cnt+1)��   review_cnt�� +1��   db2021_movie update
 			pstmt1=conn.prepareStatement(sql1);
 			pstmt2=conn.prepareStatement(sql2);
 			pstmt3=conn.prepareStatement(sql3);
 			pstmt4=conn.prepareStatement(sql4);
 			mv_id=find_movie_id(tf3);
 			if(mv_id==-1) return -1;
 			SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd");
 			
 			pstmt2.setInt(1,mv_id );
 			System.out.println(pstmt2);
 			rs=pstmt2.executeQuery();
 			rs.next();
 			float score=rs.getFloat("Score");
 			//System.out.println("score:"+score);
 			int review_cnt=rs.getInt("review_cnt");
 			//System.out.printf("review_cnt: %d\n",review_cnt);
 			//System.out.println(Float.parseFloat(tf1)+score);
 			score=(Float.parseFloat(tf1)+score*review_cnt)/(review_cnt+1);
 			
 			
 			//Ʈ������ ����
 			conn.setAutoCommit(false);
 			pstmt1.setInt(1, mv_id);
			pstmt1.setString(2,f.format(new Date()));
			pstmt1.setFloat(3,Float.parseFloat(tf1));
			pstmt1.setString(4,tf2);
			pstmt1.setString(5, tf4);
			pstmt3.setFloat(1,score);
			pstmt3.setInt(2,mv_id);
			pstmt4.setInt(1, review_cnt+1);
			pstmt4.setInt(2,mv_id);
			
			pstmt1.executeUpdate();
			pstmt3.executeUpdate();
			pstmt4.executeUpdate();


			conn.commit();
		}catch (SQLException e) {
			e.printStackTrace();
			try {
				if(conn!=null) //������ ����� ����Ǿ������ rollback()����
					conn.rollback();
			}catch(SQLException se2) {
				se2.printStackTrace();	
			}
		}finally {
			try {
				conn.setAutoCommit(true);
				rs.close();
				pstmt1.close();
				pstmt2.close();
				pstmt3.close();
				pstmt4.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return 1;	
	}
}

