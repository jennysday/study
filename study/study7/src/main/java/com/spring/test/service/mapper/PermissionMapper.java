package com.spring.test.service.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

@Repository
public class PermissionMapper {
	
	@Autowired
	SqlSession mybatis;
	
	//회원가입
	public void signUp(UserMstVO uservo) {
		System.out.println("===> Mybatis로 회원가입(signUp)");
		mybatis.insert("permission.signUp", uservo);
	}
	
	//아이디 체크
	public int idCheck(String userId) {
		System.out.println("===> Mybatis로 idCheck");
		int result = mybatis.selectOne("permission.idCheck", userId);
		return result;
	}
	
	//로그인 체크
	public boolean loginCheck(UserMstVO uservo) {
		System.out.println("===> Mybatis로 loginCheck() 기능 처리");
		String name = mybatis.selectOne("permission.loginCheck",uservo);
		
		System.out.println(">>>>");
		// 검색이 안되면 0을 반환해주기 때문에 0과 비교해서 참이면 false, 틀리면 true를 반환
		return (Integer.parseInt(name)==0)?false:true;
	}
	
	//로그아웃
	public void logout(HttpSession session) {
		System.out.println("===> 로그아웃 기능 처리");
		session.invalidate();
	}

	//사용자 조회
	public UserMstVO getuser(UserMstVO uservo) {
		return mybatis.selectOne("permission.getuser", uservo);
	}
	
	//부서 아이디 중복 체크
    public int teamIdCheck (String upteam) {
        int cnt = mybatis.selectOne("permission.teamIdCheck", upteam);
        return cnt;
    }
	/*
    //상위부서 등록 여부 확인
    public List<TeamCodeVO> upteamCheck (String upteam) {
    	return mybatis.selectOne("permission.upteamCheck", upteam);	
    }
    */
    //상위부서 등록 여부 확인
    public int upteamCheck (String team_id) {
    	return mybatis.selectOne("permission.upteamCheck", team_id);	
    }
    
    
	//부서 등록
	public void regTeam(TeamVO teamvo) throws Exception {
		mybatis.insert("permission.regTeam", teamvo);
	}
	
	//부서 조회
	public List<TeamVO> getTeamList(TeamVO teamvo) throws Exception {
		return mybatis.selectList("permission.getTeamList", teamvo);
	}
	
	//부서 상세 조회
	public TeamVO getTeam(TeamVO teamvo) throws Exception {
		return mybatis.selectOne("permission.getTeam", teamvo);
	}
	
	//부서 수정
	public void updateTeam(TeamVO teamvo) throws Exception {
		mybatis.update("permission.updateTeam", teamvo);
	}
	
	//부서 삭제
	public void delTeam(TeamVO teamvo) throws Exception {
		mybatis.delete("permission.delTeam", teamvo);
	}
}
