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

   public DB2021Team05_AdminGui(JFrame f) { // ������ ����
      adminPanel = new JPanel();
      adminMovie(); // �г� �����ؼ� adminPanel�� �߰�
      f.add(adminPanel); // f�� �ϼ��� �г� �߰�
   }

   public JPanel getAdminGui() {
      return adminPanel;
   }

   private void adminMovie() { // ������ ���ѿ� �ش�Ǵ� gui 

      BorderLayout border = new BorderLayout();
      border.setVgap(30);
      adminPanel.setLayout(border);

      JPanel p0 = new JPanel(); // ��ȭ ���� �߰� �г�
      p0.setLayout(new BorderLayout());
      JPanel p1 = new JPanel(); // ��ȭ ���� ���� �г�
      p1.setLayout(new BorderLayout());
      JPanel p2 = new JPanel(); // ���� ���� �г�
      p2.setLayout(new BorderLayout());

      insertMovie(p0);
      modifyMovie(p1);
      deleteReview(p2);

      JTabbedPane choicePane = new JTabbedPane(); // �� ���� �� �߰�
      choicePane.addTab("��ȭ���� �߰�", p0);
      choicePane.addTab("��ȭ���� ����", p1);
      choicePane.addTab("���� ����", p2);

      adminPanel.add(choicePane);

   }

   private void makeButton(String str, JPanel panel) { // ��ư�� ����� �гο� �߰��ϴ� �޼���
      JButton button = new JButton(str);
      button.setAlignmentX(CENTER_ALIGNMENT);
      panel.add(button);
   }

   private void insertMovie(JPanel p) { // ���ο� ��ȭ ������ �����ϴ� �޼���
      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("�α��� ������ �Է��ϰ� ����ϰ� ���� ��ȭ�� ���� ������ �Է��ϼ���");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // ���̵�� �н����带 �Է��ϴ� ����
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

      JLabel label = new JLabel("�߰��� ��ȭ ���� �Է�");
      JPanel label_panel = new JPanel();
      label_panel.add(label);

      JPanel title_panel = new JPanel();
      JPanel genre_panel = new JPanel();
      JPanel date_panel = new JPanel();
      JPanel production_panel = new JPanel();
      JPanel score_panel = new JPanel();
      JPanel director_panel = new JPanel();

      JLabel titleL = new JLabel("  ��ȭ ����  "); // ��ȭ ���� �Է�
      JTextField titleF = new JTextField(30);
      title_panel.add(titleL);
      title_panel.add(titleF);
      title_panel.setLayout(new FlowLayout());

      String[] genre = { "���", "�̽��͸�", "������", "���", "����", "�׼�", "�ڹ̵�", "��Ÿ��" };
      JLabel genreL = new JLabel("  ��ȭ �帣  "); // ��ȭ �帣 ���� -> �޺��ڽ�
      JComboBox genreF = new JComboBox(genre);
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JLabel dateL = new JLabel("    ������  "); // ������(��, ��, ��) ����

      Integer[] year = new Integer[42]; // ����
      int j = 0;
      for (int k = 1980; k <= 2021; k++)
         year[j++] = k;

      Integer[] month = new Integer[12]; // ��
      j = 0;
      for (int k = 1; k <= 12; k++)
         month[j++] = k;

      Integer[] day = new Integer[31]; // ��
      j = 0;
      for (int k = 1; k <= 31; k++)
         day[j++] = k;

      JComboBox date_year = new JComboBox<Integer>(year); // ��¥ ���� -> �޺��ڽ�
      JComboBox date_month = new JComboBox<Integer>(month);
      JComboBox date_day = new JComboBox<Integer>(day);
      
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JPanel datePanel = new JPanel(); // ������¥ ���� �г�
      datePanel.add(date_year);
      datePanel.add(date_month);
      datePanel.add(date_day);
      JTextField dateF = new JTextField(30);
      date_panel.add(dateL);
      date_panel.add(datePanel);
      date_panel.setLayout(new FlowLayout());


      JLabel productionL = new JLabel("    ��޻�    "); // ��޻� �Է�
      JTextField productionF = new JTextField(30);
      production_panel.add(productionL);
      production_panel.add(productionF);
      production_panel.setLayout(new FlowLayout());

      JLabel scoreL = new JLabel(" ��ȭ ����  "); // ��ȭ ���� �Է�
      JTextField scoreF = new JTextField(30);
      score_panel.add(scoreL);
      score_panel.add(scoreF);
      score_panel.setLayout(new FlowLayout());

      JLabel directorL = new JLabel("  ��ȭ ����  "); // ��ȭ �����Է�
      JTextField directorF = new JTextField(30);
      director_panel.add(directorL);
      director_panel.add(directorF);
      director_panel.setLayout(new FlowLayout());
      
      JPanel genreNdate = new JPanel(); // �帣 ���� �г�
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

      JButton bt = new JButton("�߰�"); // â�� �ϴ��� �߰� ��ư ����
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
         public void actionPerformed(ActionEvent e) { // �߰� ��ư�� ������ �� �߻��ϴ� �̺�Ʈ ó��
            
            int selected = genreF.getSelectedIndex();
            String selectedGenre = genre[selected]; // �޺��ڽ����� �帣 ���õ� �� ������

            String strYear = String.valueOf((int) date_year.getSelectedItem()); // �޺��ڽ����� ���õ� ��, ��, �� ������
            String strMonth = String.valueOf((int) date_month.getSelectedItem());
            String strDay = String.valueOf((int) date_day.getSelectedItem());

            String strDate = strYear + "-" + strMonth + "-" + strDay;

            n = adb.insert_movie(titleF.getText(), selectedGenre, strDate, productionF.getText(),
                  scoreF.getText(), directorF.getText()); // ��ȭ ����, �帣, ��������, ��޻�, ����, ���� ���� ���ڷ� ó�� 
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // ���̵�� ��й�ȣ�� �Է����� �ʾ��� ��� ���� ó��
               JOptionPane.showMessageDialog(null, "��ĭ�� �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // �Է¹��� ���̵�� ��й�ȣ ���� INTEGER ������ �ٲ���
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // ���̵�� ��й�ȣ�� ��ġ�� ���(���Ƿ� ���̵�� ��й�ȣ�� 1234�� ���ص�)
                  if (titleF.getText().isEmpty()
                        || productionF.getText().isEmpty() || scoreF.getText().isEmpty()
                        || directorF.getText().isEmpty()) { // ����ڷκ��� �Է¹��� �ؽ�Ʈ�ʵ��� ���� ���� �� ����ó��
                     JOptionPane.showMessageDialog(null, "��ĭ�� �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);

                  } else {
                     if (n == 1) {// ���������� �߰��� ���� ���
                        JOptionPane.showMessageDialog(null, "�߰� ����!", "success",
                              JOptionPane.INFORMATION_MESSAGE);
                     }

                  }
               } else { // ���̵�� ��й�ȣ�� ���� ���� �� ����ó��
                  JOptionPane.showMessageDialog(null, "�α��� ������ �ùٸ��� �ʽ��ϴ�!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }

            titleF.setText(""); // �ؽ�Ʈ�ʵ带 ��� �������� ó��
            productionF.setText("");
            scoreF.setText("");
            directorF.setText("");
            idText.setText("");
            pwdText.setText("");

         }

      });

   }

   private void modifyMovie(JPanel p) { // ��ȭ ������ �����ϴ� �޼���
      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("�α��� ������ �Է��ϰ� �����ϰ� ���� ��ȭ�� ������ �Է��ϼ���");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // ���̵�� ��й�ȣ�� �Է��ϴ� �α��� ����
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

      JLabel label = new JLabel("�����ϰ� ���� ��ȭ ���� �Է�");
      JPanel label_panel = new JPanel();
      label_panel.add(label);

      JPanel title_panel = new JPanel();
      JPanel genre_panel = new JPanel();
      JPanel date_panel = new JPanel();
      JPanel genreNdate = new JPanel();
      JPanel production_panel = new JPanel();

      JLabel titleL = new JLabel("��ȭ ����"); // ��ȭ ���� �Է�
      JTextField titleF = new JTextField(30);
      title_panel.add(titleL);
      title_panel.add(titleF);
      title_panel.setLayout(new FlowLayout());

      String[] genre = { "���", "�̽��͸�", "������", "���", "����", "�׼�", "�ڹ̵�", "��Ÿ��" };
      JLabel genreL = new JLabel("  ��ȭ �帣  "); // ��ȭ �帣 ���� -> �޺��ڽ�
      JComboBox genreF = new JComboBox(genre);
      genre_panel.add(genreL);
      genre_panel.add(genreF);
      genre_panel.setLayout(new FlowLayout());

      JLabel dateL = new JLabel("    ������  "); 

      Integer[] year = new Integer[42]; // �������� - ��
      int j = 0;
      for (int k = 1980; k <= 2021; k++)
         year[j++] = k;

      Integer[] month = new Integer[12]; // �������� - ��
      j = 0;
      for (int k = 1; k <= 12; k++)
         month[j++] = k;

      Integer[] day = new Integer[31]; // �������� - ��
      j = 0;
      for (int k = 1; k <= 31; k++)
         day[j++] = k;

      JComboBox date_year = new JComboBox<Integer>(year); // ��¥ ���� (��, ��, ��)
      JComboBox date_month = new JComboBox<Integer>(month);
      JComboBox date_day = new JComboBox<Integer>(day);

      JPanel datePanel = new JPanel(); // ��ȭ ������ ���� 
      datePanel.add(date_year);
      datePanel.add(date_month);
      datePanel.add(date_day);
      JTextField dateF = new JTextField(30);
      date_panel.add(dateL);
      date_panel.add(datePanel);
      date_panel.setLayout(new FlowLayout());

      JLabel productionL = new JLabel("  ��޻�  "); // ��޻� �Է�
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

      JButton bt = new JButton("����"); // �ϴ��� ���� ��ư
      JPanel bottomPan = new JPanel();
      bottomPan.add(bt);

      window.setLayout(new BorderLayout());
      window.add(topPan, BorderLayout.NORTH);
      window.add(centerPan, BorderLayout.CENTER);
      window.add(bottomPan, BorderLayout.SOUTH);

      p.add(window);

      adb = new DB2021Team05_AdminDB();

      bt.addActionListener(new ActionListener() { // ���� ��ư�� ������ ��� �߻��ϴ� �̺�Ʈ ó��
         int n = 0;

         @Override
         public void actionPerformed(ActionEvent e) {
            int selected = genreF.getSelectedIndex(); // �帣�� �޺��ڽ����� ���õ� �� ������
            String selectedGenre = genre[selected];

            String strYear = String.valueOf((int) date_year.getSelectedItem()); // �������� �޺��ڽ����� ���õ� �� ������(��, ��, ��)
            String strMonth = String.valueOf((int) date_month.getSelectedItem());
            String strDay = String.valueOf((int) date_day.getSelectedItem());

            String strDate = strYear + "-" + strMonth + "-" + strDay;

            n = adb.modify_movie(titleF.getText(), selectedGenre, strDate, productionF.getText()); // ��ȭ ����, �帣, ������, ��޻� ���� �μ��� ó��
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // ���̵�� ��й�ȣ�� �Է����� ���� ��� ���� ó��
               JOptionPane.showMessageDialog(null, "��ĭ�� �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // �Է¹��� ���̵�� ��й�ȣ ���� INTEGER ������ �ٲ���
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // ���̵�� ��й�ȣ�� ��ġ�� ���(���Ƿ� ���̵�� ��й�ȣ�� 1234�� ���ص�)
                  if (titleF.getText().isEmpty() || productionF.getText().isEmpty()) { // �ؽ�Ʈ �ʵ� ���� �Էµ��� �ʾ��� ��� ���� ó��
                     JOptionPane.showMessageDialog(null, "��ĭ�� �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);

                  } else {
                     if (n == 1) { // ���������� ������ �� ���
                        JOptionPane.showMessageDialog(null, "���� ����!", "success", JOptionPane.INFORMATION_MESSAGE);
                     } else if (n == -1) { // �Էµ� ��ȭ������ ��Ͽ��� ã�� ������ ��� �߻��ϴ� ���� ó��
                        JOptionPane.showMessageDialog(null, "���� ����! ��ȭ�� ã�� ���߾��!", "error",
                              JOptionPane.ERROR_MESSAGE);
                     }
                  }
               } else { // ���̵�� ��й�ȣ ������ ���� ���� ��� �߻��ϴ� ���� ó��
                  JOptionPane.showMessageDialog(null, "�α��� ������ �ùٸ��� �ʽ��ϴ�!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }

            titleF.setText(""); // �ؽ�Ʈ �ʵ带 ��� �������� ó��
            dateF.setText("");
            productionF.setText("");
            idText.setText("");
            pwdText.setText("");

         }

      });
   }

   private void deleteReview(JPanel p) { // �ش� Ű���带 �����ϴ� ���� ���� ����

      JPanel window = new JPanel();
      JLabel top_tip = new JLabel("�α��� ������ �Է��ϰ� �����ϰ� ���� ���� Ű���带 �Է��ϼ���");
      top_tip.setHorizontalAlignment(JTextField.CENTER);

      JLabel id = new JLabel("id"); // ���̵�� ��й�ȣ�� �Է��ϴ� �α��� ����
      JTextField idText = new JTextField(20);
      JLabel pwd = new JLabel("pw");
      JTextField pwdText = new JTextField(20);
      JPanel pan1 = new JPanel();

      pan1.add(id);
      pan1.add(idText);
      pan1.add(pwd);
      pan1.add(pwdText);
      pan1.setLayout(new FlowLayout());

      JLabel keyword = new JLabel("Ű���� �Է�"); // Ű���� �Է� ����
      JTextField keyText = new JTextField(30);
      JButton bt = new JButton("����"); // ���� ��ư
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

      JPanel result = new JPanel(); // �Է¿� ���� ����� �˷��ִ� ����
      JLabel resultText = new JLabel("�Է� �����");
      result.add(resultText);

      window.setLayout(new BorderLayout());
      window.add(topPan, BorderLayout.NORTH);
      window.add(result, BorderLayout.CENTER);

      p.add(window);

      adb = new DB2021Team05_AdminDB();
      bt.addActionListener(new ActionListener() { 
         int n = 0;

         @Override
         public void actionPerformed(ActionEvent e) { // ���� ��ư�� ������ ��� �߻��ϴ� �̺�Ʈ ó�� 
            n = adb.delete_review(keyText.getText());
            if (idText.getText().isEmpty() || pwdText.getText().isEmpty()) { // ���̵�� ��й�ȣ ���� �Էµ��� �ʾ��� ��� �߻��ϴ� ���� ó��
               JOptionPane.showMessageDialog(null, "��ĭ�� �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);
            } else {
               int id = Integer.parseInt(idText.getText()); // ���̵�� ��й�ȣ�� �Է¹��� ���� integer ������ �ٲ���
               int pwd = Integer.parseInt(pwdText.getText());

               if (id == 1234 && pwd == 1234) { // ���̵�� ��й�ȣ�� ��ġ�� ���(���Ƿ� ���̵�� ��й�ȣ�� 1234�� ���ص�)
                  if (n == 2) { // �Է¹��� Ű���� ���� ���� ��� �߻��ϴ� ����ó��
                     JOptionPane.showMessageDialog(null, "Ű���带 �Է��ϼ���!", "error", JOptionPane.ERROR_MESSAGE);

                  }

                  else if (n == 1) { // ���������� ������ �Ǿ��� ���
                     resultText.setText(""); 
                     JOptionPane.showMessageDialog(null, "������ �Ϸ�Ǿ����ϴ�!", "success",
                           JOptionPane.INFORMATION_MESSAGE);
                  }

                  else if (n == -1) { // �ش� Ű���带 ���信�� �������� ������ �� �߻��ϴ� ���� ó��
                     JOptionPane.showMessageDialog(null, "�ش� Ű���带 ã�� �� ���� ���並 �������� ���Ͽ����ϴ�!", "error",
                           JOptionPane.ERROR_MESSAGE);
                  }
               } else { // ���̵�� �н����� ���� ���� ���� ��� �߻��ϴ� ���� ó��
                  JOptionPane.showMessageDialog(null, "�α��� ������ �ùٸ��� �ʽ��ϴ�!", "error", JOptionPane.ERROR_MESSAGE);
               }
            }
            keyText.setText(""); // �Է¹��� �ؽ�Ʈ�ʵ��� ���� �������� �ٲ���
            idText.setText("");
            pwdText.setText("");

         }

      });
   }
}