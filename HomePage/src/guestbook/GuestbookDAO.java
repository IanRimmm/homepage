package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;

public class GuestbookDAO {
	
	public boolean create(GuestbookDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into guestbook ");
		sql.append(" (no, name, gender, title, content, regdate, part, passwd) ");
		sql.append(" values( ");
		sql.append(" (select nvl(max(no),0) +1 from guestbook), ");
		sql.append("  ?,?,?,?,sysdate,?,? ) ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPartstr());
			pstmt.setString(6, dto.getPasswd());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public GuestbookDTO read(int no) {
		GuestbookDTO dto = null;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select * ");
		sql.append(" from guestbook ");
		sql.append(" where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new GuestbookDTO();	// GuestbookDTO 객체를 생성해 뒀기 때문에, 앞에 GuestbookDTO
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPartstr(rs.getString("part"));		//part를 치면 왜 오류가 나지?											//passwd 불러와도 되나? 안됌
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return dto;
	}
	
	public boolean update(GuestbookDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update guestbook ");
		sql.append(" set ");
		sql.append(" name=?, ");
		sql.append(" title=?, ");
		sql.append(" content=?, ");
		sql.append(" part=? ");
		sql.append(" where no=? ");	//regdate 왜 안하니?
	
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPartstr());
			pstmt.setInt(5, dto.getNo());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag=true;	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public boolean delete(int no) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from guestbook ");
		sql.append(" where no=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	public List<GuestbookDTO> list(Map map){
		List<GuestbookDTO> list = new ArrayList<GuestbookDTO>();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		// order by - rownum - where?
		sql.append(" select no, name, title, part, regdate, grpno, indent, ansnum, r ");
		sql.append(" from( ");
		sql.append(" 	select no, name, title, part, regdate, grpno, indent, ansnum, rownum r ");
		sql.append(" 	from( ");
		sql.append(" 		select no, name, title, part, to_char(regdate, 'yyyy-mm-dd') regdate, ");
		sql.append(" 		grpno, indent, ansnum ");
		sql.append(" 		from guestbook ");
		
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		} else if(word.trim().length()>0) {
			sql.append(" where " +col+ " like '%'||?||'%' ");
		}
			sql.append(" order by grpno desc, ansnum asc ");
			sql.append(" 	) ");
			sql.append(" )where r>=? and r<=? ");
			
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if(word.trim().length()>0 && col.equals("title_content")) {
				pstmt.setString(++i, word);
				pstmt.setString(++i, word);
			} else if(word.trim().length()>0){
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				GuestbookDTO dto = new GuestbookDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPartstr(rs.getString("part"));	// why? dto.setPartstr?
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return list;
	}
	
	public int total(Map map) {
		int total = 0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from guestbook ");
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		if(word.trim().length()>0 && col.equals("title_content")) {
			sql.append(" where title like '%'||?||'%' ");
			sql.append(" or content like '%'||?||'%' ");
		} else if(word.trim().length()>0) {
			sql.append(" where " +col + " like '%'||?||'%'");
		}
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0 && col.equals("title_content")) {
				pstmt.setString(1, word);
				pstmt.setString(2, word);
			} else if(word.trim().length()>0) {
				pstmt.setString(1, word);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return total;
	}
	
	public boolean passwdCheck(Map map) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from guestbook where no = ? and passwd = ? ");
		
		int no = (Integer)map.get("no");
		String passwd = (String)map.get("passwd");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt>0) flag = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return flag;
	}
	
	public boolean createReply(GuestbookDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into guestbook ");
		sql.append(" (no, name, gender, title, content, regdate, part, grpno, indent, ansnum, passwd) ");
		sql.append(" values( ");
		sql.append(" (select nvl(max(no), 0) +1 from guestbook), ");
		sql.append(" ?,?,?,?,sysdate,?,?,?,?,? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getPartstr());	// part -> partstr
			pstmt.setInt(6, dto.getGrpno());
			pstmt.setInt(7, dto.getIndent()+1);
			pstmt.setInt(8, dto.getAnsnum()+1);
			pstmt.setString(9, dto.getPasswd());
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag = true;
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DBClose.close(pstmt, con);
		}
		return flag;
	}
	
	// 답변글을 읽어올 때!
	public GuestbookDTO readReply(int no) {
		GuestbookDTO dto = null;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from guestbook where no = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new GuestbookDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPartstr(rs.getString("part"));	//part는 왜 안돼..?	 //"part"는 DB에 있는 컬럼명을 받아서 partstr에 넣어주는 것!
				dto.setGender(rs.getString("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		return dto;
	}
	
	public void upAnsnum(Map map) {
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DBClose.close(rs, pstmt, con);
		}
	}
	
}
