package DB;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.sql.Connection;
public class DB2021Team05_ReviewDB {
	public class ReviewClass{ //검색시 보여줄 것들
		public int review_id; //이게 없으면 같은 패키지 에서만 사용 가능 .. get set만드릭 귀찮아서.... public
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
	public ArrayList<ReviewClass> search_review(String s) { //제목을 받아서 리뷰를 보여준다.
		Connection conn = null; //connection 객체 생성
		PreparedStatement pstmt = null;  //SQL 등록, 실행
		ResultSet rs = null;    //DB 결과값 받을 공간
		mlist=null;
		try {
			conn=DB2021Team05_DBConn.getConnection();
			String sql="select Review_ID,DATE,Title,Writer,Review,DB2021_Review.Score"
					+ " from DB2021_Movie join DB2021_Review using(Movie_ID)"
					+ " where Title like ?"
					+ " order by DATE;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,"%"+s+"%"); //해당 당어가 들어가는 영화의  모든 리뷰를 보여준다.
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
		} finally { //계속 같은 DB에 연결함으로 conn은 시스템이 끝날 결우 닫아준다.
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
		Connection conn = null; //connection 객체 생성
		PreparedStatement pstmt = null;  //SQL 등록, 실행
		ResultSet rs = null;  
		int id=-1;
		try {
			conn=DB2021Team05_DBConn.getConnection();

 			String sql="select Movie_ID from DB2021_Movie where Title=?;"; //영화id,date,평점, 작성자, 리뷰
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,s);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				id=rs.getInt("Movie_ID");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		} finally { //계속 같은 DB에 연결함으로 conn은 시스템이 끝날 결우 닫아준다.
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return id; //만약 -1일 경우 영화가 없다.
	}
	public int insert_update_reviewScore(String tf1,String tf2,String tf3,String tf4) { //평점,작성자,영화제목,리뷰
		if(tf4.equals("")) return -2;
		Connection conn = null; //connection 객체 생성
		PreparedStatement pstmt1 = null;  //SQL 등록, 실행
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		ResultSet rs = null;  
		int mv_id;
		try {
			conn=DB2021Team05_DBConn.getConnection();
 			String sql1="insert into DB2021_Review (movie_id,date,score,writer,review) values(?,?,?,?,?);"; //영화id,date,평점, 작성자, 리뷰
 			String sql2="select score,review_cnt from db2021_movie where movie_id=?;";
 			String sql3="update db2021_movie set score=? where movie_id=?;";
 			String sql4="update db2021_movie set review_cnt=? where movie_id=?;";
 			//movie_id에 해당하는 영화의 view(score,review_cnt)에서 해당 score,review_cnt를 알아온다. 
 			//(Float.parseFloat(tf1)+score)/(review_cnt+1)로   review_cnt를 +1로   db2021_movie update
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
 			
 			
 			//트렌젝션 시작
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
				if(conn!=null) //오류가 생기고 연결되어었으면 rollback()적용
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

