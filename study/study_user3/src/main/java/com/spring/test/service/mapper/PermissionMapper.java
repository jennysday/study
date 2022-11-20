package com.spring.test.service.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

@Repository
public class PermissionMapper {
	
	@Autowired
	SqlSession mybatis;
	
	/***********  로그인  ***********/
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
		
		System.out.println(">>>>"+name);
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
	
	/***********  부서  ***********/
	
	//부서 아이디 중복 체크
    public int teamIdCheck (String upteam) {
        int cnt = mybatis.selectOne("permission.teamIdCheck", upteam);
        return cnt;
    }

    //상위부서 등록 여부 확인
    public int upteamCheck (String team_id) {
    	return mybatis.selectOne("permission.upteamCheck", team_id);	
    }
    
	//부서 등록
	public void regTeam(TeamVO teamvo) throws Exception {
		mybatis.insert("permission.regTeam", teamvo);
	}
	
	//전체 게시글 개수 조회
	public int count() {
		return mybatis.selectOne("permission.count");
	}
	
	//부서 조회
	public List<TeamVO> getTeamList(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getTeamList", paging);
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
	
	/***********  프로그램  ***********/
	
	//프로그램 아이디 중복 체크
    public int pgmIdCheck (String id) {
        int cnt = mybatis.selectOne("permission.pgmIdCheck", id);
        System.out.println("cnt>>"+cnt);
        return cnt;
    }
	
	//프로그램 등록
	public void regProgram(ProgramVO pgmvo) throws Exception {
		mybatis.insert("permission.regProgram", pgmvo);
	}
	
	//프로그램 전체 게시글 개수 조회
	public int pgmCount() {
		return mybatis.selectOne("permission.pgmCount");
	}

	
	//프로그램 조회
	public List<ProgramVO> getProgramList(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getProgramList", paging);
	}

	//프로그램 상세 조회
	public ProgramVO getProgram(ProgramVO pgmvo) throws Exception {
		return mybatis.selectOne("permission.getProgram", pgmvo);
	}
	
	//프로그램 수정
	public void updateProgram(ProgramVO pgmvo) throws Exception {
		mybatis.update("permission.updateProgram", pgmvo);
	}
	
	//프로그램 삭제
	public void delProgram(ProgramVO pgmvo) throws Exception {
		mybatis.delete("permission.delProgram", pgmvo);
	}
	
	/***********  사용자  ***********/
	
	//사용자 아이디 중복 체크
    public int userIdCheck (String id) {
        int cnt = mybatis.selectOne("permission.userIdCheck", id);
        System.out.println("cnt>>"+cnt);
        return cnt;
    }
	
	//사용자 등록
	public void regUser(UserMstVO uservo) throws Exception {
		mybatis.insert("permission.regUser", uservo);
	}
	
	//사용자 전체 게시글 개수 조회
	public int userCount() {
		return mybatis.selectOne("permission.userCount");
	}

	
	//사용자 조회
	public List<UserMstVO> getUserList(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getUserList", paging);
	}

	//사용자 상세 조회
	public UserMstVO getUser(UserMstVO uservo) throws Exception {
		return mybatis.selectOne("permission.getUser", uservo);
	}
	
	//사용자 수정
	public void updateUser(UserMstVO uservo) throws Exception {
		mybatis.update("permission.updateUser", uservo);
	}
	
	//사용자 삭제
	public void delUser(UserMstVO uservo) throws Exception {
		mybatis.delete("permission.delUser", uservo);
	}

}
