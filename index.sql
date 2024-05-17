--hash index for game_id on table game:

CREATE INDEX IF NOT EXISTS idx_game_id ON game USING HASH(game_id);

--btree index for pegi_age_rating col on table game:

CREATE INDEX IF NOT EXISTS idx_age_rate ON game USING btree(pegi_age_rating);

--btree index for release_year col on table game:

CREATE INDEX IF NOT EXISTS idx_release_year ON game USING btree(release_year);

--hash index for company_id on table company:

CREATE INDEX IF NOT EXISTS idx_company_id ON company USING btree(company_id);

--hash index for player_id on table player:

CREATE INDEX IF NOT EXISTS idx_player_id ON player USING hash(player_id);

--btree index for age on table player:

CREATE INDEX IF NOT EXISTS idx_player_age ON player USING btree(age);
