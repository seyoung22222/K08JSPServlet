package fileupload;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	//파일 업로드 처리
	public static MultipartRequest uploadFile(HttpServletRequest req, 
			String saveDirectory, int maxPostSize) {
		try {
			/*
			 MultipartRequest(request내장객체, 디렉토리 물리적경로,
			 	업로드 제한용량, 인코딩방식);
			 위와같은 형태로 객체를 생성함과 동시에 파일은 업로드된다.
			 업로드에 성공하면 객체의 참조값을 반환한다.
			 만약 실패했다면 디렉토리 경로나 파일용량을 확인해본다.
			 */
			return new MultipartRequest(req, saveDirectory, maxPostSize,
							"UTF-8");
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
