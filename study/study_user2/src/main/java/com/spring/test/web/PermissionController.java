package com.spring.test.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.spring.test.vo.UserMstVO;

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
	public String signUp(UserMstVO uservo) {
		
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
	public ModelAndView loginCheck(@ModelAttribute UserMstVO uservo, HttpSession session) {
		
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
	
	/***********  부서  ***********/
	
	//부서 등록 화면
	@RequestMapping(value="regTeamView", method=RequestMethod.GET) 
	public String regTeamView(UserMstVO uservo, PagingVO pagevo, TeamVO teamvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		result = service.getTeamList(pagevo, session);
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

		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("부서 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTeamList(pagevo, session);
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
		
	/***********  프로그램  ***********/
	
	//프로그램 등록 화면
	@RequestMapping(value="regProgramView", method=RequestMethod.GET) 
	public String regProgramView(UserMstVO uservo, ProgramVO pgmvo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("프로그램 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		return "/Program/program_view";
	}
	
	//프로그램 수정
	@RequestMapping(value="updateProgram") 
	public void updateProgram(ProgramVO pgmvo, @RequestParam("pgm_id")String pgm_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("pgm_id>>"+pgm_id);
		System.out.println("pgmvo>>"+pgmvo);
		service.updateProgram(pgmvo,pgm_id,request,response);
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
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
	public String regUserView(UserMstVO uservo,PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
		result = service.getTeamList(pagevo, session);
		model.addAttribute("result",result);
		System.out.println("등록화면>"+result);

		return "/User/user_reg";
	}

	//사용자 등록
	@RequestMapping(value="regUser", method=RequestMethod.POST) 
	public void regUser(UserMstVO uservo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(uservo);
		service.regUser(uservo,request,response);
		
	}
	
	//사용자 조회 + 상세 화면
	@RequestMapping(value="getUserListView", method=RequestMethod.GET) 
	public String getUserListView(UserMstVO uservo, TeamVO teamvo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUserList(uservo, pagevo, session);
		System.out.println("사용자 조회>>"+result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getUser(uservo, pagevo, session);
		System.out.println("사용자 상세 조회>>"+result2);
		model.addAttribute("result2",result2);
		
		Map<String, Object> result3 = new HashMap<String, Object>();
		result3 = service.getTeamList(pagevo, session);
		System.out.println("부서 조회>>"+result3);
		model.addAttribute("result3",result3);

		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("사용자 조회 user>>"+user);
		
		if(user == null) {
			common.alertAndGo(response, "로그인 해주세요", "login");
		}
		
		model.addAttribute("result",result);
		return "/User/user_listView"; 
	}
	
	//사용자 조회
	@RequestMapping(value="getUserList", method=RequestMethod.GET) 
	public String getUserList(UserMstVO uservo, PagingVO pagevo, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUserList(uservo, pagevo, session);
		System.out.println("사용자 조회>>"+result);
		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
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
	public String getUser (UserMstVO uservo, PagingVO pagevo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getUser(uservo, pagevo, session);
		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("사용자 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		
		Map<String, Object> result2 = new HashMap<String, Object>();
		result2 = service.getTeamList(pagevo, session);
		model.addAttribute("result2",result2);
		System.out.println("상세 화면>"+result2);
		
		return "/User/user_view";
	}
	
	//사용자 수정
	@RequestMapping(value="updateUser") 
	public void updateUser(UserMstVO uservo, @RequestParam("user_id")String user_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("user_id>>"+user_id);
		service.updateUser(uservo,user_id,request,response);
	}
	
	//사용자 삭제
	@RequestMapping(value="delUser") 
	public void delUser(UserMstVO uservo, HttpServletResponse response) throws Exception {
		service.delUser(uservo, response);
	}

}
