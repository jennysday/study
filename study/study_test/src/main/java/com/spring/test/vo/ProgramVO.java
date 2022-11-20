package com.spring.test.vo;

import java.sql.Timestamp;

public class ProgramVO {
	
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
	
	//메서드
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
	
	@Override
	public String toString() {
		return "ProgramVO [pgm_id=" + pgm_id + ", pgm_group=" + pgm_group + ", pgm_name=" + pgm_name + ", pgm_create="
				+ pgm_create + ", pgm_read=" + pgm_read + ", pgm_update=" + pgm_update + ", pgm_delete=" + pgm_delete
				+ ", pgm_status=" + pgm_status + ", pgm_reg_date=" + pgm_reg_date + ", pgm_update_date="
				+ pgm_update_date + ", pgm_user_id=" + pgm_user_id + ", titmst_id=" + titmst_id + ", titmst_name="
				+ titmst_name + ", titmst_class=" + titmst_class + ", titmst_reg_date=" + titmst_reg_date
				+ ", titmst_update_date=" + titmst_update_date + ", titmst_user_id=" + titmst_user_id
				+ ", titdet_titmst_id=" + titdet_titmst_id + ", titdet_pgm_id=" + titdet_pgm_id + ", titdet_function="
				+ titdet_function + ", titdet_reg_date=" + titdet_reg_date + ", titdet_update_date="
				+ titdet_update_date + ", titdet_user_id=" + titdet_user_id + "]";
	}
	
	
	
	

}
