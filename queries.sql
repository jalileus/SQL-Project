--who is the current best player of League of Legends?

SELECT player_id FROM Current_Best_Player WHERE game_id = 'League of Legends';

--in which platforms one can play Hearthstone?

SELECT platform_id FROM game_platform WHERE game_id = 'Hearthstone';

--which championship has the most prize_pool of all the time and what is it?

SELECT prize_pool_us AS highest_prize_pool,championship_id FROM championship
WHERE prize_pool_us = (SELECT MAX(prize_pool_us) FROM  Championship);

--list the games released by Blizzard Entertainment after 2000:

SELECT game_id, release_year
FROM game
WHERE company_id = 'Blizzard Entertainment' AND release_year > 2000;

--list the number of games for each platform sorted by descending order:

SELECT platform_id AS platfrom,COUNT(game_id) AS number_of_games FROM game_platform
GROUP BY platform_id
ORDER BY 2 DESC;


--order the games with their rating,and show their release year,and their genre:

SELECT game_id, release_year, genre, rating
FROM game
ORDER BY rating DESC;

--select the active best players above 25:

SELECT player_id, country, age
FROM player
WHERE status = 'active' AND age > 25;

--list the full name of the winner teams and the champion they won:

SELECT T1.full_name AS winner_team_name, T2.championship_id
FROM championship AS T2
JOIN team AS T1 ON T2.winner_team = T1.team_id;

--count the number of games that are free to play:

SELECT purchase,Count(game_id) AS number_of_free_games FROM Game
WHERE purchase = 'FTP'
GROUP BY purchase;

--list all the games which can be played offline and online at the same time:

SELECT game_id as off_on_games FROM Game
WHERE offline = TRUE AND online = TRUE;

--use the function we have to get the platforms available for Fortnite game:

SELECT * FROM GetGamePlatforms('Fortnite');

--use the function we have to get company information of League of Legends game:

SELECT * FROM GetCompanyInfo('League of Legends');

--use the function we have to get information about championship of a game (League of Legends):

SELECT * FROM getchampionshipinfo('League of Legends');

--use the function we have to get information about championship of a game (Fortnite) (there are no championships for this game):

SELECT * FROM getchampionshipinfo('Fortnite');
