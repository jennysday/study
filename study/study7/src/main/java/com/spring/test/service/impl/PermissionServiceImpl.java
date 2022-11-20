package com.spring.test.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.test.service.PermissionService;
import com.spring.test.service.mapper.PermissionMapper;
import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

@Service
public class PermissionServiceImpl implements PermissionService{

	@Autowired
	PermissionMapper mapper;

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
	
	//아이디 중복 조회
	@Override
	public int teamIdCheck(String id) {
		System.out.println("id>>"+id);
		int result = mapper.teamIdCheck(id);
		System.out.println("result : " + result);
		return result;
	}	
	/*
	//상위부서 등록 여부 확인
	@Override
	public List<TeamCodeVO> upteamCheck(String upteam) {
		System.out.println("upteam>>"+upteam);
		List<TeamCodeVO> result = mapper.upteamCheck(upteam);
		System.out.println("result : " + result);
		return result;
	}
	*/
	
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
	public void regTeam(TeamVO teamvo) throws Exception {
		//시간 처리
		SimpleDateFormat format = new SimpleDateFormat ("yyyy년 MM월dd일 HH:mm:ss");
		Calendar time = Calendar.getInstance();
		String format_time = format.format(time.getTime());
		System.out.println("등록 시간>>"+format_time);
		
		mapper.regTeam(teamvo);
	}

	//부서 조회
	@Override
	public Map<String, Object> getTeamList(TeamVO teamvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<TeamVO> teamList = mapper.getTeamList(teamvo);
		result.put("teamList", teamList);
		return result;
	}

	//부서 상세 조회
	@Override
	public Map<String, Object> getTeam(TeamVO teamvo, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		TeamVO team = mapper.getTeam(teamvo);
		result.put("team", team);
		System.out.println(">>"+team);
		return result;
	}

	//부서 수정
	@Override
	public void updateTeam(TeamVO teamvo) throws Exception {
		mapper.updateTeam(teamvo);
		
	}

	//부서 삭제
	@Override
	public void delTeam(TeamVO teamvo) throws Exception {
		mapper.delTeam(teamvo);
		
	}



}
