-- game revenue model and success view :

CREATE VIEW game_revenue_model AS
SELECT 
    t1.game_id AS game_name,
    t1.purchase AS revenue_model,
    t1.users_number AS user_count,
    t1.rating,
    t2.company_id AS manifacturer,
    t2.founder,
    t2.location,
    t2.year_founding AS company_year_foundation
FROM game t1
JOIN company t2 ON t1.company_id = t2.company_id
ORDER BY t1.users_number DESC;

-- team earnings and success view :

CREATE VIEW earnings_and_championships AS
SELECT 
    t1.team_id,
    t1.full_name AS team_name,
    t1.total_earnings_us,
    COUNT(t2.championship_id) AS num_championships_won
FROM 
    team AS t1
LEFT JOIN 
    championship AS t2
ON 
    t1.team_id = t2.winner_team
GROUP BY 
    t1.team_id, t1.full_name, t1.total_earnings_us
ORDER BY 
    t1.total_earnings_us DESC;

-- free to play windows games view :

CREATE VIEW ftp_windows_games AS
SELECT t1.game_id AS window_games,t1.genre,t1.pegi_age_rating,t1.release_year,t1.rating 
FROM game t1 
JOIN game_platform t2 ON t1.game_id = t2.game_id
WHERE t1.purchase = 'FTP' AND t2.platform_id = 'Windows';