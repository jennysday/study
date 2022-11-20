
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
        