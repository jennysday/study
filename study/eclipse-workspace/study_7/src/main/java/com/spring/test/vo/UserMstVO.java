package com.spring.test.vo;

import java.sql.Timestamp;

public class UserMstVO {
	
	private String user_id;
	private String user_name; 
	private String user_pswd; 
	private String user_team; 
	private String user_titmst_id1;
	private String user_titmst_id2; 
	private String user_titmst_id3; 
	private String user_dataaccess; 
	private Timestamp user_reg_date;
	private Timestamp user_update_date; 
	private String user_user_id;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_pswd() {
		return user_pswd;
	}
	public void setUser_pswd(String user_pswd) {
		this.user_pswd = user_pswd;
	}
	public String getUser_team() {
		return user_team;
	}
	public void setUser_team(String user_team) {
		this.user_team = user_team;
	}
	public String getUser_titmst_id1() {
		return user_titmst_id1;
	}
	public void setUser_titmst_id1(String user_titmst_id1) {
		this.user_titmst_id1 = user_titmst_id1;
	}
	public String getUser_titmst_id2() {
		return user_titmst_id2;
	}
	public void setUser_titmst_id2(String user_titmst_id2) {
		this.user_titmst_id2 = user_titmst_id2;
	}
	public String getUser_titmst_id3() {
		return user_titmst_id3;
	}
	public void setUser_titmst_id3(String user_titmst_id3) {
		this.user_titmst_id3 = user_titmst_id3;
	}
	public String getUser_dataaccess() {
		return user_dataaccess;
	}
	public void setUser_dataaccess(String user_dataaccess) {
		this.user_dataaccess = user_dataaccess;
	}
	public Timestamp getUser_reg_date() {
		return user_reg_date;
	}
	public void setUser_reg_date(Timestamp user_reg_date) {
		this.user_reg_date = user_reg_date;
	}
	public Timestamp getUser_update_date() {
		return user_update_date;
	}
	public void setUser_update_date(Timestamp user_update_date) {
		this.user_update_date = user_update_date;
	}
	public String getUser_user_id() {
		return user_user_id;
	}
	public void setUser_user_id(String user_user_id) {
		this.user_user_id = user_user_id;
	}
	
	@Override
	public String toString() {
		return "UserMstVO [user_id=" + user_id + ", user_name=" + user_name + ", user_pswd=" + user_pswd
				+ ", user_team=" + user_team + ", user_titmst_id1=" + user_titmst_id1 + ", user_titmst_id2="
				+ user_titmst_id2 + ", user_titmst_id3=" + user_titmst_id3 + ", user_dataaccess=" + user_dataaccess
				+ ", user_reg_date=" + user_reg_date + ", user_update_date=" + user_update_date + ", user_user_id="
				+ user_user_id + "]";
	}
}
