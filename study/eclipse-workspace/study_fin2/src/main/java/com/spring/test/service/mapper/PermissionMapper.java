package com.spring.test.service.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;

@Repository
public class PermissionMapper {
	
	@Autowired
	SqlSession mybatis;
	
	/***********  로그인  ***********/
	//회원가입
	public void signUp(ProgramVO uservo) {
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
	public boolean loginCheck(ProgramVO uservo) {
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
	public ProgramVO getuser(ProgramVO uservo) {
		return mybatis.selectOne("permission.getuser", uservo);
	}

	//사용자 아이디에 저장된 직무 코드에 해당하는 상세 테이블에 데이터 존재하는지 확인
	public List<ProgramVO> getTitledetail(ProgramVO uservo) {
		return mybatis.selectList("permission.getTitledetail", uservo);
	}

	//사용자 정보 조회
	public ProgramVO getUserForm(String userID) {
		System.out.println("사용자 정보 조회 들어왔다");
		return mybatis.selectOne("permission.getUserForm", userID);
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
	
	//상위 부서 조회
	public List<TeamVO> getupteamList() throws Exception {
		return mybatis.selectList("permission.getupteamList");
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

	//프로그램 조회
	public List<ProgramVO> getProgramList2(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getProgramList2", paging);
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
	public void regUser(ProgramVO uservo) throws Exception {
		mybatis.insert("permission.regUser", uservo);
	}
	
	//사용자 전체 게시글 개수 조회
	public int userCount() {
		return mybatis.selectOne("permission.userCount");
	}

	
	//사용자 조회
	public List<ProgramVO> getUserList(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getUserList", paging);
	}

	//사용자 상세 조회
	public ProgramVO getUser(ProgramVO uservo) throws Exception {
		return mybatis.selectOne("permission.getUser", uservo);
	}
	
	//사용자 수정
	public void updateUser(ProgramVO uservo) throws Exception {
		mybatis.update("permission.updateUser", uservo);
	}
	
	//사용자 삭제
	public void delUser(ProgramVO uservo) throws Exception {
		mybatis.delete("permission.delUser", uservo);
	}
	
	
	
	
	
	/***********  직무  ***********/
	
	//직무 마스터 - 직무코드 중복 체크
    public int tmIdCheck (String id) {
        int cnt = mybatis.selectOne("permission.tmIdCheck", id);
        System.out.println("cnt>>"+cnt);
        return cnt;
    }

	//직무 마스터 - 등록
	public void regTitlemst(ProgramVO pgmvo) throws Exception {
		mybatis.insert("permission.regTitlemst", pgmvo);
	}
	
	//프로그램 전체 게시글 개수 조회
	public int titleMstCount() {
		return mybatis.selectOne("permission.titleMstCount");
	}

	
	//직무 마스터 조회
	public List<ProgramVO> getTitleMstList(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getTitleMstList", paging);
	}
	
	//직무 마스터 조회
	public List<ProgramVO> getTitleMstList2(PagingVO paging) throws Exception {
		return mybatis.selectList("permission.getTitleMstList2", paging);
	}

	//-----------------------------------------//
	
	//직무 상세 - 직무코드, 프로그램 아이디 중복 체크
    public int pktitCheck (ProgramVO pgmvo) {
        int cnt = mybatis.selectOne("permission.pktitCheck", pgmvo);
        System.out.println("cnt>>"+cnt);
        return cnt;
    }
    
    //프로그램 조회
  	public List<ProgramVO> getpgmList(ProgramVO data) throws Exception {
  		return mybatis.selectList("permission.getpgmList",data);
  	}
	
	//직무 상세- 등록
	public void regTitledetail(ProgramVO pgmvo) throws Exception {
		mybatis.insert("permission.regTitledetail", pgmvo);
	}
	
	//직무 전체 게시글 개수 조회
	public int titleCount() {
		return mybatis.selectOne("permission.titleCount");
	}

	
	//직무 조회
	public List<ProgramVO> getTitleList(PagingVO pagevo) throws Exception {
		System.out.println("들어옴");
		return mybatis.selectList("permission.getTitleList", pagevo);
	}
	
	//직무 조회2
	public List<ProgramVO> getTitleList2() throws Exception {
		System.out.println("들어옴");
		return mybatis.selectList("permission.getTitleList2");
	}
	

	//직무 상세 조회
	public ProgramVO getTitle(ProgramVO pgmvo) throws Exception {
		return mybatis.selectOne("permission.getTitle", pgmvo);
	}
	
	//직무 수정
	public void updateTitle(ProgramVO pgmvo) throws Exception {
		mybatis.update("permission.updateTitle", pgmvo);
	}
	
	//직무 삭제
	public void delTitle(ProgramVO pgmvo) throws Exception {
		mybatis.delete("permission.delTitle", pgmvo);
	}
	
	
	//직무-마스터 상세 조회
	public ProgramVO getMstTitle(ProgramVO pgmvo) throws Exception {
		return mybatis.selectOne("permission.getMstTitle", pgmvo);
	}
	
	//직무-마스터 수정
	public void updateMstTitle(ProgramVO pgmvo) throws Exception {
		mybatis.update("permission.updateMstTitle", pgmvo);
	}
	
	//직무-마스터 삭제
	public void delMstTitle(ProgramVO pgmvo) throws Exception {
		mybatis.delete("permission.delMstTitle", pgmvo);
	}
	
	
	
	//팀 검색 조회
	public List<ProgramVO> searchTeamList(ProgramVO pgmvo) throws Exception {
		return mybatis.selectList("permission.searchTeamList", pgmvo);
	}
	
	//팀 검색 게시글 개수 조회
	public int searchTeamListCount(ProgramVO pgmvo) {
		return mybatis.selectOne("permission.searchTitleCount", pgmvo);
	}

	//사용자 검색 조회
	public List<ProgramVO> searchUserList(ProgramVO pgmvo) throws Exception {
		return mybatis.selectList("permission.searchUserList", pgmvo);
	}
	
	//사용자 검색 조회
	public List<ProgramVO> searchUser() throws Exception {
		return mybatis.selectList("permission.searchUser");
	}
	
	//사용자 검색 게시글 개수 조회
	public int searchUserListCount(ProgramVO pgmvo) {
		return mybatis.selectOne("permission.searchUserListCount", pgmvo);
	}
	
	//프로그램 검색 조회
	public List<ProgramVO> searchPrgmList(ProgramVO pgmvo) throws Exception {
		return mybatis.selectList("permission.searchPrgmList", pgmvo);
	}
	
	//프로그램 검색 게시글 개수 조회
	public int searchPrgmListCount(ProgramVO pgmvo) {
		return mybatis.selectOne("permission.searchPrgmListCount", pgmvo);
	}
		
		
	//직무 검색 조회
	public List<ProgramVO> searchTitleList(ProgramVO pgmvo) throws Exception {
		System.out.println("searchTitleList>>");
		return mybatis.selectList("permission.searchTitleList", pgmvo);
	}
	
	//직무 검색 게시글 개수 조회
	public int searchTitleCount(ProgramVO pgmvo) {
		String titdet_titmst_id = pgmvo.getTitdet_titmst_id();
		System.out.println("직무코드>"+titdet_titmst_id);
		return mybatis.selectOne("permission.searchTitleCount", pgmvo);
	}

}
