package Gui;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Vector;
import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import DB.DB2021Team05_ReviewDB;
import DB.DB2021Team05_ReviewDB.ReviewClass;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JButton;

public class DB2021Team05_ReviewGui  { //리뷰 page를 보여주는 class
   private DB2021Team05_ReviewDB rdb; //ReviewDB를 가지고 온다.
   private JPanel reviewPanel;
   public JPanel getReviewPanel() { //리뷰 패널을 넘겨준다. 
      return reviewPanel;
   }
   public void setReviewPanel(JPanel reviewPanel) {//리뷰 패널을 저장한다.
      this.reviewPanel=reviewPanel;
   }
   public DB2021Team05_ReviewGui(JFrame j) {//생성자를 정의한다. 
      reviewPanel=new JPanel();
      reviewPage();//패널을 생성해 reviewPanel에 추가한다. 
      j.add(reviewPanel);//프레임 j에 완성된 panel을 추가하낟. 
   }
   private void reviewPage(){//review page에 들어갈 패널을 생성하다. 
      BorderLayout border = new BorderLayout();
      border.setVgap(30);
      reviewPanel.setLayout(border);
      JPanel p1 = new JPanel();
      p1.setLayout(new BorderLayout());
      JPanel p2 = new JPanel();
      p2.setLayout(new BorderLayout());
      //p1은 리뷰 작성하기 (정확한 이름 입력)
      //p2는 리뷰 검색하기 
      writeReview(p1);//함수르 통해서 p1 패널에 리뷰를 작성하는 gui를 추가한다.
      searchReview(p2);//함수르 통해서 p2 패널에 리뷰를 검색하는 gui를 추가한다.
      JTabbedPane tPane = new JTabbedPane();
      tPane.addTab("리뷰 작성",p1);
      tPane.addTab("리뷰 검색", p2);
      reviewPanel.add(tPane);
      
   }
   private void writeReview(JPanel p) {// 리뷰를 작성하는 gui완성
      JPanel a=new JPanel();
      JPanel b=new JPanel();
      JTextField tf1=new JTextField(20); //score
      JTextField tf2=new JTextField(20);//작성자
      JTextField tf3=new JTextField(20); //영화 제목 입력 필드
      JTextField tf4=new JTextField(1000);//리뷰 입력 필드
      JButton bt=new JButton("등록");
      a.setLayout(new BoxLayout(a, BoxLayout.Y_AXIS));
      a.add(new JLabel("작성자"));
      a.add(tf2);  
      a.add(new JLabel("제목 입력(정확히)"));
      a.add(tf3);  
      a.add(new JLabel("평점"));
      a.add(tf1);  
      b.setLayout(new BoxLayout(b,BoxLayout.Y_AXIS));
      b.add(new JLabel("리뷰 작성"));
      b.add(tf4);
      p.add(a,BorderLayout.PAGE_START);
      p.add(b);
      p.add(bt,BorderLayout.PAGE_END);
      rdb=new DB2021Team05_ReviewDB();
      bt.addActionListener(new ActionListener() {
         @Override
         public void actionPerformed(ActionEvent e) {
            int n=0;
            n=rdb.insert_update_reviewScore(tf1.getText(),tf2.getText(),tf3.getText(),tf4.getText()); //1이면 성공 ,아닐 경우 실패
            System.out.println(n);
            if(n==-2) {
               JOptionPane.showMessageDialog(null,"리뷰를 작성하세요!","error",JOptionPane.ERROR_MESSAGE);
            }
            else if(n==-1) {
               JOptionPane.showMessageDialog(null,"등록 실패! 영화를 찾지 못했어요!","error",JOptionPane.ERROR_MESSAGE);
            }
            else if(n==0) {
               JOptionPane.showMessageDialog(null,"등록 실패! 에러가 생겼어요","error",JOptionPane.ERROR_MESSAGE);
            }
            else {
               JOptionPane.showMessageDialog(null,"등록 성공!","success",JOptionPane.INFORMATION_MESSAGE);
            }
            tf1.setText("");
            tf2.setText("");
            tf3.setText("");
            tf4.setText("");
         }
      });
   }
   private void searchReview(JPanel p) {
      JPanel a=new JPanel();
      JTextField tf=new JTextField(20); //영화 제목 입력 필드
      JButton bt=new JButton("검색");
      a.setLayout(new FlowLayout(FlowLayout.CENTER));
      a.add(new JLabel("제목 입력"));
      a.add(tf);  //여기에서 값을 받아서 처리해야 한다. DB연결
      a.add(bt); //버튼 핸들링 필요
      
      //결과를 보여주는 테이블
      JTable reviewTable=new JTable();
      JPanel tablePanel=new JPanel();
      //테이블 헤더값 (컬럼)
      Vector<String> header = new Vector<String>();
      header.addElement("review_id");
      header.addElement("작성일");
      header.addElement("영화 제목");
      header.addElement("작성자");
      header.addElement("리뷰 내용");
      header.addElement("평점");
      //테이블 모델 
      DefaultTableModel model = new DefaultTableModel(header, 0);
      reviewTable.setModel(model);
      reviewTable.getColumn("리뷰 내용").setPreferredWidth(150);
      //버튼 눌리면 -->DB에서 데이터 가져와서 테이블에 데이터 넣기 
      tablePanel.add(new JScrollPane(reviewTable));
      p.add(a,BorderLayout.PAGE_START);
      p.add(tablePanel,BorderLayout.CENTER);
      rdb=new DB2021Team05_ReviewDB();
      bt.addActionListener(new ActionListener() {
         @Override
         public void actionPerformed(ActionEvent e) {
            ArrayList<ReviewClass> mlist=rdb.search_review(tf.getText());
            
            if(mlist.size()==0) {
               JOptionPane.showMessageDialog(null,"영화 제목을 다시 입력하세요!","error",JOptionPane.ERROR_MESSAGE);
               setUpdateTableData(reviewTable);
            }
            else {
               setUpdateTableData(reviewTable);
               //받아온 mlist로테이블을 update한다.
            }
            tf.setText("");
         }
      });
      
   }
   @SuppressWarnings("unchecked")
   private void setUpdateTableData(JTable Table) {
      DefaultTableModel model = (DefaultTableModel)Table.getModel();
      model.setRowCount(0);
      for(ReviewClass rc:rdb.mlist) {
         @SuppressWarnings("rawtypes")
         Vector body = new Vector();
         body.addElement(rc.review_id);
         body.addElement(rc.date);
         body.addElement(rc.title);
         body.addElement(rc.writer);
         body.addElement(rc.review);
         
         body.addElement(rc.score);
         //vector 값으로 넣어둔 행 값을 Jtable에 추가
         model.addRow(body);
      }
      //마지막으로 Jtable 값을 다시 셋팅
      Table.setModel(model);
   }
   
}