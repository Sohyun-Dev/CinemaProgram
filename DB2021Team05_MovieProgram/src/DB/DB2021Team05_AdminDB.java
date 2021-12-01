package DB;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.swing.JOptionPane;
import java.text.ParseException;

public class DB2021Team05_AdminDB {
   
   public int find_director_id(String director) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int id = -1;
         try {
               conn=DB2021Team05_DBConn.getConnection();
               String sql="select director_ID from DB2021_Director where name=?;"; //영화 제목을 조건으로 moive-id 찾기
               pstmt=conn.prepareStatement(sql);
               pstmt.setString(1,director);
               rs=pstmt.executeQuery();
               while(rs.next()) {
                  id=rs.getInt("director_ID");
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
            return id;
      }
   
   public int find_movie_id(String t) {
      Connection conn = null; //connection 객체 생성
      PreparedStatement pstmt = null;  //SQL 등록, 실행
      ResultSet rs = null;
      int id=-1;
      try {
         conn=DB2021Team05_DBConn.getConnection();

          String sql="select Movie_ID from DB2021_Movie where Title=?;"; //영화 제목을 조건으로 moive-id 찾기
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,t);
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

   public int insert_movie(String title, String genre, String date, String production, String score, String director) {
      Connection conn = null;
      PreparedStatement pstmt1 = null;
      PreparedStatement pstmt2 = null;
      PreparedStatement pstmt3 = null;
      int f=0;
      
      try {
         conn = DB2021Team05_DBConn.getConnection();
         String sql1 = "insert into DB2021_Movie (title, genre, Releasedate, production, score, review_cnt) values(?,?,?,?,?,100)";
         String sql2 = "insert into DB2021_Director (name) values(?)";
         String sql3 = "insert into DB2021_Movie_direction (movie_id, director_id) values(?, ?)";
         pstmt1 = conn.prepareStatement(sql1);
         pstmt2 = conn.prepareStatement(sql2);
         pstmt3 = conn.prepareStatement(sql3);
         
         conn.setAutoCommit(false);
         pstmt1.setString(1, title);
         pstmt1.setString(2, genre);
         pstmt1.setString(3, date);
         pstmt1.setString(4, production);
         pstmt1.setString(5, score);
         pstmt1.executeUpdate();
         if (find_director_id(director)==-1) {
            pstmt2.setString(1, director);
            pstmt2.executeUpdate();
         }
         pstmt3.setInt(1, find_movie_id(title));
         pstmt3.setInt(2, find_director_id(director));
         pstmt3.executeUpdate();  
         conn.commit();
      }
      catch (SQLException e) {
            e.printStackTrace();
            try {
            if(conn!=null) //오류가 생기고 연결되어었으면 rollback()적용
               conn.rollback();
         }catch(SQLException se2) {
            se2.printStackTrace();   
         }
         } finally { //계속 같은 DB에 연결함으로 conn은 시스템이 끝날 결우 닫아준다.
            try {
               pstmt1.close();
               pstmt2.close();
               pstmt3.close();
            } catch (SQLException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
            }
         }
      return 1;
   }
   
   public int modify_movie(String title, String genre, String date, String production) {
      if(find_movie_id(title)==-1)
           return -1;// -1라면 영화를 찾지 못한 것
      Connection conn = null;
      PreparedStatement pstmt = null;
      try {
         conn=DB2021Team05_DBConn.getConnection();
         String sql = "update DB2021_Movie set genre=? ,releaseDate=?,production=? where movie_id=?"; 
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, genre);
         pstmt.setString(2, date);
         pstmt.setString(3, production);
         pstmt.setInt(4, find_movie_id(title));
         pstmt.executeUpdate();
      }
      catch (SQLException e) {
         e.printStackTrace();
      } finally { //계속 같은 DB에 연결함으로 conn은 시스템이 끝날 결우 닫아준다.
         try {
            pstmt.close();
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
      return 1;
   }

   public int delete_review(String keyword) {
     if (keyword.equals(""))
         return 2;
     //////////////////////////////////////////////////////
      Connection conn = null; //connection 객체 생성
      PreparedStatement pstmt = null;  //SQL 등록, 실행
      PreparedStatement pstmt0 = null; 
      try {
       conn=DB2021Team05_DBConn.getConnection();
       System.out.println(keyword);
       String sql0="update DB2021_movie as m ,DB2021_Review as r "
             + "set review_cnt=review_cnt-1 ,m.score=(m.score*review_cnt-r.score)/(review_cnt-1) "
             + "where m.movie_id=r.movie_id and review like ?;";
       String sql ="delete from DB2021_Review review where review like ?";
       pstmt0=conn.prepareStatement(sql0);
       pstmt=conn.prepareStatement(sql);
         
      conn.setAutoCommit(false);
      pstmt0.setString(1,"%" + keyword +"%");
      pstmt.setString(1, "%" + keyword +"%");
      pstmt0.executeUpdate();
      pstmt.executeUpdate();
      conn.commit();
                  
      }catch (SQLException e) {
         e.printStackTrace();
         try {
            if(conn!=null) //오류가 생기고 연결되어었으면 rollback()적용
               conn.rollback();
         }catch(SQLException se2) {
            se2.printStackTrace();   
         }
      } finally { //계속 같은 DB에 연결함으로 conn은 시스템이 끝날 결우 닫아준다.
         try {
           conn.setAutoCommit(true);
            pstmt.close();
            pstmt0.close();
         } catch (SQLException e) {  
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }
      
      return 1;
   }
}