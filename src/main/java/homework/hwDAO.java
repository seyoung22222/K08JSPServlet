package homework;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;
import model1.board.BoardDTO;

public class hwDAO extends JDBConnect {
	
	   public hwDAO(ServletContext application) {
	      super(application);
	   }
	   
	   public hwDTO getMemberDTO (String uid, String upass) {
		   hwDTO dto = new hwDTO();
		   String query = "SELECT * FROM member WHERE id=? AND pass=?";
		   
		   try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, uid);
				psmt.setString(2, upass);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
					dto.setName(rs.getString(3));
					dto.setRegidate(rs.getString(4));
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		   return dto;
	   }
	   
	   public int selectCount(Map<String, Object> map) {
		   int totalCount = 0;
		   
		   String query = "SELECT COUNT(*) FROM board ";
		   if(map.get("keyString") != null) {
			   query += " WHERE "+ map.get("keyField") 
			   + " LIKE '%"+ map.get("keyString")+ "%'";
		   }
		   
		   try {
		         stmt = con.createStatement();
		         rs = stmt.executeQuery(query);
		         rs.next();
		         totalCount = rs.getInt(1);
		      } 
		      catch (Exception e) {
		         System.out.println("게시물 수를 구하는 중 예외 발생");
		         e.printStackTrace();
		      }
		   return totalCount;
	   }
	   
	   public List<hwDTO> selectList(Map<String, Object> map){
		      
		      List<hwDTO> bbs = new Vector<hwDTO>();
		      
		      String query = "SELECT * FROM board";
		      if(map.get("keyString") != null) {
		         query += " WHERE "+ map.get("keyField") 
		         + " LIKE '%"+ map.get("keyString")+ "%'";
		      }
		      query += " ORDER BY num DESC ";
		      
		      try {
		         stmt = con.createStatement();
		         rs = stmt.executeQuery(query);
		         
		         while (rs.next()) {
		            hwDTO dto = new hwDTO();
		            
		            dto.setNum(rs.getString("num"));
		            dto.setTitle(rs.getString("title"));
		            dto.setContent(rs.getString("content"));
		            dto.setPostdate(rs.getDate("postdate"));
		            dto.setId(rs.getString("id"));
		            dto.setVisitcount(rs.getString("visitcount"));
		   
		            bbs.add(dto);
		         }
		      } 
		      catch (Exception e) {
		         e.printStackTrace();
		      }
		      
		      return bbs;
		   }
	   
	   public int insertWrite(hwDTO dto) {
		   int result = 0;
		   
		   try {
			   String query = "INSERT INTO board( "
					   		+ " num, title, content, id, visitcount) "
					   		+ " VALUES ( "
					   		+ " seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			   
			   psmt = con.prepareStatement(query);
			   psmt.setString(1, dto.getTitle());
			   psmt.setString(2, dto.getContent());
			   psmt.setString(3, dto.getId());
			   //insert를 실행하여 입력된 행의 갯수를 반환받는다.
			   result = psmt.executeUpdate();
		   }
		   catch (Exception e) {
			   System.out.println("게시물 입력 중 예외 발생");
			   e.printStackTrace();
		   }
		   return result;
		   
	   }

	   public hwDTO selectView(String num) {
		   hwDTO dto = new hwDTO();
		   
		   String query = "SELECT B.*, M.name "
				   		+ " FROM member M INNER JOIN board B "
				   		+ " ON M.id=B.id "
				   		+ " WHERE num=?";
		   try {
			   psmt = con.prepareStatement(query);
			   psmt.setString(1, num);
			   rs = psmt.executeQuery();
			   
			   if(rs.next()) {
				   dto.setNum(rs.getString(1));
				   dto.setTitle(rs.getString(2));
				   dto.setContent(rs.getString("content"));
				   dto.setPostdate(rs.getDate("postdate"));
				   dto.setId(rs.getString("id"));
				   dto.setVisitcount(rs.getString(6));
				   dto.setName(rs.getString("name"));
			   }
		   }catch (Exception e) {
			   System.out.println("게시물 상세보기 중 예외발생");
			   e.printStackTrace();
		   }
		   return dto;
	   }
	   
	   public void updateVisitCount(String num) {
		   String query = "UPDATE board SET "
	   				+ " visitcount=visitcount+1 "
	   				+ " WHERE num=?";
		   try {
			   psmt = con.prepareStatement(query);
			   psmt.setString(1, num);
			   psmt.executeQuery();
		   }
		   catch (Exception e) {
			   System.out.println("게시물 조회수 증가 중 예외발생");
			   e.printStackTrace();
		   }
	   }
	   
	   public int updateEdit(hwDTO dto) {
		   int result = 0;
		   
		   try {
			   String query = "UPDATE board SET "
			   		+ " title=?, content=? "
			   		+ " WHERE num=?";
			   
			   psmt = con.prepareStatement(query);
			   psmt.setString(1, dto.getTitle());
			   psmt.setString(2, dto.getContent());
			   psmt.setString(3, dto.getNum());
			   result = psmt.executeUpdate();
		   }
		   catch (Exception e) {
			   System.out.println("게시물 수정 중 예외 발생");
			   e.printStackTrace();
		   }
		   return result;
	   }
	   
	   public int boardDelete(hwDTO dto) {
		   int result =0;
		   
		   try {
			   String query = "delete from board where num =?";
			   
			   psmt = con.prepareStatement(query);
			   psmt.setString(1, dto.getNum());
			   
			   result = psmt.executeUpdate();
		   }
		   catch (Exception e) {
			   System.out.println("게시물 삭제 중 예외 발생");
			   e.printStackTrace();
		   }
		   return result;
	   }

}
