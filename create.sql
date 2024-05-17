CREATE SCHEMA IF NOT EXISTS project;

CREATE TABLE IF NOT EXISTS project.Company(
    company_id VARCHAR(100) PRIMARY KEY,
    founder VARCHAR(50) NOT NULL,
    year_founding INT NOT NULL,
    location VARCHAR(100),
    employee_number INT,
    CONSTRAINT ck1_year CHECK(year_founding <= 2023),
    CONSTRAINT ck5_employee CHECK(employee_number >= 0)
);



CREATE TABLE IF NOT EXISTS project.Game(
    game_id VARCHAR(100) PRIMARY KEY,
    company_id VARCHAR(100),
    release_year INT,
    purchase VARCHAR(10) DEFAULT('FTP'),
    users_number BIGINT,
    genre VARCHAR(100) NOT NULL,
    pegi_age_rating INT NOT NULL,
    offline BOOL NOT NULL,
    online BOOL NOT NULL,
    rating NUMERIC(3,1),
    FOREIGN KEY (company_id) REFERENCES Company(company_id),
    CONSTRAINT ck2_year CHECK(release_year <= 2023),
    CONSTRAINT ck3_rating CHECK(rating BETWEEN 0 AND 5)
);


CREATE TABLE IF NOT EXISTS project.Platform(
    platform_id VARCHAR(50) PRIMARY KEY,
    manufacturer VARCHAR(150)
);



CREATE TABLE IF NOT EXISTS project.Game_Platform(
    index_id SERIAL PRIMARY KEY,
    game_id VARCHAR(100),
    platform_id VARCHAR(50),
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id),
    FOREIGN KEY (game_id) REFERENCES  Game(game_id)
);


CREATE TABLE IF NOT EXISTS project.Team(
    team_id VARCHAR(50) PRIMARY KEY,
    full_name VARCHAR(100),
    country VARCHAR(50) NOT NULL,
    created_date DATE,
    disbanded_date DATE DEFAULT ('9999-09-09'),
    total_earnings_us BIGINT CHECK(total_earnings_us >= 0),
    CONSTRAINT ck4_date CHECK( created_date < disbanded_date)
);


CREATE TABLE IF NOT EXISTS project.Championship(
    index_id SERIAL PRIMARY KEY,
    game_id VARCHAR(100),
    championship_id VARCHAR(100) NOT NULL,
    finals_date DATE,
    location VARCHAR(50),
    winner_team VARCHAR(50),
    prize_pool_us BIGINT CHECK(prize_pool_us >= 0),
    FOREIGN KEY(game_id) REFERENCES Game(game_id),
    FOREIGN KEY(winner_team) REFERENCES Team(team_id)
);




CREATE TABLE IF NOT EXISTS project.Player(
    player_id VARCHAR(100) PRIMARY KEY,
    country VARCHAR(100),
    age INT CHECK(age > 0),
    tag_id VARCHAR(50),
    status VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS project.Current_Best_Player(
    game_id VARCHAR(100) PRIMARY KEY,
    player_id VARCHAR(100),
    start_date DATE NOT NULL ,
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);


CREATE TABLE IF NOT EXISTS project.Best_player_History(
    index_history SERIAL PRIMARY KEY,
    game_id VARCHAR(100),
    player_id VARCHAR(100),
    start_time DATE,
    end_time DATE,
    action_taken VARCHAR(20),
    FOREIGN KEY (game_id) REFERENCES Game(game_id),
    FOREIGN KEY (player_id) REFERENCES Player(player_id)
);
