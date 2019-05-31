package bbs;

import java.util.Iterator;
import java.util.List;

public class BbsTest {
	
	public static void main(String[] args) {
		BbsDAO dao = new BbsDAO();
		
		//list(dao);
		//create(dao);
		//delete(dao);
		//update(dao);
		read(dao);
	}

	private static void read(BbsDAO dao) {
		BbsDTO dto = dao.read(21);
		p(dto);
	}

	private static void update(BbsDAO dao) {
		BbsDTO dto = dao.read(20);
		dto.setWname("차농");
		dto.setTitle("상우형은 고구마");
		dto.setContent("상우형 항상 얼굴이 빨개지시다 못 해 붉어지시는 모습이 너무 고구마 같아영~ 오늘 고구마칩 나눠먹었는데 갑자기 생각났어요 헤헿");
		if(dao.update(dto)) {
			p("complete");
		} else {
			p("failure");
		}
	}

	private static void delete(BbsDAO dao) {
		if(dao.delete(19)) {
			p("compelte");
		} else {
			p("failure");
		}
	}

	private static void create(BbsDAO dao) {
		BbsDTO dto = new BbsDTO();
		
		dto.setWname("사기꾼");
		dto.setTitle("실습");
		dto.setContent("실습을 해봅시다");
		dto.setPasswd("1234");
		
		if(dao.create(dto)) {
			p("success");
		} else {
			p("faliure");
		}
	}

	private static void list(BbsDAO dao) {
		List<BbsDTO> list = dao.list();
		Iterator<BbsDTO> iter = list.iterator();	//while문 쓰려고 iterator변환! 아니면 for문
		
		while(iter.hasNext()) {
			BbsDTO dto = iter.next();
			p(dto);
			p("--------------------");
		}
	}
	
	private static void p(BbsDTO dto) {
		p("번호: " + dto.getBbsno());
		p("이름: " + dto.getWname());
		p("제목: " + dto.getTitle());
		p("내용: " + dto.getContent() +"<br>");
		p("등록날짜: " + dto.getWdate());
		p("조회수: " + dto.getViewcnt());
		p("grpno: " + dto.getGrpno());
		p("indent: " + dto.getIndent());
		p("ansnum: " + dto.getAnsnum());
	}
	
	private static void p(String string) {
		System.out.println(string);
	}
}