--function to return the platforms available for a game :

CREATE OR REPLACE FUNCTION GetGamePlatforms(game VARCHAR(100))
RETURNS TABLE (platforms VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        t2.platform_id
    FROM game_platform t1
    INNER JOIN
        platform t2
    ON
        t1.platform_id = t2.platform_id
    INNER JOIN
        game t3
    ON
        t1.game_id = t3.game_id
    WHERE
        t3.game_id = game;
END;
$$;

--function to return all the company information of a game :

CREATE OR REPLACE FUNCTION GetCompanyInfo(game VARCHAR(100))
    RETURNS TABLE(company_name VARCHAR(100),
    founder VARCHAR(50),
    year_founding INT,
    location VARCHAR(100),
    employee_number INT)
LANGUAGE plpgsql
AS $$
    BEGIN
        RETURN QUERY
        SELECT
            t1.company_id AS company_name,
            t1.founder,
            t1.year_founding,
            t1.location,
            t1.employee_number
        FROM
            company t1
        INNER JOIN
                game t2
        ON t1.company_id = t2.company_id
        WHERE t2.game_id = game;
    END;
$$;

--function to display information about the championship of a game if it exists :

CREATE OR REPLACE FUNCTION GetChampionshipInfo(game_name VARCHAR(100))
RETURNS TABLE(championship_id VARCHAR(100), finals_date DATE, location VARCHAR(50), winner_team VARCHAR(50), prize_pool_us BIGINT) AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM championship c
        WHERE c.game_id = game_name
    ) THEN
        RAISE NOTICE 'No championships available for the game: %', game_name;
        RETURN;
    END IF;

    RETURN QUERY
    SELECT
        c.championship_id,
        c.finals_date,
        c.location,
        c.winner_team,
        c.prize_pool_us
    FROM
        project.championship c
    WHERE
        c.game_id = game_name;
END;
$$ LANGUAGE plpgsql;





