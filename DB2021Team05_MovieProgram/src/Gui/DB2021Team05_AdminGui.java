package Gui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.LayoutManager;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.net.URL;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.BoxLayout;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.table.DefaultTableModel;

import DB.DB2021Team05_AdminDB;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JButton;

public class DB2021Team05_AdminGui extends JFrame {
   DB2021Team05_AdminDB adb;
   private JPanel adminPanel;

   JButton login0;
   JButton login1;
   JButton login2;

   JPanel window_insert;
   JPanel window_movie;
   JPanel window_review;

   public DB2021Team05_AdminGui(JFrame f) { // 생성자 정의
      adminPanel = new JPanel();
      adminMovie(); // 패널 생성해서 adminPanel에 추가
      f.add(adminPanel); // f에 완성된 패널 추가
   }

   public JPanel getAdminGui() {
      return adminPanel;
   }

   private void adminMovie() { // 관리자 권한에 해당되는 gui 

      BorderLayout border = new BorderLayout();
      border.setVgap(30);
      adminPanel.setLayout(border);

      JPanel p0 = new JPanel(); // 영화 정보 추가 패널
      p0.setLayout(new BorderLayout());
      JPanel p1 = new JPanel(); // 영화 정보 수정 패널
      p1.setLayout(new BorderLayout());
      JPanel p2 = new JPanel(); // 리뷰 삭제 패널
      p2.setLayout(new BorderLayout());

      insertMovie(p0);
      modifyMovie(p1);
      deleteReview(p2);

      JTabbedPane choicePane = new JTabbedPane(); // 세 개의 탭 추가
      choicePane.addTab("영화정보 추가", p0);
      choicePane.addTab("영화정보 수정", p1);
      choicePane.addTab("리뷰 삭제", p2);

      adminPanel.add(choicePane);

   }

   private void makeButton(String str, JPanel panel) { // 버튼을 만들어 패널에 추가하는 메서드
      JButton button = new JButton(str);
      button.setAlignmentX(CENTER_ALIGNMENT);
      panel.add(button);
   }

   private void insertMovie(JPanel p) { // 새로운 영화 정보를 삽입하는 메서드
      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("로그인 정보를 입력하고 등록하고 싶은 영화에 대한 정보를 입력하세요");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // 아이디와 패스워드를 입력하는 영역
      JTextField idText = new JTextField(20);
      JLabel pwd = new JLabel("pw");
      JTextField pwdText = new JTextField(20);
      JPanel loginPan = new JPanel();

      loginPan.add(id);
      loginPan.add(idText);
      loginPan.add(pwd);
      loginPan.add(pwdText);
      loginPan.setLayout(new FlowLayout());

      JPanel topPan = new JPanel();
      topPan.setLayout(new BorderLayout());
      topPan.add(top_tip, BorderLayout.NORTH);
      topPan.add(loginPan, BorderLayout.SOUTH);

      JLabel label = new JLabel("추가할 영화 정보 입력");
      JPanel label_panel = new JPanel();
      label_panel.add(label);

      JPanel title_panel = new JPanel();
      JPanel genre_panel = new JPanel();
      JPanel date_panel = new JPanel();
      JPanel production_panel = new JPanel();
      JPanel score_panel = new JPanel();
      JPanel director_panel = new JPanel();

      JLabel titleL = new JLabel("  영화 제목  "); // 영화 제목 입력
      JTextField titleF = new JTextField(30);
      title_panel.add(titleL);
      title_panel.add(titleF);
      title_panel.setLayout(new FlowLayout());

      String[] genre = { "드라마", "미스터리", "스릴러", "멜로", "범죄", "액션", "코미디", "판타지" };
      JLabel genreL = new JLabel("  영화 장르  "); // 영화 장르 선택 -> 콤보박스
      JComboBox genreF = new JComboBox(genre);
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JLabel dateL = new JLabel("    개봉일  "); // 개봉일(년, 월, 일) 선택

      Integer[] year = new Integer[42]; // 연도
      int j = 0;
      for (int k = 1980; k <= 2021; k++)
         year[j++] = k;

      Integer[] month = new Integer[12]; // 월
      j = 0;
      for (int k = 1; k <= 12; k++)
         month[j++] = k;

      Integer[] day = new Integer[31]; // 일
      j = 0;
      for (int k = 1; k <= 31; k++)
         day[j++] = k;

      JComboBox date_year = new JComboBox<Integer>(year); // 날짜 선택 -> 콤보박스
      JComboBox date_month = new JComboBox<Integer>(month);
      JComboBox date_day = new JComboBox<Integer>(day);
      
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JPanel datePanel = new JPanel(); // 개봉날짜 선택 패널
      datePanel.add(date_year);
      datePanel.add(date_month);
      datePanel.add(date_day);
      JTextField dateF = new JTextField(30);
      date_panel.add(dateL);
      date_panel.add(datePanel);
      date_panel.setLayout(new FlowLayout());


      JLabel productionL = new JLabel("    배급사    "); // 배급사 입력
      JTextField productionF = new JTextField(30);
      production_panel.add(productionL);
      production_panel.add(productionF);
      production_panel.setLayout(new FlowLayout());

      JLabel scoreL = new JLabel(" 영화 평점  "); // 영화 평점 입력
      JTextField scoreF = new JTextField(30);
      score_panel.add(scoreL);
      score_panel.add(scoreF);
      score_panel.setLayout(new FlowLayout());

      JLabel directorL = new JLabel("  영화 감독  "); // 영화 감독입력
      JTextField directorF = new JTextField(30);
      director_panel.add(directorL);
      director_panel.add(directorF);
      director_panel.setLayout(new FlowLayout());
      
      JPanel genreNdate = new JPanel(); // 장르 선택 패널
      genreNdate.add(genre_panel);
      genreNdate.add(date_panel);

      JPanel centerPan = new JPanel(); 
      centerPan.add(label_panel);
      centerPan.add(title_panel);

      centerPan.add(production_panel);
      centerPan.add(score_panel);
      centerPan.add(director_panel);
      centerPan.add(genreNdate);
      centerPan.setLayout(new BoxLayout(centerPan, BoxLayout.Y_AXIS));

      JButton bt = new JButton("추가"); // 창의 하단의 추가 버튼 생성
      JPanel bottomPan = new JPanel();
      bottomPan.add(bt);

      window.setLayout(new BorderLayout());
      window.add(topPan, BorderLayout.NORTH);
      window.add(centerPan, BorderLayout.CENTER);
      window.add(bottomPan, BorderLayout.SOUTH);

      p.add(window);

      adb = new DB2021Team05_AdminDB();

      bt.addActionListener(new ActionListener() {
         int n = 0;

         @Override
         public void actionPerformed(ActionEvent e) { // 추가 버튼을 눌렀을 때 발생하는 이벤트 처리
            
            int selected = genreF.getSelectedIndex();
            String selectedGenre = genre[selected]; // 콤보박스에서 장르 선택된 값 가져옴

            String strYear = String.valueOf((int) date_year.getSelectedItem()); // 콤보박스에서 선택된 년, 월, 일 가져옴
            String strMonth = String.valueOf((int) date_month.getSelectedItem());
            String strDay = String.valueOf((int) date_day.getSelectedItem());

            String strDate = strYear + "-" + strMonth + "-" + strDay;

            n = adb.insert_movie(titleF.getText(), selectedGenre, strDate, productionF.getText(),
                  scoreF.getText(), directorF.getText()); // 영화 제목, 장르, 개봉일자, 배급사, 평점, 감독 값을 인자로 처리 
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // 아이디와 비밀번호를 입력하지 않았을 경우 오류 처리
               JOptionPane.showMessageDialog(null, "빈칸을 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // 입력받은 아이디와 비밀번호 값을 INTEGER 형으로 바꿔줌
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // 아이디와 비밀번호가 일치할 경우(임의로 아이디와 비밀번호를 1234로 정해둠)
                  if (titleF.getText().isEmpty()
                        || productionF.getText().isEmpty() || scoreF.getText().isEmpty()
                        || directorF.getText().isEmpty()) { // 사용자로부터 입력받은 텍스트필드의 값이 없을 때 오류처리
                     JOptionPane.showMessageDialog(null, "빈칸을 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);

                  } else {
                     if (n == 1) {// 성공적으로 추가가 됐을 경우
                        JOptionPane.showMessageDialog(null, "추가 성공!", "success",
                              JOptionPane.INFORMATION_MESSAGE);
                     }

                  }
               } else { // 아이디와 비밀번호가 옳지 않을 때 에러처리
                  JOptionPane.showMessageDialog(null, "로그인 정보가 올바르지 않습니다!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }

            titleF.setText(""); // 텍스트필드를 모두 공백으로 처리
            productionF.setText("");
            scoreF.setText("");
            directorF.setText("");
            idText.setText("");
            pwdText.setText("");

         }

      });

   }

   private void modifyMovie(JPanel p) { // 영화 정보를 수정하는 메서드
      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("로그인 정보를 입력하고 수정하고 싶은 영화의 정보를 입력하세요");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // 아이디와 비밀번호를 입력하는 로그인 영역
      JTextField idText = new JTextField(20);
      JLabel pwd = new JLabel("pw");
      JTextField pwdText = new JTextField(20);
      JPanel loginPan = new JPanel();

      loginPan.add(id);
      loginPan.add(idText);
      loginPan.add(pwd);
      loginPan.add(pwdText);
      loginPan.setLayout(new FlowLayout());

      JPanel topPan = new JPanel();
      topPan.setLayout(new BorderLayout());
      topPan.add(top_tip, BorderLayout.NORTH);
      topPan.add(loginPan, BorderLayout.SOUTH);

      JLabel label = new JLabel("수정하고 싶은 영화 정보 입력");
      JPanel label_panel = new JPanel();
      label_panel.add(label);

      JPanel title_panel = new JPanel();
      JPanel genre_panel = new JPanel();
      JPanel date_panel = new JPanel();
      JPanel genreNdate = new JPanel();
      JPanel production_panel = new JPanel();

      JLabel titleL = new JLabel("영화 제목"); // 영화 제목 입력
      JTextField titleF = new JTextField(30);
      title_panel.add(titleL);
      title_panel.add(titleF);
      title_panel.setLayout(new FlowLayout());

      String[] genre = { "드라마", "미스터리", "스릴러", "멜로", "범죄", "액션", "코미디", "판타지" };
      JLabel genreL = new JLabel("  영화 장르  "); // 영화 장르 선택 -> 콤보박스
      JComboBox genreF = new JComboBox(genre);
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JLabel dateL = new JLabel("    개봉일  "); 

      Integer[] year = new Integer[42]; // 개봉일자 - 년
      int j = 0;
      for (int k = 1980; k <= 2021; k++)
         year[j++] = k;

      Integer[] month = new Integer[12]; // 개봉일자 - 월
      j = 0;
      for (int k = 1; k <= 12; k++)
         month[j++] = k;

      Integer[] day = new Integer[31]; // 개봉일자 - 일
      j = 0;
      for (int k = 1; k <= 31; k++)
         day[j++] = k;

      JComboBox date_year = new JComboBox<Integer>(year); // 날짜 선택 (년, 월, 일)
      JComboBox date_month = new JComboBox<Integer>(month);
      JComboBox date_day = new JComboBox<Integer>(day);

      JPanel datePanel = new JPanel(); // 영화 개봉일 선택 
      datePanel.add(date_year);
      datePanel.add(date_month);
      datePanel.add(date_day);
      JTextField dateF = new JTextField(30);
      date_panel.add(dateL);
      date_panel.add(datePanel);
      date_panel.setLayout(new FlowLayout());

      JLabel productionL = new JLabel("  배급사  "); // 배급사 입력
      JTextField productionF = new JTextField(30);
      production_panel.add(productionL);
      production_panel.add(productionF);
      production_panel.setLayout(new FlowLayout());

      genreNdate.add(genre_panel);
      genreNdate.add(date_panel);

      JPanel centerPan = new JPanel();
      centerPan.add(label_panel);
      centerPan.add(title_panel);
      centerPan.add(production_panel);
      centerPan.add(genreNdate);
      centerPan.setLayout(new BoxLayout(centerPan, BoxLayout.Y_AXIS));

      JButton bt = new JButton("수정"); // 하단의 수정 버튼
      JPanel bottomPan = new JPanel();
      bottomPan.add(bt);

      window.setLayout(new BorderLayout());
      window.add(topPan, BorderLayout.NORTH);
      window.add(centerPan, BorderLayout.CENTER);
      window.add(bottomPan, BorderLayout.SOUTH);

      p.add(window);

      adb = new DB2021Team05_AdminDB();

      bt.addActionListener(new ActionListener() { // 수정 버튼을 눌렀을 경우 발생하는 이벤트 처리
         int n = 0;

         @Override
         public void actionPerformed(ActionEvent e) {
            int selected = genreF.getSelectedIndex(); // 장르는 콤보박스에서 선택된 값 가져옴
            String selectedGenre = genre[selected];

            String strYear = String.valueOf((int) date_year.getSelectedItem()); // 개봉일은 콤보박스에서 선택된 값 가져옴(년, 월, 일)
            String strMonth = String.valueOf((int) date_month.getSelectedItem());
            String strDay = String.valueOf((int) date_day.getSelectedItem());

            String strDate = strYear + "-" + strMonth + "-" + strDay;

            n = adb.modify_movie(titleF.getText(), selectedGenre, strDate, productionF.getText()); // 영화 제목, 장르, 개봉일, 배급사 값을 인수로 처리
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // 아이디와 비밀번호를 입력하지 않을 경우 오류 처리
               JOptionPane.showMessageDialog(null, "빈칸을 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // 입력받은 아이디와 비밀번호 값을 INTEGER 값으로 바꿔줌
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // 아이디와 비밀번호가 일치할 경우(임의로 아이디와 비밀번호를 1234로 정해둠)
                  if (titleF.getText().isEmpty() || productionF.getText().isEmpty()) { // 텍스트 필드 값이 입력되지 않았을 경우 오류 처리
                     JOptionPane.showMessageDialog(null, "빈칸을 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);

                  } else {
                     if (n == 1) { // 성공적으로 수정이 될 경우
                        JOptionPane.showMessageDialog(null, "수정 성공!", "success", JOptionPane.INFORMATION_MESSAGE);
                     } else if (n == -1) { // 입력된 영화제목을 목록에서 찾지 못했을 경우 발생하는 오류 처리
                        JOptionPane.showMessageDialog(null, "수정 실패! 영화를 찾지 못했어요!", "error",
                              JOptionPane.ERROR_MESSAGE);
                     }
                  }
               } else { // 아이디와 비밀번호 정보가 옳지 않을 경우 발생하는 오류 처리
                  JOptionPane.showMessageDialog(null, "로그인 정보가 올바르지 않습니다!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }

            titleF.setText(""); // 텍스트 필드를 모두 공백으로 처리
            dateF.setText("");
            productionF.setText("");
            idText.setText("");
            pwdText.setText("");

         }

      });
   }

   private void deleteReview(JPanel p) { // 해당 키워드를 포함하는 리뷰 정보 삭제

      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("로그인 정보를 입력하고 삭제하고 싶은 리뷰 키워드를 입력하세요");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // 아이디와 비밀번호를 입력하는 로그인 영역
      JTextField idText = new JTextField(20);
      JLabel pwd = new JLabel("pw");
      JTextField pwdText = new JTextField(20);
      JPanel pan1 = new JPanel();

      pan1.add(id);
      pan1.add(idText);
      pan1.add(pwd);
      pan1.add(pwdText);
      pan1.setLayout(new FlowLayout());

      JLabel keyword = new JLabel("키워드 입력"); // 키워드 입력 영역
      JTextField keyText = new JTextField(30);
      JButton bt = new JButton("삭제"); // 삭제 버튼
      JPanel pan2 = new JPanel();

      pan2.add(keyword);
      pan2.add(keyText);
      pan2.add(bt);
      pan2.setLayout(new FlowLayout());

      JPanel topPan = new JPanel();
      topPan.setLayout(new BorderLayout());
      topPan.add(top_tip, BorderLayout.NORTH);
      topPan.add(pan1, BorderLayout.CENTER);
      topPan.add(pan2, BorderLayout.SOUTH);

      JPanel result = new JPanel(); // 입력에 대한 결과를 알려주는 영역
      JLabel resultText = new JLabel("입력 대기중");
      result.add(resultText);

      window.setLayout(new BorderLayout());
      window.add(topPan, BorderLayout.NORTH);
      window.add(result, BorderLayout.CENTER);

      p.add(window);

      adb = new DB2021Team05_AdminDB();
      bt.addActionListener(new ActionListener() { 
         int n = 0;

         @Override
         public void actionPerformed(ActionEvent e) { // 삭제 버튼을 눌렀을 경우 발생하는 이벤트 처리 
            n = adb.delete_review(keyText.getText());
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // 아이디와 비밀번호 값이 입력되지 않았을 경우 발생하는 에러 처리
               JOptionPane.showMessageDialog(null, "빈칸을 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // 아이디와 비밀번호를 입력받은 값을 integer 형으로 바꿔줌
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // 아이디와 비밀번호가 일치할 경우(임의로 아이디와 비밀번호를 1234로 정해둠)
                  if (n == 2) { // 입력받은 키워드 값이 없을 경우 발생하는 에러처리
                     JOptionPane.showMessageDialog(null, "키워드를 입력하세요!", "error", JOptionPane.ERROR_MESSAGE);

                  }

                  else if (n == 1) { // 성공적으로 삭제가 되었을 경우
                     resultText.setText(""); 
                     JOptionPane.showMessageDialog(null, "삭제가 완료되었습니다!", "success",
                           JOptionPane.INFORMATION_MESSAGE);
                  }

                  else if (n == -1) { // 해당 키워드를 리뷰에서 삭제하지 못했을 때 발생하는 에러 처리
                     JOptionPane.showMessageDialog(null, "해당 키워드를 찾을 수 없어 리뷰를 삭제하지 못하였습니다!", "error",
                           JOptionPane.ERROR_MESSAGE);
                  }
               } else { // 아이디와 패스워드 값이 옳지 않을 경우 발생하는 에러 처리
                  JOptionPane.showMessageDialog(null, "로그인 정보가 올바르지 않습니다!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }
            keyText.setText(""); // 입력받은 텍스트필드의 값을 공백으로 바꿔줌
            idText.setText("");
            pwdText.setText("");

         }

      });
   }
}