package com.spring.test.vo;

import java.sql.Timestamp;

public class ProgramVO {
	
	//필드
	private String pgm_id;
	private String pgm_group;
	private String pgm_name;
	private Boolean pgm_create;
	private Boolean pgm_read;
	private Boolean pgm_update;
	private Boolean pgm_delete;
	private String pgm_status;
	private Timestamp pgm_reg_date;
	private Timestamp pgm_update_date;
	private String pgm_user_id;
	
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
	public Boolean getPgm_create() {
		return pgm_create;
	}
	public void setPgm_create(Boolean pgm_create) {
		this.pgm_create = pgm_create;
	}
	public Boolean getPgm_read() {
		return pgm_read;
	}
	public void setPgm_read(Boolean pgm_read) {
		this.pgm_read = pgm_read;
	}
	public Boolean getPgm_update() {
		return pgm_update;
	}
	public void setPgm_update(Boolean pgm_update) {
		this.pgm_update = pgm_update;
	}
	public Boolean getPgm_delete() {
		return pgm_delete;
	}
	public void setPgm_delete(Boolean pgm_delete) {
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
	
	@Override
	public String toString() {
		return "ProgramVO [pgm_id=" + pgm_id + ", pgm_group=" + pgm_group + ", pgm_name=" + pgm_name + ", pgm_create="
				+ pgm_create + ", pgm_read=" + pgm_read + ", pgm_update=" + pgm_update + ", pgm_delete=" + pgm_delete
				+ ", pgm_status=" + pgm_status + ", pgm_reg_date=" + pgm_reg_date + ", pgm_update_date="
				+ pgm_update_date + ", pgm_user_id=" + pgm_user_id + "]";
	}

}
