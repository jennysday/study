package com.spring.test.vo;

import java.sql.Timestamp;

public class TeamVO {
	
	//필드
	private String team_id;
	private String team_name;
	private String team_upteam;
	private Timestamp team_reg_date;
	private Timestamp team_update_date;
	private String team_user_id;
	private int page;
	
	//메서드
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getTeam_upteam() {
		return team_upteam;
	}
	public void setTeam_upteam(String team_upteam) {
		this.team_upteam = team_upteam;
	}
	public Timestamp getTeam_reg_date() {
		return team_reg_date;
	}
	public void setTeam_reg_date(Timestamp team_reg_date) {
		this.team_reg_date = team_reg_date;
	}
	public Timestamp getTeam_update_date() {
		return team_update_date;
	}
	public void setTeam_update_date(Timestamp team_update_date) {
		this.team_update_date = team_update_date;
	}
	public String getTeam_user_id() {
		return team_user_id;
	}
	public void setTeam_user_id(String team_user_id) {
		this.team_user_id = team_user_id;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	@Override
	public String toString() {
		return "TeamVO [team_id=" + team_id + ", team_name=" + team_name + ", team_upteam=" + team_upteam
				+ ", team_reg_date=" + team_reg_date + ", team_update_date=" + team_update_date + ", team_user_id="
				+ team_user_id + ", page=" + page + "]";
	} 
	
	
	
}
