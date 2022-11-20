package com.spring.test.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;

public interface PermissionService {
	
	/***********  로그인  ***********/
	//회원 가입
	public void signUp(ProgramVO uservo);
	
	//아이디 중복 체크
	public int idCheck(String userId);
	
	//로그인 체크
	boolean loginCheck(ProgramVO uservo,HttpSession session) throws Exception;
	
	//로그 아웃
	void logout(HttpSession session);
	
	//사용자 아이디 조회
	ProgramVO getuser(ProgramVO uservo, HttpSession session) throws Exception;
	
	/***********  권한  ***********/
	
	//프로그램 권한 체크
	void accessCheck(ProgramVO uservo,HttpSession session) throws Exception;
	
	/***********  부서  ***********/
	
	//부서 등록
	void regTeam(TeamVO teamvo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//부서 아이디 중복확인
    int teamIdCheck(String id);

    // 상위부서 등록여부 확인
    int upteamCheck(String team_id);

	//부서 조회
	Map<String, Object> getTeamList(PagingVO pagevo, HttpSession session) throws Exception;
	
	//상위 부서 조회
	Map<String, Object> getupteamList(HttpSession session) throws Exception;
	
	//부서 상세 조회
	Map<String, Object> getTeam(TeamVO teamvo, PagingVO pagevo, HttpSession session) throws Exception;
	
	//부서 수정
	void updateTeam(TeamVO teamvo, String team_user_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//부서 삭제
	void delTeam(TeamVO teamvo, HttpServletResponse response) throws Exception;

	//부서 삭제
	void delTeam2(TeamVO teamvo, HttpServletResponse response) throws Exception;
	
	/***********  프로그램  ***********/
	
	//프로그램 아이디 중복확인
    int pgmIdCheck(String id);
    
	//프로그램 등록
	void regProgram(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//프로그램 조회
	Map<String, Object> getProgramList(PagingVO pagevo, HttpSession session) throws Exception;
	
	//프로그램 조회
	Map<String, Object> getProgramList2(PagingVO pagevo, HttpSession session) throws Exception;
	
	//프로그램 조회
	List<ProgramVO> getpgmList(ProgramVO data) throws Exception;

	//프로그램 상세 조회
	Map<String, Object> getProgram(ProgramVO pgmvo, HttpSession session) throws Exception;
	
	//프로그램 수정
	void updateProgram(ProgramVO pgmvo, String pgm_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//프로그램 삭제
	void delProgram(ProgramVO pgmvo, HttpServletResponse response) throws Exception;
	
	
	/***********  사용자  ***********/
	
	//사용자 아이디 중복확인
    int userIdCheck(String id);
    
	//사용자 등록
	void regUser(ProgramVO uservo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//사용자 조회
	Map<String, Object> getUserList(ProgramVO uservo, PagingVO pagevo, HttpSession session) throws Exception;

	//사용자 상세 조회
	Map<String, Object> getUser(ProgramVO uservo, PagingVO pagevo, HttpSession session) throws Exception;
	
	//사용자 수정
	void updateUser(ProgramVO uservo, String user_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//사용자 삭제
	void delUser(ProgramVO uservo, HttpServletResponse response) throws Exception;
	
	//사용자 삭제
	void delUser2(ProgramVO uservo, HttpServletResponse response) throws Exception;
	
	
	
	/***********  직무  ***********/
	
	//직무 마스터 - 직무코드 중복 체크
    int tmIdCheck(String id);
    
    //직무 마스터 - 등록
	void regTitlemst(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//직무 마스터 - 조회
	Map<String, Object> getTitleMstList(PagingVO pagevo, HttpSession session) throws Exception;
	
	//직무 마스터 - 조회
	Map<String, Object> getTitleMstList2(PagingVO pagevo, HttpSession session) throws Exception;
	
	//직무-마스터 상세 - 직무코드 중복 체크
    Map<String, Object> getMstTitle(ProgramVO pgmvo, PagingVO pagevo, HttpSession session) throws Exception;
    
    //직무-마스터 수정
  	void updateMstTitle(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;
  	
  	//직무-마스터 삭제
  	void delMstTitle(ProgramVO pgmvo, HttpServletResponse response) throws Exception;
    
	//--------------------------//
	
	//직무 상세 - 직무코드 중복 체크
    int pktitCheck(ProgramVO pgmvo);
	
	//직무 상세 - 등록
	void regTitledetail(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//직무 조회
	Map<String, Object> getTitleList(PagingVO pagevo, HttpSession session) throws Exception;

	//직무 검색 조회
	Map<String, Object> searchTitleList(ProgramVO pgmvo, HttpSession session) throws Exception;
	
	//직무 상세 조회
	Map<String, Object> getTitle(ProgramVO pgmvo, PagingVO pagevo, HttpSession session) throws Exception;
	
	//직무 수정
	void updateTitle(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//직무 삭제
	void delTitle(ProgramVO pgmvo, HttpServletResponse response) throws Exception;

	//직무 사용자 조회
	void getUserForm(String userID, HttpSession session) throws Exception;

}
