
	(SELECT *
		FROM team
		    INNER JOIN user_mst
		    ON team.team_id = user_mst.user_team
		where team.team_id = 'A100');
        
        
        (SELECT *
		FROM team
		    INNER JOIN user_mst
		    ON team.team_id = user_mst.user_team
		where team.team_id = 'A100');
        
        select * from team where team_id = "A000";
        (select * from team where team_id like 'A%');
        
       (SELECT
			CASE
				WHEN team_id = 'A000'
				THEN 'CEO'
		END	
        from team);
        
        
			select * from team where team.team_id = 'A0%' ;
     
     SELECT *, LEFT(team_id, 2) as '상위부서코드 2자리' from team;
     
     
        SELECT *, LEFT(team_upteam, 2) as '상위부서코드 2자리' from team where LEFT(team_upteam, 2) like 'A0%';
        
         SELECT *, LEFT(team_upteam, 2) as '상위부서코드 2자리' from team where 'A0' like LEFT(team_upteam, 2);
         
         select * from team;
         select team_id, team_name from team;
         
         
         
(
select *
	 	from (
	 		select rownum, titmst_id, titmst_name, titmst_class, titmst_user_id, titdet_titmst_id, titdet_pgm_id, titdet_function,titdet_reg_date,titdet_update_date,titdet_user_id
	 			from (
	 				select @rownum := @rownum + 1 as rownum, titmst_id, titmst_name, titmst_class, titmst_user_id, titdet_titmst_id, titdet_pgm_id, titdet_function,titdet_reg_date,titdet_update_date,titdet_user_id
	 				from titledetail join titlemst on titledetail.titdet_titmst_id = titlemst.titmst_id, (select @rownum := 0) tmp
	 				order by titmst_id asc
	 			)  A
	 	)B
	 	where rownum >= 1 and rownum <= 10
);
        
select * from titledetail join titlemst on titledetail.titdet_titmst_id = titlemst.titmst_id;
            