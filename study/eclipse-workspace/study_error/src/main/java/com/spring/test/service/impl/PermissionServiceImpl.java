package com.spring.test.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.test.service.PermissionService;
import com.spring.test.service.common.Common;
import com.spring.test.service.mapper.PermissionMapper;
import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;

@Service
public class PermissionServiceImpl implements PermissionService{

	@Autowired
	PermissionMapper mapper;

	Common common = new Common();
	
	/***********  로그인  ***********/
	
	//회원가입 
	@Override
	public void signUp(ProgramVO uservo) {
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
	public boolean loginCheck(ProgramVO uservo, HttpSession session) throws Exception {
		
		boolean result = mapper.loginCheck(uservo);
		
		System.out.println("로그인 성공 유무>>"+result);
		
		if (result == true) {	//true 일경우 세션 등록
			ProgramVO getuser = mapper.getuser(uservo);
			System.out.println("getuser>>"+getuser);
			
			//세션 변수 등록
			session.setAttribute("userId",uservo.getUser_id());
			session.setAttribute("user", getuser);
				
			String userId = (String) session.getAttribute("userId");
			ProgramVO user = (ProgramVO) session.getAttribute("user");
			System.out.println("userId>>"+userId);
			System.out.println("user>>"+user);	
			
			

		}
		
		return result;
	}
	
	//로그인한 사용자인지 확인
	
	
	
	//권한 로직
	@Override
	public void accessCheck(ProgramVO uservo, HttpSession session) throws Exception {
			
		String sessionUserId = (String) session.getAttribute("userId");
		ProgramVO sessionUser = (ProgramVO) session.getAttribute("user");
		
		
		System.out.println("sessionUserId"+sessionUserId);
		System.out.println("sessionUser"+sessionUser);
		
		
		String  userId = uservo.getUser_id();
		if(sessionUserId.equals(userId)) {
			
			//세션 변수 등록
			ProgramVO getuser = mapper.getuser(uservo);
			session.setAttribute("userId",uservo.getUser_id());
			session.setAttribute("user", getuser);
		}
		
		
		//권한 로직
		List<ProgramVO> titleDetail =  mapper.getTitledetail(sessionUser);
		System.out.println("titleDetailNum >> " + titleDetail);
		System.out.println("titleDetail.size() >> " + titleDetail.size());
		
		//세션 변수 등록
		session.setAttribute("titleDetail",titleDetail);
		
		List<String> AllList = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		List<String> titleFunctionList = new ArrayList<String>();

		
		if(titleDetail.size() == 0) {
			System.out.println("없다 데이터" + titleDetail);
			//데이터 없을 경우 조회만 가능하도록 구현
		} else {
			System.out.println("있다 데이터" + titleDetail);

			
			//프로그램 테이블 읽어와서 프로그램 아이디 읽어오기
			PagingVO paging = new PagingVO();
			List<ProgramVO> programList =  mapper.getProgramList2(paging);
			System.out.println("programList >> " + programList);
			
			
			//데이터 있을 경우 해당 기능만 활성화
			//직무 상세 테이블
			
			for(ProgramVO title: titleDetail) {
				//String titdet_titmst_id = title.getTitdet_titmst_id();
				String titdet_pgm_id = title.getTitdet_pgm_id();
				String titdet_function = title.getTitdet_function();
			    //System.out.println("titdet_titmst_id >> " + titdet_titmst_id);
			    //System.out.println("titdet_pgm_id >> " + titdet_pgm_id);
			    //System.out.println("titdet_function >> " + titdet_function);
			    //titleList.add(titdet_pgm_id);
			    
			    
				for(ProgramVO prgm: programList) {
					String pgm_id = prgm.getPgm_id();
					String pgm_name = prgm.getPgm_name();
				    //System.out.println("prgm >> " + pgm_id +" "+ pgm_name);
				    
					if(titdet_pgm_id.equals(pgm_id)){
						System.out.println("해당 기능 활성화 >> " + titdet_pgm_id +" "+pgm_id+" "+pgm_name +" >> " + titdet_function);
						
						AllList.add(titdet_pgm_id +" "+pgm_id+" "+pgm_name+" "+titdet_function);
						titleList.add(titdet_pgm_id);
						titleFunctionList.add(titdet_pgm_id+""+titdet_function);
						
					
					} else {
						System.out.println("조회 기능만 활성화 >>" +  titdet_pgm_id +" "+pgm_id+" "+pgm_name);
					}
				}
			    
			}
			System.out.println("titleList >> "+titleList);
			System.out.println("titleFunctionList >> "+titleFunctionList);
			System.out.println("AllList >> "+AllList);
			

			//세션 변수 등록
			session.setAttribute("titleList", titleList);
			session.setAttribute("titleFunctionList", titleFunctionList);
			
		
			
			//if titdet_pgm_id (프로그램에 등록한 프로그램 아이디 값 - 프로그램 아이디값 전부 셀렉해서 for each문으로 배열로 저장?해서 
			//for each문으로 사용자가 디비에서 가져온 값과 일치하는 값을 찾음) = 사용자가 디비에서 가져온 titdet_pgm_id

			
		}
		
	}


	//로그아웃
	@Override
	public void logout(HttpSession session) {
		mapper.logout(session);
	}
	
	
	//사용자 조회
	@Override
	public ProgramVO getuser(ProgramVO uservo, HttpSession session) {
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

	//상위부서 조회
	@Override
	public Map<String, Object> getupteamList(HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		//부서 조회
		List<TeamVO> teamList = mapper.getupteamList();
		result.put("teamList", teamList);
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
		//common.alertAndGo(response, "삭제가 완료되었습니다.", "getTeamList");
		
	}

	//부서 삭제
	@Override
	public void delTeam2(TeamVO teamvo, HttpServletResponse response) throws Exception {
		mapper.delTeam(teamvo);
		
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
	
	//프로그램 조회
	@Override
	public Map<String, Object> getProgramList2(PagingVO pagevo, HttpSession session) throws Exception {
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
		List<ProgramVO> programList = mapper.getProgramList2(paging);
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
	public void regUser(ProgramVO uservo, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		System.out.println("사용자 등록>>");
		mapper.regUser(uservo);
		
	}
	
	//사용자 조회
	@Override
	public Map<String, Object> getUserList(ProgramVO uservo, PagingVO pagevo, HttpSession session) throws Exception {
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
		listCount = mapper.userCount();
		result.put("count", listCount);
		System.out.println("listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> userList = mapper.getUserList(paging);
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
	public Map<String, Object> getUser(ProgramVO uservo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String user_id = uservo.getUser_id();
		System.out.println("user_id"+user_id);
		ProgramVO user = mapper.getUser(uservo);
		result.put("user", user);
		System.out.println(">>"+user);
		
		List<ProgramVO> userList = mapper.getUserList(pagevo);
		System.out.println("teamList>>"+userList);
		result.put("teamList", userList);

		return result;
	}

	//사용자 수정
	@Override
	public void updateUser(ProgramVO uservo, String user_user_id, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		System.out.println("프로그램 수정>>"+uservo);
		
		System.out.println(user_user_id);
		
		uservo.setUser_user_id(user_user_id); 
		mapper.updateUser(uservo);
		
	}
	//사용자 삭제
	@Override
	public void delUser(ProgramVO uservo, HttpServletResponse response) throws Exception {
		mapper.delUser(uservo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getUserList");
		
	}
	//사용자 삭제
	@Override
	public void delUser2(ProgramVO uservo, HttpServletResponse response) throws Exception {
		mapper.delUser(uservo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getUserListView");
		
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

	//직무 마스터 조회
	@Override
	public Map<String, Object> getTitleMstList2(PagingVO pagevo, HttpSession session) throws Exception {
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
		List<ProgramVO> titleMstList = mapper.getTitleMstList2(paging);
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


	//직무 - 상세  직무코드 중복 체크
	@Override
	public int pktitCheck(ProgramVO pgmvo) {
		System.out.println("pgmvo>>"+pgmvo);
		int result = mapper.pktitCheck(pgmvo);
		System.out.println("result : " + result);
		return result;
	}
	
	//직무 상세 -  등록
	@Override
	public void regTitledetail(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("직무-상세 등록>>");
		mapper.regTitledetail(pgmvo);
		
	}
	

	//프로그램 조회
	@Override
	public List<ProgramVO> getpgmList(ProgramVO data) throws Exception {
		List<ProgramVO> pgmList = mapper.getpgmList(data);
		System.out.println("프로그램 조회>>"+pgmList);
		return pgmList;
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
			System.out.println("없음");
			page = 1;
			result.put("page", page);
		}
		
		return result;

	}
	
	

	//직무 상세
	@Override
	public Map<String, Object> getTitle(ProgramVO pgmvo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		ProgramVO title = mapper.getTitle(pgmvo);
		result.put("title", title);
		System.out.println(">>"+title);

		return result;
	}

	//직무 수정
	@Override
	public void updateTitle(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		mapper.updateTitle(pgmvo);
		
	}

	//직무 삭제
	@Override
	public void delTitle(ProgramVO pgmvo, HttpServletResponse response) throws Exception {
		mapper.delTitle(pgmvo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getTitleListView");
		
	}

	//직무 사용자 정보
	@Override
	public void getUserForm(String userID, HttpSession session) throws Exception {
		
		System.out.println("userID 들어옴 >>" + userID);
		
		ProgramVO getUserForm = mapper.getUserForm(userID);
		session.setAttribute("getUserForm", getUserForm);
		
		System.out.println(">>>>>111"+getUserForm);

		
	}
	
	
	//직무-마스터 상세
	@Override
	public Map<String, Object> getMstTitle(ProgramVO pgmvo, PagingVO pagevo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String titmst_id = pgmvo.getTitmst_id();
		System.out.println("직무 마스터 상세 titmst_id>>"+titmst_id);
		
		ProgramVO Msttitle = mapper.getMstTitle(pgmvo);
		result.put("title", Msttitle);
		System.out.println(">>"+Msttitle);

		return result;
	}

	
	//직무-마스터 수정
	@Override
	public void updateMstTitle(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		mapper.updateMstTitle(pgmvo);
		
	}

	//직무-마스터 삭제
	@Override
	public void delMstTitle(ProgramVO pgmvo, HttpServletResponse response) throws Exception {
		mapper.delMstTitle(pgmvo);
		common.alertAndGo(response, "삭제가 완료되었습니다.", "getTitleMstListView");
		
	}

	

	//팀 검색 조회
	@Override
	public Map<String, Object> searchTeamList(ProgramVO pgmvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//페이징 처리
		int page = pgmvo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pgmvo.setPage(page);
		}
		System.out.println("page>> " + pgmvo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		pgmvo.setStartRow(startRow);
		pgmvo.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.searchTeamListCount(pgmvo);
		result.put("searchCount", listCount);
		System.out.println("search listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> searchList = mapper.searchTeamList(pgmvo);
		System.out.println("팀 조회 서비스>>"+searchList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(searchList.size() != 0) {
			System.out.println("게시글 : " + searchList);
			
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
			result.put("searchList", searchList);
			
		} else { //게시글이 0이면 page = 1로 변경
			System.out.println("없음");
			page = 1;
			result.put("page", page);
		}
		
		return result;

	}
	
	
	//프로그램 검색 조회
		@Override
		public Map<String, Object> searchUserList(ProgramVO pgmvo, HttpSession session) throws Exception {
			Map<String, Object> result = new HashMap<String, Object>();
			
			//페이징 처리
			int page = pgmvo.getPage();
			System.out.println("page : " + page);
			
			//페이지 번호가 0이면 페이지를 1로 변경
			if(page == 0) {
				page = 1;
				pgmvo.setPage(page);
			}
			System.out.println("page>> " + pgmvo.getPage());
		
			int limit = 10;
			int listCount = 0;
			int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
			int endRow = startRow + limit-1; //읽을 마지막 번호
			
			pgmvo.setStartRow(startRow);
			pgmvo.setEndRow(endRow);
			
			System.out.println("startRow>>"+startRow);
			System.out.println("endRow>>"+endRow);
		
			//전체 게시글 개수 조회
			listCount = mapper.searchUserListCount(pgmvo);
			result.put("searchCount", listCount);
			System.out.println("search listCount>>"+listCount);
			
			//부서 조회
			List<ProgramVO> searchList = mapper.searchUserList(pgmvo);
			System.out.println("프로그램 조회 서비스>>"+searchList);
			int maxPage;
			int startPage;
			int endPage;
			
			//게시글이 0이 아닐 경우 if문 실행
			if(searchList.size() != 0) {
				System.out.println("게시글 : " + searchList);
				
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
				result.put("searchList", searchList);
				
			} else { //게시글이 0이면 page = 1로 변경
				System.out.println("없음");
				page = 1;
				result.put("page", page);
			}
			
			return result;
		
		}
	
	
	
	//프로그램 검색 조회
	@Override
	public Map<String, Object> searchPrgmList(ProgramVO pgmvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//페이징 처리
		int page = pgmvo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pgmvo.setPage(page);
		}
		System.out.println("page>> " + pgmvo.getPage());
	
		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		pgmvo.setStartRow(startRow);
		pgmvo.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);
	
		//전체 게시글 개수 조회
		listCount = mapper.searchPrgmListCount(pgmvo);
		result.put("searchCount", listCount);
		System.out.println("search listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> searchList = mapper.searchPrgmList(pgmvo);
		System.out.println("프로그램 조회 서비스>>"+searchList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(searchList.size() != 0) {
			System.out.println("게시글 : " + searchList);
			
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
			result.put("searchList", searchList);
			
		} else { //게시글이 0이면 page = 1로 변경
			System.out.println("없음");
			page = 1;
			result.put("page", page);
		}
		
		return result;
	
	}
	
	
	
	
	//직무 검색 조회
	@Override
	public Map<String, Object> searchTitleList(ProgramVO pgmvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//페이징 처리
		int page = pgmvo.getPage();
		System.out.println("page : " + page);
		
		//페이지 번호가 0이면 페이지를 1로 변경
		if(page == 0) {
			page = 1;
			pgmvo.setPage(page);
		}
		System.out.println("page>> " + pgmvo.getPage());

		int limit = 10;
		int listCount = 0;
		int startRow = (page-1) * 10 + 1; //읽기 시작 할 row 번호
		int endRow = startRow + limit-1; //읽을 마지막 번호
		
		pgmvo.setStartRow(startRow);
		pgmvo.setEndRow(endRow);
		
		System.out.println("startRow>>"+startRow);
		System.out.println("endRow>>"+endRow);

		//전체 게시글 개수 조회
		listCount = mapper.searchTitleCount(pgmvo);
		result.put("searchCount", listCount);
		System.out.println("search listCount>>"+listCount);
		
		//부서 조회
		List<ProgramVO> searchList = mapper.searchTitleList(pgmvo);
		System.out.println("직무 조회 서비스>>"+searchList);
		int maxPage;
		int startPage;
		int endPage;
		
		//게시글이 0이 아닐 경우 if문 실행
		if(searchList.size() != 0) {
			System.out.println("게시글 : " + searchList);
			
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
			result.put("searchList", searchList);
			
		} else { //게시글이 0이면 page = 1로 변경
			System.out.println("없음");
			page = 1;
			result.put("page", page);
		}
		
		return result;

	}
	
	
	//사용자 조회
	@Override
	public Map<String, Object> searchUser(ProgramVO uservo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();

		List<ProgramVO> userList = mapper.searchUser();

		result.put("userList", userList);

		return result;
	}
	



}
