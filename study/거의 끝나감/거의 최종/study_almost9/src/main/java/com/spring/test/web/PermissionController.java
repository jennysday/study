package com.spring.test.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.test.service.PermissionService;
import com.spring.test.service.common.Common;
import com.spring.test.vo.PagingVO;
import com.spring.test.vo.ProgramVO;
import com.spring.test.vo.TeamVO;

@Controller
public class PermissionController {
	
	@Autowired
	private PermissionService service;
	
	Common common = new Common();
	
	
	/***********  로그인  ***********/
	
	//회원가입 화면
	@RequestMapping(value ="/signUpPage")
	public String signUpPage(){
		
		return "/Login/signup_view";
	}
	
	//회원가입
	@RequestMapping(value = "/signUp")
	public String signUp(ProgramVO uservo) {
		
		service.signUp(uservo);
		
		return "login";
	}
	
	//아이디 중복 확인
	@RequestMapping(value = "/idCheck",method = RequestMethod.GET, produces = "application/text; charset=utf8")
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		
		String userId = request.getParameter("userId");
		int result=service.idCheck(userId);
		return Integer.toString(result);
	}
	
	//로그인 화면
	@RequestMapping("/login")
	public String login(HttpSession session) {
		service.logout(session);
		return "/Login/login_view";
	}
	
	//로그인 처리
	@RequestMapping(value="/loginCheck")
	public ModelAndView loginCheck(@ModelAttribute ProgramVO uservo, HttpSession session) throws Exception{
		
		boolean result = service.loginCheck(uservo, session);
		ModelAndView mav = new ModelAndView();
		
		if(result) {
			System.out.println("로그인 성공");
			mav.addObject("msg","로그인 성공");
			//mav.setViewName("/Login/login_view");
			mav.setViewName("redirect:getTeamList");
		}else {
			System.out.println("로그인 실패");
			mav.addObject("msg","로그인 실패");
			mav.setViewName("/Login/login_fail");
		}
		
		return mav;
	}
	
	//로그아웃 처리
	@RequestMapping(value="logout")
	public ModelAndView logout(HttpSession session) {
		
		service.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/Login/login_view");
		mav.addObject("msg", "logout");
		
		return mav;
	}
	
	/***********  권한  ***********/

	
	/***********  부서  ***********/
	
	//부서 등록 화면
	@RequestMapping(value="regTeamView", method=RequestMethod.GET) 
	public String regTeamView(ProgramVO uservo, PagingVO pagevo, TeamVO teamvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("부서 등록 user>>"+user);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
	
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getupteamList(session);
		model.addAttribute("result",result);
		System.out.println("등록화면>"+result);

		return "/Team/team_reg";
	}

    //부서코드 중복 확인
	@RequestMapping(value="teamIdCheck", method=RequestMethod.POST)
	@ResponseBody 
	public int teamIdCheck(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String id) {
		System.out.println("id>>"+id);
		int result = service.teamIdCheck(id);
	    return result; 
	}

	//상위부서 등록 여부 확인
	@RequestMapping(value="upteamCheck", method=RequestMethod.POST)
	@ResponseBody
	public int upteamCheck(@RequestParam("team_upteam")  String team_id) {
		System.out.println("컨트롤러");
		int cnt = service.upteamCheck(team_id);
		System.out.println("team_id>>"+team_id);
		return cnt;
		
	}
	
	//부서 등록
	@RequestMapping(value="regTeam", method=RequestMethod.POST) 
	public void regTeam(TeamVO teamvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(teamvo);
		service.regTeam(teamvo,request,response);
		
		//response.sendRedirect("regTeamView");
	}
	
	//부서 조회 + 상세 화면
	@RequestMapping(value="getTeamListView", method=RequestMethod.GET) 
	public String getTeamListView(TeamVO teamvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTeamList(pagevo, session);
		System.out.println("부서 조회>>"+result);
		
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTeam(teamvo, pagevo, session);
		System.out.println("부서 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
		
		Map<String, Object> result3 = new HashMap<String, Object>();
		result3 = service.getupteamList(session);
		model.addAttribute("result3",result3);
		System.out.println("상세화면>"+result3);

		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("부서 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/Team/team_listView"; 
	}
	
	//부서 조회
	@RequestMapping(value="getTeamList", method=RequestMethod.GET) 
	public String getTeamList(PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTeamList(pagevo, session);
		System.out.println("부서 조회>>"+result);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("부서 조회 user>>"+user);
		
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/Team/team_list"; 
	}
	
	//부서 상세 조회
	@RequestMapping(value="getTeam", method=RequestMethod.GET) 
	public String getTeam (TeamVO teamvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTeam(teamvo, pagevo, session);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("부서 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getupteamList(session);
		model.addAttribute("result2",result2);
		System.out.println("상세화면>"+result2);
		
		return "/Team/team_view";
	}
	
	//부서 수정
	@RequestMapping(value="updateTeam") 
	public void updateTeam(TeamVO teamvo, @RequestParam("team_user_id")String team_user_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("team_user_id>>"+team_user_id);
		service.updateTeam(teamvo,team_user_id,request,response);
	}
	
	//부서 삭제
	@RequestMapping(value="delTeam") 
	public void delTeam(TeamVO teamvo, HttpServletResponse response) throws Exception {
		service.delTeam(teamvo, response);
	}
	
	//부서 삭제
	@RequestMapping(value="delTeam2") 
	public void delTeam2(TeamVO teamvo, HttpServletResponse response) throws Exception {
		service.delTeam2(teamvo, response);
	}
		
	/***********  프로그램  ***********/
	
	//프로그램 등록 화면
	@RequestMapping(value="regProgramView", method=RequestMethod.GET) 
	public String regProgramView(ProgramVO uservo, ProgramVO pgmvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("프로그램 등록 user>>"+user);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
	
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}

		return "/Program/program_reg";
	}
	
	//프로그램ID 중복 확인
	@RequestMapping(value="pgmIdCheck", method=RequestMethod.POST)
	@ResponseBody 
	public int pgmIdCheck(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String id) {
		System.out.println("id>>"+id);
		int result = service.pgmIdCheck(id);
	    return result; 
	}

	//프로그램 등록
	@RequestMapping(value="regProgram", method=RequestMethod.POST) 
	public void regProgram(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(pgmvo);
		service.regProgram(pgmvo,request,response);
	}
	

	//프로그램 조회
	@RequestMapping(value="getProgramList", method=RequestMethod.GET) 
	public String getProgramList(PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getProgramList(pagevo, session);
		System.out.println("프로그램 조회>>"+result);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("프로그램 조회 user>>"+user);
		
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/Program/program_list"; 
	}
	
	//프로그램 상세 조회
	@RequestMapping(value="getProgram", method=RequestMethod.GET) 
	public String getProgram (ProgramVO pgmvo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getProgram(pgmvo, session);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("프로그램 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		return "/Program/program_view";
	}
	
	//프로그램 수정
	@RequestMapping(value="updateProgram") 
	public void updateProgram(ProgramVO pgmvo, @RequestParam("pgm_user_id")String pgm_user_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("pgm_id>>"+pgm_user_id);
		System.out.println("pgmvo>>"+pgmvo);
		service.updateProgram(pgmvo,pgm_user_id,request,response);
	}
	
	//프로그램 삭제
	@RequestMapping(value="delProgram") 
	public void delProgram(ProgramVO pgmvo, HttpServletResponse response) throws Exception {
		service.delProgram(pgmvo, response);
	}

	
	//프로그램 조회 + 상세 화면
	@RequestMapping(value="getProgramListView", method=RequestMethod.GET) 
	public String getProgramListView(ProgramVO pgmvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getProgramList(pagevo, session);
		System.out.println("프로그램 조회>>"+result);
		
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getProgram(pgmvo, session);
		System.out.println("프로그램 상세 조회>>"+result2);
		model.addAttribute("result2",result2);

		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("부서 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/Program/program_listView"; 
	}
	
	

	/***********  사용자  ***********/
	
	//사용자 아이디 중복 확인
	@RequestMapping(value="userIdCheck", method=RequestMethod.POST)
	@ResponseBody 
	public int userIdCheck(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String id) {
		System.out.println("id>>"+id);
		int result = service.userIdCheck(id);
	    return result; 
	}

	
	//사용자 등록 화면
	@RequestMapping(value="regUserView", method=RequestMethod.GET) 
	public String regUserView(ProgramVO uservo,PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("사용자 등록 user>>"+user);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
	
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getupteamList(session);
		model.addAttribute("result",result);
		System.out.println("등록화면>"+result);

		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTitleMstList2(pagevo, session);
		model.addAttribute("result2",result2);
		System.out.println("등록화면2>"+result2);
		
		return "/User/user_reg";
	}

	//사용자 등록
	@RequestMapping(value="regUser", method=RequestMethod.POST) 
	public void regUser(ProgramVO uservo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(uservo);
		service.regUser(uservo,request,response);
		
	}
	
	//사용자 조회 + 상세 화면
	@RequestMapping(value="getUserListView", method=RequestMethod.GET) 
	public String getUserListView(ProgramVO uservo, TeamVO teamvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUserList(uservo, pagevo, session);
		System.out.println("사용자 조회>>"+result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getUser(uservo, pagevo, session);
		System.out.println("사용자 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
		
		Map<String, Object> result3 = new HashMap<String, Object>();
		result3 = service.getupteamList(session);
		model.addAttribute("result3",result3);
		System.out.println("등록화면>"+result3);

		Map<String, Object> result4 = new HashMap<String, Object>();
		result4 = service.getTitleMstList2(pagevo, session);
		model.addAttribute("result4",result4);
		System.out.println("등록화면2>"+result4);

		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("사용자 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/User/user_listView"; 
	}
	
	//사용자 조회
	@RequestMapping(value="getUserList", method=RequestMethod.GET) 
	public String getUserList(ProgramVO uservo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUserList(uservo, pagevo, session);
		System.out.println("사용자 조회>>"+result);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("사용자 조회 user>>"+user);
		
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/User/user_list"; 
	}
	
	//사용자 상세 조회
	@RequestMapping(value="getUser", method=RequestMethod.GET) 
	public String getUser (ProgramVO uservo, PagingVO pagevo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUser(uservo, pagevo, session);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("사용자 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getupteamList(session);
		model.addAttribute("result2",result2);
		System.out.println("등록화면>"+result2);

		Map<String, Object> result3 = new HashMap<String, Object>();
		result3 = service.getTitleMstList2(pagevo, session);
		model.addAttribute("result3",result3);
		System.out.println("등록화면2>"+result3);
		
		return "/User/user_view";
	}
	
	//사용자 수정
	@RequestMapping(value="updateUser") 
	public void updateUser(ProgramVO uservo, @RequestParam("user_user_id")String user_user_id,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("user_user_id>>"+user_user_id);
		service.updateUser(uservo,user_user_id,request,response);
		service.accessCheck(uservo,session);
	}
	
	//사용자 삭제
	@RequestMapping(value="delUser") 
	public void delUser(ProgramVO uservo, HttpServletResponse response) throws Exception {
		service.delUser(uservo, response);
	}
	
	//사용자 삭제
	@RequestMapping(value="delUser2") 
	public void delUser2(ProgramVO uservo, HttpServletResponse response) throws Exception {
		service.delUser(uservo, response);
	}
	
	
	
	
	
	
	
	
	
	/***********  직무  ***********/
	
	//직무 마스터 등록 화면
	@RequestMapping(value="regTitlemstView", method=RequestMethod.GET) 
	public String regTitlemstView(ProgramVO uservo, ProgramVO pgmvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("프로그램 등록 user>>"+user);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
	
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}

		return "/Title/TitleMst_reg";
	}
	
	//직무 마스터 - 직무코드 중복 체크
	@RequestMapping(value="tmIdCheck", method=RequestMethod.POST)
	@ResponseBody 
	public int tmIdCheck(HttpServletRequest req, HttpServletResponse resp, HttpSession session, String id) {
		System.out.println("id>>"+id);
		int result = service.tmIdCheck(id);
	    return result; 
	}
	
	//직무-마스터 등록
	@RequestMapping(value="regTitlemst", method=RequestMethod.POST) 
	public void regTitlemst(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(pgmvo);
		service.regTitlemst(pgmvo,request,response);
	}
	
	//직무 조회
	@RequestMapping(value="getTitleList", method=RequestMethod.GET) 
	public String getTitleList(PagingVO pagevo, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("user>>"+user);
		
		//session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		System.out.println("userId>>"+userId);
		
		service.getUserForm(userId, session);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTitleList(pagevo,session);
		System.out.println("직무 조회>>"+result);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}

		model.addAttribute("result",result);
		return "/Title/Title_list"; 
	}
	
	//직무 검색 조회
	@RequestMapping(value="searchTitleList0") 
	public String searchTitle(ProgramVO pgmvo, HttpSession session, Model model) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String titdet_titmst_id = pgmvo.getTitdet_titmst_id();
		System.out.println("직무코드>"+titdet_titmst_id);
		result = service.searchTitleList(pgmvo, session);
		System.out.println("검색 직무 조회>>"+result);
		
		model.addAttribute("titdet_titmst_id",titdet_titmst_id);
		model.addAttribute("result",result);
		return "/Title/Title_list"; 
	}
	
	//직무 검색 조회
	@RequestMapping(value="searchTitleList") 
	public String searchTitle(PagingVO pagevo, ProgramVO pgmvo, HttpSession session, Model model) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTitle(pgmvo, pagevo, session);
		System.out.println("직무 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
		
		String titdet_titmst_id = pgmvo.getTitdet_titmst_id();
		System.out.println("직무코드>"+titdet_titmst_id);
		result = service.searchTitleList(pgmvo, session);
		System.out.println("검색 직무 조회>>"+result);
		
		model.addAttribute("titdet_titmst_id",titdet_titmst_id);
		model.addAttribute("result",result);
		return "/Search/search_title_listView"; 
	}

	//직무 검색 조회
	@RequestMapping(value="searchTitleList2") 
	public String searchTitle2(PagingVO pagevo, ProgramVO pgmvo, HttpSession session, Model model) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTitle(pgmvo, pagevo, session);
		System.out.println("직무 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
		
		String titdet_titmst_id = pgmvo.getTitdet_titmst_id();
		System.out.println("직무코드>"+titdet_titmst_id);
		result = service.searchTitleList(pgmvo, session);
		System.out.println("검색 직무 조회>>"+result);
		
		model.addAttribute("titdet_titmst_id",titdet_titmst_id);
		model.addAttribute("result",result);
		return "/Search/search_title_list"; 
	}

	//직무-상세 등록 화면
	@RequestMapping(value="regTitledetailView", method=RequestMethod.GET) 
	public String regTitledetailView(PagingVO pagevo, ProgramVO uservo, ProgramVO pgmvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("user>>"+user);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTitleMstList2(pagevo, session);
		model.addAttribute("result",result);
		System.out.println("직무마스터 목록>"+result);
		
		if(user == null) {
			//response.sendRedirect("login");
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
/*
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getProgramList2(pagevo, session);
		model.addAttribute("result2",result2);
		System.out.println("프로그램 목록>"+result2);
*/		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getProgramList(pagevo, session);
		System.out.println("프로그램 조회>>"+result2);
		model.addAttribute("result2",result2);
		System.out.println("프로그램 목록>"+result2);
		
		
		Map<String, Object> result3 = new HashMap<String, Object>();
		result3 = service.getProgram(pgmvo, session);
		System.out.println("프로그램 상세 조회>>"+result3);
		model.addAttribute("result3",result3);
		
		return "/Title/TitleDetail_reg";
	}	

	//직무-상세  직무코드 중복 체크
	@RequestMapping(value="pktitCheck", method=RequestMethod.POST)
	@ResponseBody 
	public int pktitCheck(ProgramVO data) {
		System.out.println("직무코드>>"+data.getTitdet_titmst_id());
		System.out.println("프로그램 아이디>>"+data.getTitdet_pgm_id());
		int result = service.pktitCheck(data);
	    return result; 
	}
	
	//프로그램 crud
	@RequestMapping(value="getpgmList", method=RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> getpgmList(@RequestBody Map<String, Object> param, ProgramVO data) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String pgm_id = (String) param.get("titdet_pgm_id");
		System.out.println(">>"+pgm_id);
		System.out.println("param>>"+param);
		
		data.setTitdet_pgm_id(pgm_id);
		
		List<ProgramVO> list = service.getpgmList(data);
		System.out.println("프로그램 crud>>"+data);
		System.out.println("프로그램 crud 아이디>>"+data.getTitdet_pgm_id());
		System.out.println("프로그램 list>"+list);
		result.put("list", list);
		return result; 
	}
	
	//직무-상세 등록
	@RequestMapping(value="regTitledetail", method=RequestMethod.POST) 
	public void regTitledetail(ProgramVO pgmvo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println(pgmvo);
		service.regTitledetail(pgmvo,request,response);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 상세 등록 user>>"+user);
		service.accessCheck(user,session);
	}
	

	//직무 상세 조회
	@RequestMapping(value="getTitle", method=RequestMethod.GET) 
	public String getTitle (ProgramVO pgmvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTitle(pgmvo, pagevo, session);
		System.out.println("직무 상세 조회 >>"+result);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		
		return "/Title/TitleDetail_view";
	}

	//직무 조회 + 상세 화면
	@RequestMapping(value="getTitleListView") 
	public String getTitleListView(ProgramVO pgmvo, PagingVO pagevo, HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		System.out.println("userId>>"+userId);
		
		service.getUserForm(userId, session);
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTitleList(pagevo, session);
		System.out.println("직무 조회>>"+result);
		model.addAttribute("result",result);
		
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTitle(pgmvo, pagevo, session);
		System.out.println("직무 상세 조회>>"+result2);
		model.addAttribute("result2",result2);

		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}

		return "/Title/Title_listView"; 
	}
	
	
	
	
	//직무 수정
	@RequestMapping(value="updateTitle") 
	public void updateTitle(ProgramVO data,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String titdet_titmst_id = data.getTitdet_titmst_id();
		String titdet_pgm_id = data.getTitdet_pgm_id();
		String titdet_function = data.getTitdet_function();
		System.out.println("titdet_titmst_id>>"+titdet_titmst_id);
		System.out.println("titdet_pgm_id>>"+titdet_pgm_id);
		System.out.println("titdet_function>>"+titdet_function);
		service.updateTitle(data,request,response);
		
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 상세 등록 user>>"+user);
		service.accessCheck(user,session);
	}
	
	//직무 삭제
	@RequestMapping(value="delTitle") 
	public void delTitle(ProgramVO pgmvo, HttpServletResponse response,HttpServletRequest request, HttpSession session) throws Exception {
		service.delTitle(pgmvo, response);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 상세 등록 user>>"+user);
		service.accessCheck(user,session);
	}
	
	
	
	
	
	
	
	
	
	//직무-마스터 상세 조회
	@RequestMapping(value="getMstTitle", method=RequestMethod.GET) 
	public String getMstTitle (ProgramVO pgmvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getMstTitle(pgmvo, pagevo, session);
		System.out.println("직무 상세 조회 >>"+result);
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		
		return "/Title/TitleMst_view";
	}

	
	
	//직무-마스터 조회 + 상세 화면
	@RequestMapping(value="getTitleMstListView") 
	public String getTitleMstListView(ProgramVO pgmvo, PagingVO pagevo, HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		
		session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		System.out.println("userId>>"+userId);
		
		service.getUserForm(userId, session);
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTitleMstList(pagevo, session);
		System.out.println("직무 마스터 조회>>"+result);
		model.addAttribute("result",result);
		
		System.out.println("pgmvo>>" + pgmvo);

		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getMstTitle(pgmvo, pagevo, session);
		System.out.println("직무-마스터 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
	
		
		session = request.getSession();
		ProgramVO user = (ProgramVO) session.getAttribute("user");
		System.out.println("직무 마스터 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}

		return "/Title/TitleMst_listView"; 
	}
	

	//직무-마스터 수정
	@RequestMapping(value="updateMstTitle") 
	public void updateMstTitle(ProgramVO data,HttpServletRequest request, HttpServletResponse response) throws Exception {
		String titmst_id = data.getTitmst_id();
		System.out.println("titmst_id>>"+titmst_id);
		service.updateMstTitle(data,request,response);
	}
	
	//직무-마스터 삭제
	@RequestMapping(value="delMstTitle") 
	public void delMstTitle(ProgramVO pgmvo, HttpServletResponse response) throws Exception {
		service.delMstTitle(pgmvo, response);
	}

}
