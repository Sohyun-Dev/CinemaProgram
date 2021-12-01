package Gui;

import java.awt.*;

import java.awt.event.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import DB.DB2021Team05_MovieDB;
import DB.DB2021Team05_MovieDB.MovieClass;

public class DB2021Team05_MovieGui extends JPanel {		//영화검색부분을 담당하는 클래스

	private int i;							//검색패널 5개를 구분하는 용도이다(제목별 검색, 장르별 검색, 배우, 감독, 영화제별 검색)
	private JTable[] movieTable;			//크기5의 결과출력테이블

	private JRadioButton[] order_basic; 	//정렬종류 정하는 radio button 가나다순
	private JRadioButton[] order_score; 	//평점순
	private JRadioButton[] order_date; 		//개봉일순

	private DefaultTableModel[] model;		//결과출력테이블 만들기위해 필요한거
	private Vector<String> header;			//결과출력테이블의 헤더를 구성하는 vector

	private JTextField[] tf;				//사용자 입력 받는 text field
	
	private ButtonGroup[] bg;				//radiobutton들을 하나로 묶어준다
	
	private JPanel moviePanel;				//가장 하위패널이다.
	
	private JPanel panel_title;				//제목별 검색의 상위패널; moviePanel에 들어간다
	private JPanel panel_genre;				//장르별 검색의 상위패널
	private JPanel panel_actor;
	private JPanel panel_director;
	private JPanel panel_award;
	
	private JPanel[] result;				//결과부분패널; panel_title,... 의 center부분에 들어감
	private JPanel[] pan;					//검색부분 패널; result패널의 North부분에 들어감
	private JLabel[] searchLabel;		
	private JButton[] search;				//검색버튼
	
	private JComboBox combo;				//장르별 검색에서 장르들을 보여준다; textfield대신사용
	private JComboBox comboGenre;			//영화제별 검색에서 영화제들을 보여줌
	private String[] awardList;				//combo에 들어갈 영화제 목록
	private String[] genreList;				//comboGenre에 들어갈 장르 목록

	private DB2021Team05_MovieDB rdb;					//DB랑 연결하는 객체
	

	public JPanel getMoviePanel() {
		return moviePanel;
	}

	public DB2021Team05_MovieGui(JFrame j) {					//mainGui에서 부르는 함수; 프레임에 movie panel을 넣는 역할
		order_basic = new JRadioButton[5];		//필요한 객체들 선언; 검색 종류가 5개라서 크기는 5이고 i로 구분한다
		order_score = new JRadioButton[5];
		order_date = new JRadioButton[5];
		pan = new JPanel[5];
		tf = new JTextField[5];
		searchLabel = new JLabel[5];
		search = new JButton[5];
		result = new JPanel[5];
		bg = new ButtonGroup[5];
		model = new DefaultTableModel[5];
		movieTable = new JTable[5];
		awardList = new String[30];
		genreList = new String[8];
		
		moviePanel = new JPanel();
		moviePage();
		j.add(moviePanel);
	}

	private void moviePage() {			//패널 만드는 메서드
		panel_title = new JPanel();
		panel_genre = new JPanel();
		panel_actor = new JPanel();
		panel_director = new JPanel();
		panel_award = new JPanel();
		BorderLayout border = new BorderLayout();
		border.setVgap(30);
		moviePanel.setLayout(border);
		for (i = 0; i < 5; i++)
			movieTable[i] = new JTable();
		
		makeWindow(panel_title, "영화 제목의 일부 또는 전체를 입력하세요.", 0);		//제목별 검색 패널 만들기; i=0
		makeWindow(panel_genre, "검색할 영화 장르를 선택하세요.", 1);
		makeWindow(panel_actor, "출연한 배우의 이름을 입력하세요.", 2);
		makeWindow(panel_director, "감독의 이름을 입력하세요.", 3);
		makeWindow(panel_award, "영화제를 선택하세요.", 4);

		JTabbedPane choicePane = new JTabbedPane();						//tab으로 구분할거라서 JTabbedPane을 사용한다
		choicePane.addTab("제목별", panel_title);
		choicePane.addTab("장르별", panel_genre);
		choicePane.addTab("배우별", panel_actor);
		choicePane.addTab("감독별", panel_director);
		choicePane.addTab("영화제별", panel_award);

		moviePanel.add(choicePane, BorderLayout.CENTER);
	}
	
	private void genreComboBox() {										//장르별 검색 패널의 textfield 대신 들어갈 combobox
		rdb = new DB2021Team05_MovieDB();							
		genreList = rdb.genreList();									//MovieDB에서 genrelist를 받아온다
		comboGenre = new JComboBox(genreList);
	}
	
	private void awardComboBox() {										//영화제별 검색 패널의 combobox
		rdb = new DB2021Team05_MovieDB();
		awardList = rdb.awardList();
		combo = new JComboBox(awardList);
	}

	private void makeWindow(JPanel window, String str, int i) {			//패널만드는 메서드; 위의 moviepage 메서드에서 호출된다
		searchLabel[i] = new JLabel(str);								//설명란
		searchLabel[i].setHorizontalAlignment(JTextField.CENTER);	
		if (i == 1)														//장르별 검색패널일 경우
			genreComboBox();
		else if (i == 4) {												//영화제별 검색패널
			awardComboBox();
		} else
			tf[i] = new JTextField(30); 
		
		pan[i] = new JPanel(); 											//검색설명이랑 입력란, 검색버튼이 들어갈 panel_title, ...의 North부분 패널
		search[i] = new JButton("검색");
		pan[i].setLayout(new BorderLayout());
		pan[i].add(searchLabel[i], BorderLayout.NORTH);
		if (i == 1)
			pan[i].add(comboGenre, BorderLayout.CENTER);
		else if (i == 4)
			pan[i].add(combo, BorderLayout.CENTER);
		else
			pan[i].add(tf[i], BorderLayout.CENTER);
		pan[i].add(search[i], BorderLayout.EAST);

		result[i] = new JPanel(); 									//정렬radiobutton이랑 결과jtable이 들어갈 panel_title, ...의 center부분 패널
		result[i].setLayout(new BorderLayout());

		bg[i] = new ButtonGroup();

		order_basic[i] = new JRadioButton("가나다순", true); 			// 가나다순 기본정렬
		if (i == 4) {												//영화제별 검색 패널일 경우 정렬방법을 조금 바꿔준다
			order_score[i] = new JRadioButton("수상부문순");
			order_date[i] = new JRadioButton("수상년도순");
		} else {
			order_score[i] = new JRadioButton("평점순");
			order_date[i] = new JRadioButton("개봉순");
		}

		bg[i].add(order_basic[i]);
		bg[i].add(order_score[i]);
		bg[i].add(order_date[i]);

		JPanel radioButton = new JPanel();							//radiobutton들이 담긴 패널; result패널의 North부분에 들어간다
		radioButton.add(order_basic[i]);
		radioButton.add(order_score[i]);
		radioButton.add(order_date[i]);
		result[i].add(radioButton, BorderLayout.NORTH);

		window.setLayout(new BorderLayout()); 						//window는 panel_title, ...의 해당 메서드 속 변수명이다
		window.add(pan[i], BorderLayout.NORTH); // pan1이 검색패널

		header = new Vector<String>();								//jtable에 들어갈 header이다
		header.addElement("제목");
		if (i == 2) {												//배우별 검색일 경우 헤더를 조금 바꿔준다
			header.addElement("배우");
			header.addElement("배역");
		} else {
			header.addElement("감독");
			header.addElement("장르");
		}
		
		if (i == 4) {												//영화제별 검색패널 경우도 헤더가 달라진다
			header.addElement("수상부문");
			header.addElement("수상년도");
		}
		else {
			header.addElement("개봉일자");
			header.addElement("평균평점");
		}
		
		model[i] = new DefaultTableModel(header, 0);				//jtable 세팅을 위한 기본table모델
		movieTable[i].setModel(model[i]);
		movieTable[i].getColumn("제목").setPreferredWidth(150);
		if (i == 4)
			movieTable[i].getColumn("수상부문").setPreferredWidth(150);

		result[i].add(new JScrollPane(movieTable[i]));
		search[i].addActionListener(new ActionListener() {			//검색버튼에 actionlistener 달아준다
			ArrayList<MovieClass> mlist;							//db에서 결과를 받아오는 list

			@Override
			public void actionPerformed(ActionEvent e) {
				rdb = new DB2021Team05_MovieDB();
				if (order_basic[i].isSelected() == true)			//정렬방법 바꾸기
					rdb.order = "Title";
				else if (order_score[i].isSelected() == true)
					rdb.order = "Score";
				else
					rdb.order = "releaseDate";
				
				if (i == 0)											//영화별 패널에서 검색한 경우
					mlist = rdb.search_movie(tf[i].getText());
				else if (i == 1) {									//장르별 패널에서 검색한 경우
					int selected = comboGenre.getSelectedIndex();
					String selectedGenre = genreList[selected];		//combobox에서 선택한 장르를 string에 저장
					mlist = rdb.search_genre(selectedGenre);
				} else if (i == 2)
					mlist = rdb.search_actor(tf[i].getText());
				else if (i == 3)
					mlist = rdb.search_director(tf[i].getText());
				else {												//영화제별 패널에서 겸색한 경우
					int selected = combo.getSelectedIndex();
					String selectedAward = awardList[selected];
					mlist = rdb.search_award(selectedAward);
				}

				if (mlist.size() == 0) {							//받아온 정보가 없는 경우
					JOptionPane.showMessageDialog(null, "해당 정보가 없습니다!", "error", JOptionPane.ERROR_MESSAGE);
				} else {
					setUpdateTableData(movieTable[i], i);
					// 받아온 mlist로테이블을 update한다.
				}

			}//이벤트핸들링 생성자의 끝
		});//actionperformed 메서드의 끝
		
		result[i].add(new JScrollPane(movieTable[i]), BorderLayout.CENTER);			//결과table을 result패널에 넣기
		window.add(result[i], BorderLayout.CENTER);
	}//makewindow 메서드의 끝

	private void setUpdateTableData(JTable Table, int i) {							//결과table을 업데이트하는 메서드
		DefaultTableModel model = (DefaultTableModel) Table.getModel();				//기본모델선언
		model.setRowCount(0);
		for (MovieClass rc : rdb.mlist) {											//row가 있을때까지 반복
			Vector body = new Vector();												//row의 데이터를 body에 저장한다
			body.addElement(rc.title);
			if (i == 2) {															//패널별로 저장할 결과가 다르다
				body.addElement(rc.actor);
				body.addElement(rc.role);
			} else {
				body.addElement(rc.director);
				body.addElement(rc.genre);
			}
			if (i == 4) {
				body.addElement(rc.prize);
				body.addElement(rc.awardYear);
			} else {
				body.addElement(rc.releaseDate);
				body.addElement(rc.score);
			}
			
			model.addRow(body);														//결과를 table에 추가한다
		}
		Table.setModel(model);														//작업 완료되면 model 세팅하기
	}//메서드의 끝
}//클래스의 끝