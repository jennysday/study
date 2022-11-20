package com.spring.test.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.cj.xdevapi.Result;
import com.spring.test.service.PermissionService;
import com.spring.test.service.common.Common;
import com.spring.test.service.mapper.PermissionMapper;
import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

@Service
public class PermissionServiceImpl implements PermissionService{

	@Autowired
	PermissionMapper mapper;

	Common common = new Common();
	
	/***********  로그인  ***********/
	
	//회원가입 
	@Override
	public void signUp(UserMstVO uservo) {
		mapper.signUp(uservo);
	}
	
	//아이디 중복 확인
	@Override
	public int idCheck(String userId) {
		int result = mapper.idCheck(userId);
		return result;
	}
	
	//로그인
	@Override
	public boolean loginCheck(UserMstVO uservo, HttpSession session) {
		
		boolean result = mapper.loginCheck(uservo);
		
		System.out.println("로그인 성공 유무>>"+result);
		
		if (result == true) {	//true 일경우 세션 등록
			UserMstVO getuser = mapper.getuser(uservo);
			System.out.println("getuser>>"+getuser);
			
			//세션 변수 등록
			session.setAttribute("userId",uservo.getUser_id());
			session.setAttribute("user", getuser);
				
			String userId = (String) session.getAttribute("userId");
			UserMstVO user = (UserMstVO) session.getAttribute("user");
			System.out.println("userId>>"+userId);
			System.out.println("user>>"+user);
		}
		
		return result;
	}

	//로그아웃
	@Override
	public void logout(HttpSession session) {
		mapper.logout(session);
	}
	
	
	//사용자 조회
	@Override
	public UserMstVO getuser(UserMstVO uservo, HttpSession session) {
		return mapper.getuser(uservo);
	}
	
	/***********  부서  ***********/
	
	//부서코드 중복 조회
	@Override
	public int teamIdCheck(String id) {
		System.out.println("id>>"+id);
		int result = mapper.teamIdCheck(id);
		System.out.println("result : " + result);
		return result;
	}	
	
	//상위부서 등록 여부 확인
	@Override
	public int upteamCheck(String team_id) {
		System.out.println("서비스임플");
		int cnt = mapper.upteamCheck(team_id);
		System.out.println("cnt: " + cnt);
		return cnt;
	}	
	
	//부서 등록
	@Override
	public void regTeam(TeamVO teamvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//시간 처리
		SimpleDateFormat format = new SimpleDateFormat ("yyyy년 MM월dd일 HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String format_time = format.format(time.getTime());
		System.out.println("등록 시간>>"+format_time);
		
		mapper.regTeam(teamvo);
		
		//common.alertAndGo(response, "등록이 완료되었습니다.", "regTeamView");
	}
	
	//부서 조회
	@Override
	public Map<String, Object> getTeamList(PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		//페이징 처리
		PagingVO paging = new PagingVO();
		int page = pagevo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pagevo.setPage(page);
		}
		System.out.println("page>> " + pagevo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.count();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<TeamVO> teamList = mapper.getTeamList(paging);
		System.out.println("부서조회 서비스>>"+teamList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(teamList.size() != 0) {
			System.out.println("게시글 개수 : " + teamList);
			
			//총 페이지 수
			maxPage = (int)((double)listCount / limit + 0.95); //0.95를 더해서 올림 처리
			
			//현재 페이지에 보여줄 시작 페이지 수 (1,11,21,31)
			startPage = (((int)((double)page / 10 + 0.9)) -1) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수 (10,20,30,40)
			endPage = maxPage;
			
			if(endPage > startPage + 10 - 1) {
				endPage = startPage + 10 - 1; 
			}
			
			System.out.println("maxPage>>"+maxPage);
			System.out.println("startPage>>"+startPage);
			System.out.println("endPage>>"+endPage);
			
			result.put("page", page);
			result.put("maxPage", maxPage);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("teamList", teamList);
			
		} else { //게시글이 0이면 page = 1로 변경
			page = 1;
			result.put("page", page);
		}
		
		return result;
	}

	//부서 상세 조회
	@Override
	public Map<String, Object> getTeam(TeamVO teamvo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		TeamVO team = mapper.getTeam(teamvo);
		result.put("team", team);
		System.out.println(">>"+team);
		/*
		List<TeamVO> teamList = mapper.getTeamList(pagevo);
		result.put("teamList", teamList);
		System.out.println(">>"+teamList);
		*/
		return result;
	}

	//부서 수정
	@Override
	public void updateTeam(TeamVO teamvo, String team_user_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		teamvo.setTeam_user_id(team_user_id); 
		mapper.updateTeam(teamvo);
		//String team_id = teamvo.getTeam_id();
		//common.alertAndGo(response, "수정이 완료되었습니다.", "getTeam?team_id="+team_id);
		
	}

	//부서 삭제
	@Override
	public void delTeam(TeamVO teamvo, HttpServletResponse response) throws Exception {
		mapper.delTeam(teamvo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getTeamList");
		
	}
	
	/***********  프로그램  ***********/
	
	//프로그램 아이디 중복 조회
	@Override
	public int pgmIdCheck(String id) {
		System.out.println("id>>"+id);
		int result = mapper.pgmIdCheck(id);
		System.out.println("result : " + result);
		return result;
	}
	
	//프로그램 등록
	@Override
	public void regProgram(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("프로그램 등록>>");
		mapper.regProgram(pgmvo);
		
	}

	
	//프로그램 조회
	@Override
	public Map<String, Object> getProgramList(PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		//페이징 처리
		PagingVO paging = new PagingVO();
		int page = pagevo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pagevo.setPage(page);
		}
		System.out.println("page>> " + pagevo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.pgmCount();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> programList = mapper.getProgramList(paging);
		System.out.println("프로그램 조회 서비스>>"+programList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(programList.size() != 0) {
			System.out.println("게시글 개수 : " + programList);
			
			//총 페이지 수
			maxPage = (int)((double)listCount / limit + 0.95); //0.95를 더해서 올림 처리
			
			//현재 페이지에 보여줄 시작 페이지 수 (1,11,21,31)
			startPage = (((int)((double)page / 10 + 0.9)) -1) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수 (10,20,30,40)
			endPage = maxPage;
			
			if(endPage > startPage + 10 - 1) {
				endPage = startPage + 10 - 1; 
			}
			
			System.out.println("maxPage>>"+maxPage);
			System.out.println("startPage>>"+startPage);
			System.out.println("endPage>>"+endPage);
			
			result.put("page", page);
			result.put("maxPage", maxPage);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("programList", programList);
			
		} else { //게시글이 0이면 page = 1로 변경
			page = 1;
			result.put("page", page);
		}
		
		return result;
	}

	//프로그램 상세 조회
	@Override
	public Map<String, Object> getProgram(ProgramVO pgmvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String pgm_id = pgmvo.getPgm_id();
		System.out.println("pgm_id"+pgm_id);
		ProgramVO program = mapper.getProgram(pgmvo);
		result.put("program", program);
		System.out.println(">>"+program);

		return result;
	}

	//프로그램 수정
	@Override
	public void updateProgram(ProgramVO pgmvo, String pgm_user_id, HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		System.out.println("프로그램 수정>>"+pgmvo);

		pgmvo.setPgm_create(pgmvo.getPgm_create());
		pgmvo.setPgm_read(pgmvo.getPgm_read());
		pgmvo.setPgm_update(pgmvo.getPgm_update());
		pgmvo.setPgm_delete(pgmvo.getPgm_delete());
		
		pgmvo.setPgm_user_id(pgm_user_id); 
		
		System.out.println("프로그램 수정2>>"+pgmvo);
		mapper.updateProgram(pgmvo);
		
	}
	
	//프로그램 삭제
	@Override
	public void delProgram(ProgramVO pgmvo, HttpServletResponse response) throws Exception {
		mapper.delProgram(pgmvo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getProgramList");
		
	}

	
	/***********  사용자  ***********/
	
	//사용자 아이디 중복 조회
	@Override
	public int userIdCheck(String id) {
		System.out.println("id>>"+id);
		int result = mapper.userIdCheck(id);
		System.out.println("result : " + result);
		return result;
	}

	
	//사용자 등록
	@Override
	public void regUser(UserMstVO uservo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("사용자 등록>>");
		mapper.regUser(uservo);
		
	}
	
	//사용자 조회
	@Override
	public Map<String, Object> getUserList(UserMstVO uservo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		//페이징 처리
		PagingVO paging = new PagingVO();
		int page = pagevo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pagevo.setPage(page);
		}
		System.out.println("page>> " + pagevo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.pgmCount();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<UserMstVO> userList = mapper.getUserList(paging);
		System.out.println("사용자 조회 서비스>>"+userList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(userList.size() != 0) {
			System.out.println("게시글 개수 : " + userList);
			
			//총 페이지 수
			maxPage = (int)((double)listCount / limit + 0.95); //0.95를 더해서 올림 처리
			
			//현재 페이지에 보여줄 시작 페이지 수 (1,11,21,31)
			startPage = (((int)((double)page / 10 + 0.9)) -1) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수 (10,20,30,40)
			endPage = maxPage;
			
			if(endPage > startPage + 10 - 1) {
				endPage = startPage + 10 - 1; 
			}
			
			System.out.println("maxPage>>"+maxPage);
			System.out.println("startPage>>"+startPage);
			System.out.println("endPage>>"+endPage);
			
			result.put("page", page);
			result.put("maxPage", maxPage);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("userList", userList);
			
		} else { //게시글이 0이면 page = 1로 변경
			page = 1;
			result.put("page", page);
		}
		
		return result;
	}
	
	//사용자 상세 조회	
	@Override
	public Map<String, Object> getUser(UserMstVO uservo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String user_id = uservo.getUser_id();
		System.out.println("user_id"+user_id);
		UserMstVO user = mapper.getUser(uservo);
		result.put("user", user);
		System.out.println(">>"+user);
		
		List<TeamVO> teamList = mapper.getTeamList(pagevo);
		System.out.println("teamList>>"+teamList);
		result.put("teamList", teamList);

		return result;
	}

	//사용자 수정
	@Override
	public void updateUser(UserMstVO uservo, String user_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("프로그램 수정>>"+uservo);

		uservo.setUser_user_id(user_id); 
		mapper.updateUser(uservo);
		
	}
	//사용자 삭제
	@Override
	public void delUser(UserMstVO uservo, HttpServletResponse response) throws Exception {
		mapper.delUser(uservo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getUserList");
		
	}

	
	/***********  직무  ***********/
	
	//직무 마스터 - 직무코드 중복 체크
	@Override
	public int tmIdCheck(String id) {
		System.out.println("id>>"+id);
		int result = mapper.tmIdCheck(id);
		System.out.println("result : " + result);
		return result;
	}

	//직무 마스터 - 등록
	@Override
	public void regTitlemst(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("직무 마스터 등록>>");
		mapper.regTitlemst(pgmvo);
		
	}
	
	//직무 마스터 조회
	@Override
	public Map<String, Object> getTitleMstList(PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		//페이징 처리
		PagingVO paging = new PagingVO();
		int page = pagevo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pagevo.setPage(page);
		}
		System.out.println("page>> " + pagevo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.titleMstCount();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> titleMstList = mapper.getTitleMstList(paging);
		System.out.println("직무 마스터 조회 서비스>>"+titleMstList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(titleMstList.size() != 0) {
			System.out.println("게시글 개수 : " + titleMstList);
			
			//총 페이지 수
			maxPage = (int)((double)listCount / limit + 0.95); //0.95를 더해서 올림 처리
			
			//현재 페이지에 보여줄 시작 페이지 수 (1,11,21,31)
			startPage = (((int)((double)page / 10 + 0.9)) -1) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수 (10,20,30,40)
			endPage = maxPage;
			
			if(endPage > startPage + 10 - 1) {
				endPage = startPage + 10 - 1; 
			}
			
			System.out.println("maxPage>>"+maxPage);
			System.out.println("startPage>>"+startPage);
			System.out.println("endPage>>"+endPage);
			
			result.put("page", page);
			result.put("maxPage", maxPage);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("titleMstList", titleMstList);
			
		} else { //게시글이 0이면 page = 1로 변경
			page = 1;
			result.put("page", page);
		}
		
		return result;
	}

	
	//-------------------------------------------------------

	//직무 상세- 등록
	@Override
	public Map<String, Object> regTitledetail(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("직무-상세 등록>>");
		
		int cnt = mapper.pktitCheck(pgmvo);
		System.out.println("직무 상세 중복 검사"+cnt);
		mapper.regTitledetail(pgmvo);
		
		result.put("cnt", cnt);
		
		return result;
		
	}
	


	//직무 조회
	@Override
	public Map<String, Object> getTitleList(PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		//페이징 처리
		PagingVO paging = new PagingVO();
		int page = pagevo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pagevo.setPage(page);
		}
		System.out.println("page>> " + pagevo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.titleCount();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> titleList = mapper.getTitleList(paging);
		System.out.println("직무 조회 서비스>>"+titleList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(titleList.size() != 0) {
			System.out.println("게시글 개수 : " + titleList);
			
			//총 페이지 수
			maxPage = (int)((double)listCount / limit + 0.95); //0.95를 더해서 올림 처리
			
			//현재 페이지에 보여줄 시작 페이지 수 (1,11,21,31)
			startPage = (((int)((double)page / 10 + 0.9)) -1) * 10 + 1;
			
			//현재 페이지에 보여줄 마지막 페이지 수 (10,20,30,40)
			endPage = maxPage;
			
			if(endPage > startPage + 10 - 1) {
				endPage = startPage + 10 - 1; 
			}
			
			System.out.println("maxPage>>"+maxPage);
			System.out.println("startPage>>"+startPage);
			System.out.println("endPage>>"+endPage);
			
			result.put("page", page);
			result.put("maxPage", maxPage);
			result.put("startPage", startPage);
			result.put("endPage", endPage);
			result.put("titleList", titleList);
			
		} else { //게시글이 0이면 page = 1로 변경
			page = 1;
			result.put("page", page);
		}
		
		return result;
	}




	
	
	
	

		
	

		
	

}
