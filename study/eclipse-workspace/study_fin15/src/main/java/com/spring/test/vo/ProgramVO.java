package com.spring.test.vo;

import java.sql.Timestamp;

public class ProgramVO {
	
	
	//부서 필드
	private String team_id;
	private String team_name;
	private String team_upteam;
	private Timestamp team_reg_date;
	private Timestamp team_update_date;
	private String team_user_id;
	
	//프로그램 필드
	private String pgm_id;
	private String pgm_group;
	private String pgm_name;
	private int pgm_create;
	private int pgm_read;
	private int pgm_update;
	private int pgm_delete;
	private String pgm_status;
	private Timestamp pgm_reg_date;
	private Timestamp pgm_update_date;
	private String pgm_user_id;
	
	//직무 마스터 필드
	private String titmst_id; 
	private String titmst_name;
	private String titmst_class;
	private Timestamp titmst_reg_date;
	private Timestamp titmst_update_date;
	private String titmst_user_id;
	
	//직무 상세 필드
	private String titdet_titmst_id; 
	private String titdet_pgm_id; 
	private String titdet_function;  
	private Timestamp titdet_reg_date;
	private Timestamp titdet_update_date;
	private String titdet_user_id;
	
	//사용자 필드
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
	
	//페이지 필드
	private int page;
	private int startRow; //시작행
	private int endRow;  //마지막 행
	
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
	public String getPgm_id() {
		return pgm_id;
	}
	public void setPgm_id(String pgm_id) {
		this.pgm_id = pgm_id;
	}
	public String getPgm_group() {
		return pgm_group;
	}
	public void setPgm_group(String pgm_group) {
		this.pgm_group = pgm_group;
	}
	public String getPgm_name() {
		return pgm_name;
	}
	public void setPgm_name(String pgm_name) {
		this.pgm_name = pgm_name;
	}
	public int getPgm_create() {
		return pgm_create;
	}
	public void setPgm_create(int pgm_create) {
		this.pgm_create = pgm_create;
	}
	public int getPgm_read() {
		return pgm_read;
	}
	public void setPgm_read(int pgm_read) {
		this.pgm_read = pgm_read;
	}
	public int getPgm_update() {
		return pgm_update;
	}
	public void setPgm_update(int pgm_update) {
		this.pgm_update = pgm_update;
	}
	public int getPgm_delete() {
		return pgm_delete;
	}
	public void setPgm_delete(int pgm_delete) {
		this.pgm_delete = pgm_delete;
	}
	public String getPgm_status() {
		return pgm_status;
	}
	public void setPgm_status(String pgm_status) {
		this.pgm_status = pgm_status;
	}
	public Timestamp getPgm_reg_date() {
		return pgm_reg_date;
	}
	public void setPgm_reg_date(Timestamp pgm_reg_date) {
		this.pgm_reg_date = pgm_reg_date;
	}
	public Timestamp getPgm_update_date() {
		return pgm_update_date;
	}
	public void setPgm_update_date(Timestamp pgm_update_date) {
		this.pgm_update_date = pgm_update_date;
	}
	public String getPgm_user_id() {
		return pgm_user_id;
	}
	public void setPgm_user_id(String pgm_user_id) {
		this.pgm_user_id = pgm_user_id;
	}
	public String getTitmst_id() {
		return titmst_id;
	}
	public void setTitmst_id(String titmst_id) {
		this.titmst_id = titmst_id;
	}
	public String getTitmst_name() {
		return titmst_name;
	}
	public void setTitmst_name(String titmst_name) {
		this.titmst_name = titmst_name;
	}
	public String getTitmst_class() {
		return titmst_class;
	}
	public void setTitmst_class(String titmst_class) {
		this.titmst_class = titmst_class;
	}
	public Timestamp getTitmst_reg_date() {
		return titmst_reg_date;
	}
	public void setTitmst_reg_date(Timestamp titmst_reg_date) {
		this.titmst_reg_date = titmst_reg_date;
	}
	public Timestamp getTitmst_update_date() {
		return titmst_update_date;
	}
	public void setTitmst_update_date(Timestamp titmst_update_date) {
		this.titmst_update_date = titmst_update_date;
	}
	public String getTitmst_user_id() {
		return titmst_user_id;
	}
	public void setTitmst_user_id(String titmst_user_id) {
		this.titmst_user_id = titmst_user_id;
	}
	public String getTitdet_titmst_id() {
		return titdet_titmst_id;
	}
	public void setTitdet_titmst_id(String titdet_titmst_id) {
		this.titdet_titmst_id = titdet_titmst_id;
	}
	public String getTitdet_pgm_id() {
		return titdet_pgm_id;
	}
	public void setTitdet_pgm_id(String titdet_pgm_id) {
		this.titdet_pgm_id = titdet_pgm_id;
	}
	public String getTitdet_function() {
		return titdet_function;
	}
	public void setTitdet_function(String titdet_function) {
		this.titdet_function = titdet_function;
	}
	public Timestamp getTitdet_reg_date() {
		return titdet_reg_date;
	}
	public void setTitdet_reg_date(Timestamp titdet_reg_date) {
		this.titdet_reg_date = titdet_reg_date;
	}
	public Timestamp getTitdet_update_date() {
		return titdet_update_date;
	}
	public void setTitdet_update_date(Timestamp titdet_update_date) {
		this.titdet_update_date = titdet_update_date;
	}
	public String getTitdet_user_id() {
		return titdet_user_id;
	}
	public void setTitdet_user_id(String titdet_user_id) {
		this.titdet_user_id = titdet_user_id;
	}
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
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	
	@Override
	public String toString() {
		return "ProgramVO [team_id=" + team_id + ", team_name=" + team_name + ", team_upteam=" + team_upteam
				+ ", team_reg_date=" + team_reg_date + ", team_update_date=" + team_update_date + ", team_user_id="
				+ team_user_id + ", pgm_id=" + pgm_id + ", pgm_group=" + pgm_group + ", pgm_name=" + pgm_name
				+ ", pgm_create=" + pgm_create + ", pgm_read=" + pgm_read + ", pgm_update=" + pgm_update
				+ ", pgm_delete=" + pgm_delete + ", pgm_status=" + pgm_status + ", pgm_reg_date=" + pgm_reg_date
				+ ", pgm_update_date=" + pgm_update_date + ", pgm_user_id=" + pgm_user_id + ", titmst_id=" + titmst_id
				+ ", titmst_name=" + titmst_name + ", titmst_class=" + titmst_class + ", titmst_reg_date="
				+ titmst_reg_date + ", titmst_update_date=" + titmst_update_date + ", titmst_user_id=" + titmst_user_id
				+ ", titdet_titmst_id=" + titdet_titmst_id + ", titdet_pgm_id=" + titdet_pgm_id + ", titdet_function="
				+ titdet_function + ", titdet_reg_date=" + titdet_reg_date + ", titdet_update_date="
				+ titdet_update_date + ", titdet_user_id=" + titdet_user_id + ", user_id=" + user_id + ", user_name="
				+ user_name + ", user_pswd=" + user_pswd + ", user_team=" + user_team + ", user_titmst_id1="
				+ user_titmst_id1 + ", user_titmst_id2=" + user_titmst_id2 + ", user_titmst_id3=" + user_titmst_id3
				+ ", user_dataaccess=" + user_dataaccess + ", user_reg_date=" + user_reg_date + ", user_update_date="
				+ user_update_date + ", user_user_id=" + user_user_id + ", page=" + page + ", startRow=" + startRow
				+ ", endRow=" + endRow + "]";
	}


}
