CREATE TABLE `program` (
  `pgm_id` char(8) NOT NULL COMMENT '프로그램ID',
  `pgm_group` char(6) NOT NULL COMMENT '그룹코드',
  `pgm_name` char(20) NOT NULL COMMENT '프로그램명',
  `pgm_create` tinyint(1) DEFAULT '0' COMMENT '입력기능',
  `pgm_read` tinyint(1) DEFAULT '0' COMMENT '조회기능',
  `pgm_update` tinyint(1) DEFAULT '0' COMMENT '수정기능',
  `pgm_delete` tinyint(1) DEFAULT '0' COMMENT '삭제기능',
  `pgm_status` int DEFAULT '2' COMMENT '상태',
  `pgm_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `pgm_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `pgm_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`pgm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `team` (
  `team_id` char(4) NOT NULL COMMENT '부서코드',
  `team_name` char(20) NOT NULL COMMENT '부서명',
  `team_upteam` char(8) NOT NULL COMMENT '상위부서',
  `team_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `team_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `team_user_id` char(20) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `titledetail` (
  `titdet_titmst_id` char(6) NOT NULL COMMENT '직무코드',
  `titdet_pgm_id` char(8) NOT NULL COMMENT '직무명',
  `titdet_function` char(4) NOT NULL COMMENT '직무그룹',
  `titdet_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `titdet_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `titdet_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`titdet_titmst_id`,`titdet_pgm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


CREATE TABLE `titledetail` (
  `titdet_titmst_id` char(6) NOT NULL COMMENT '직무코드',
  `titdet_pgm_id` char(8) NOT NULL COMMENT '직무명',
  `titdet_function` char(4) NOT NULL COMMENT '직무그룹',
  `titdet_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `titdet_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `titdet_user_id` char(8) NOT NULL COMMENT '최종사용자',
  constraint pk_tit_pgm PRIMARY KEY (`titdet_titmst_id`,`titdet_pgm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



CREATE TABLE `titlemst` (
  `titmst_id` char(5) NOT NULL COMMENT '직무코드',
  `titmst_name` char(20) NOT NULL COMMENT '직무명',
  `titmst_class` char(2) NOT NULL COMMENT '직무그룹',
  `titmst_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `titmst_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `titmst_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`titmst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



CREATE TABLE `user_mst` (
  `user_id` char(8) NOT NULL COMMENT '사용자ID',
  `user_name` char(20) NOT NULL COMMENT '사용자명',
  `user_pswd` char(20) NOT NULL COMMENT '패스워드',
  `user_team` char(4) NOT NULL COMMENT '부서코드',
  `user_titmst_id1` char(6) NOT NULL COMMENT '직무코드1',
  `user_titmst_id2` char(6) NOT NULL COMMENT '직무코드2',
  `user_titmst_id3` char(6) NOT NULL COMMENT '직무코드3',
  `user_dataaccess` char(1) NOT NULL COMMENT '자료접근권한',
  `user_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `user_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `user_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;






-----------------------------------------------------


CREATE TABLE `program` (
  `pgm_id` char(8) NOT NULL COMMENT '프로그램ID',
  `pgm_group` char(6) NOT NULL COMMENT '그룹코드',
  `pgm_name` char(20) NOT NULL COMMENT '프로그램명',
  `pgm_create` tinyint(1) DEFAULT '0' COMMENT '입력기능',
  `pgm_read` tinyint(1) DEFAULT '0' COMMENT '조회기능',
  `pgm_update` tinyint(1) DEFAULT '0' COMMENT '수정기능',
  `pgm_delete` tinyint(1) DEFAULT '0' COMMENT '삭제기능',
  `pgm_status` int DEFAULT '2' COMMENT '상태',
  `pgm_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `pgm_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `pgm_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`pgm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `team` (
  `team_id` char(4) NOT NULL COMMENT '부서코드',
  `team_name` char(20) NOT NULL COMMENT '부서명',
  `team_upteam` char(8) NOT NULL COMMENT '상위부서',
  `team_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `team_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `team_user_id` char(20) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `titledetail` (
  `titdet_titmst_id` char(5) NOT NULL COMMENT '직무코드',
  `titdet_pgm_id` char(8) NOT NULL COMMENT '직무명',
  `titdet_function` char(4) NOT NULL COMMENT '직무그룹',
  `titdet_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `titdet_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `titdet_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`titdet_titmst_id`,`titdet_pgm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `titlemst` (
  `titmst_id` char(5) NOT NULL COMMENT '직무코드',
  `titmst_name` char(20) NOT NULL COMMENT '직무명',
  `titmst_class` char(2) NOT NULL COMMENT '직무그룹',
  `titmst_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `titmst_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `titmst_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`titmst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `user_mst` (
  `user_id` char(8) NOT NULL COMMENT '사용자ID',
  `user_name` char(20) NOT NULL COMMENT '사용자명',
  `user_pswd` char(20) NOT NULL COMMENT '패스워드',
  `user_team` char(4) NOT NULL COMMENT '부서코드',
  `user_titmst_id1` char(6) NOT NULL COMMENT '직무코드1',
  `user_titmst_id2` char(6) NOT NULL COMMENT '직무코드2',
  `user_titmst_id3` char(6) NOT NULL COMMENT '직무코드3',
  `user_dataaccess` char(1) NOT NULL COMMENT '자료접근권한',
  `user_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `user_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `user_user_id` char(8) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;







