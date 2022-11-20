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
import com.spring.test.vo.TeamVO;
import com.spring.test.vo.UserMstVO;

@Controller
//@SessionAttributes("login")
public class PermissionController {
	
	@Autowired
	private PermissionService service;
	
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
	public String login() {
		return "/Login/login_view";
	}
	
	//로그인 처리
	@RequestMapping(value="/loginCheck")
	public ModelAndView loginCheck(@ModelAttribute UserMstVO uservo, HttpSession session) {
		
		boolean result = service.loginCheck(uservo, session);
		ModelAndView mav = new ModelAndView();
		
		if(result) {
			mav.setViewName("redirect:getTeamList");
			mav.addObject("msg","로그인 성공");
		}else {
			mav.setViewName("/Login/login_view");
			mav.addObject("msg","로그인 실패");
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
	
	
	//부서 등록 화면
	@RequestMapping(value="regTeamView", method=RequestMethod.GET) 
	public String regTeamView(UserMstVO uservo, Model model, HttpServletRequest request, HttpSession session) throws Exception {		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("부서 등록 user>>"+user);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
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
	/*
	//상위부서 등록 여부 확인
	@RequestMapping(value="upteamCheck", method=RequestMethod.POST)
	@ResponseBody 
	public List<TeamCodeVO> upteamCheck(HttpServletRequest req, String upteam) {
		System.out.println("upteam>>"+upteam);
		List<TeamCodeVO> result = service.upteamCheck(upteam);
	    return result; 
	}
	*/
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
	public String regTeam(TeamVO teamvo) throws Exception {
		System.out.println(teamvo);
		service.regTeam(teamvo);
		return "redirect:getTeamList";
	}
	
	//부서 조회
	@RequestMapping(value="getTeamList", method=RequestMethod.GET) 
	public String getTeamList(TeamVO teamvo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTeamList(teamvo, session);
		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("부서 조회 user>>"+user);
		
		model.addAttribute("result",result);
		return "/Team/team_list"; 
	}
	
	//부서 상세 조회
	@RequestMapping(value="getTeam", method=RequestMethod.GET) 
	public String getTeam (TeamVO teamvo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result = service.getTeam(teamvo, session);
		
		session = request.getSession();
		UserMstVO user = (UserMstVO) session.getAttribute("user");
		System.out.println("부서 상세 조회 user>>"+user);
		
		model.addAttribute("result", result);
		return "/Team/team_view";
	}
	
	//부서 수정
	@RequestMapping(value="updateTeam") 
	public String updateTeam(TeamVO teamvo) throws Exception {
		System.out.println(teamvo);
		service.updateTeam(teamvo);
		return "redirect:getTeamList";
	}
	
	//부서 삭제
	@RequestMapping(value="delTeam") 
	public String delTeam(TeamVO teamvo) throws Exception {
		service.delTeam(teamvo);
		return "redirect:getTeamList";
	}
		
		
	
}
