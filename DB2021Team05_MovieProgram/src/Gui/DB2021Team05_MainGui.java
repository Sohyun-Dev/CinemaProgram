package Gui;
import javax.swing.JFrame;
import java.awt.event.*;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import java.sql.*;
import DB.DB2021Team05_DBConn;
public class DB2021Team05_MainGui extends JFrame implements WindowListener {
   static DB2021Team05_MainGui mainGui = null;
   Connection conn=null;
   public DB2021Team05_MainGui() {
      mainGui = this;
      DB2021Team05_MovieGui movieGui = new DB2021Team05_MovieGui(this);
      DB2021Team05_ReviewGui reviewGui = new DB2021Team05_ReviewGui(this);
      DB2021Team05_AdminGui adminGui = new DB2021Team05_AdminGui(this);

      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      JTabbedPane tPane = new JTabbedPane();
      
      JPanel p1 = new JPanel();
      JPanel p2 = new JPanel();
      JPanel p3 = new JPanel();

      tPane.addTab("영화 검색",movieGui.getMoviePanel());
      tPane.addTab("리뷰", reviewGui.getReviewPanel());
      tPane.addTab("관리자", adminGui.getAdminGui());
      this.add(tPane);
      this.setTitle("모두의 영화");
      this.setSize(500, 570);
      this.setVisible(true);
      this.addWindowListener(this);
   }
   public void windowActivated(WindowEvent e) {}
    public void windowClosed(WindowEvent e) {}
    public void windowClosing(WindowEvent e) {
       conn=DB2021Team05_DBConn.getConnection();
        try {
           if(conn!=null)
              conn.close();
      } catch (SQLException e1) {
         // TODO Auto-generated catch block
         e1.printStackTrace();
      }
        System.exit(0);
            
    }
    public void windowDeactivated(WindowEvent e) {}
    public void windowDeiconified(WindowEvent e) {}
    public void windowIconified(WindowEvent e) {}
    public void windowOpened(WindowEvent e) {}

}