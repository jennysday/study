package com.spring.test.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

public interface PermissionService {
	
	/***********  로그인  ***********/
	//회원 가입
	public void signUp(UserMstVO uservo);
	
	//아이디 중복 체크
	public int idCheck(String userId);
	
	//로그인 체크
	boolean loginCheck(UserMstVO uservo,HttpSession session);
	
	//로그 아웃
	void logout(HttpSession session);
	
	//사용자 아이디 조회
	UserMstVO getuser(UserMstVO uservo, HttpSession session) throws Exception;
	
	/***********  부서  ***********/
	
	//부서 등록
	void regTeam(TeamVO teamvo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//부서 아이디 중복확인
    int teamIdCheck(String id);

    // 상위부서 등록여부 확인
    int upteamCheck(String team_id);
    
	//상위 부서 조회
	Map<String, Object> getupteamList(TeamVO teamvo, HttpSession session) throws Exception;

	//부서 조회
	Map<String, Object> getTeamList(TeamVO teamvo, HttpSession session) throws Exception;
	
	//부서 상세 조회
	Map<String, Object> getTeam(TeamVO teamvo, HttpSession session) throws Exception;
	
	//부서 수정
	void updateTeam(TeamVO teamvo, String team_user_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//부서 삭제
	void delTeam(TeamVO teamvo, HttpServletResponse response) throws Exception;
	
	/***********  프로그램  ***********/
	
	//프로그램 아이디 중복확인
    int pgmIdCheck(String id);
    
	//프로그램 등록
	void regProgram(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//프로그램 조회
	Map<String, Object> getProgramList(PagingVO pagevo, HttpSession session) throws Exception;

	//프로그램 상세 조회
	Map<String, Object> getProgram(ProgramVO pgmvo, HttpSession session) throws Exception;
	
	//프로그램 수정
	void updateProgram(ProgramVO pgmvo, String pgm_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//프로그램 삭제
	void delProgram(ProgramVO pgmvo, HttpServletResponse response) throws Exception;
}
