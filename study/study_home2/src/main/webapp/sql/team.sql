CREATE TABLE `team` (
  `team_id` char(4) NOT NULL COMMENT '부서코드',
  `team_name` char(20) NOT NULL COMMENT '부서명',
  `team_upteam` char(8) NOT NULL COMMENT '상위부서',
  `team_reg_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  `team_update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '최종수정일시',
  `team_user_id` char(20) NOT NULL COMMENT '최종사용자',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

