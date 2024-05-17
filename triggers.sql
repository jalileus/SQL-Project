--trigger function for disbanded date check :

CREATE OR REPLACE FUNCTION trigger_check_disbanded_date()
RETURNS trigger AS $$
BEGIN
    IF NEW.disbanded_date < NEW.created_date THEN
        RAISE EXCEPTION 'Disbanded date must be later than created date';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--trigger definition to call the function on insert or update :

CREATE TRIGGER trigger_on_team_date_check
BEFORE INSERT OR UPDATE ON project.Team
FOR EACH ROW
EXECUTE FUNCTION trigger_check_disbanded_date();


--trigger function for best player history updates :

CREATE OR REPLACE FUNCTION update_player_history()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.player_id IS DISTINCT FROM NEW.player_id THEN
	INSERT INTO project.best_player_history(
	game_id,player_id,start_time,end_time,action_taken)
	VALUES (OLD.game_id,OLD.player_id,OLD.start_date,NOW(),'update');
	END IF;
	RETURN NEW;
	END;
$$ LANGUAGE plpgsql;



--trigger definition to call the function on update or delete :

CREATE TRIGGER trigger_update_best_player_history
AFTER UPDATE OR DELETE ON project.current_best_player
FOR EACH ROW
EXECUTE FUNCTION update_player_history();

--trigger function to enforce the uniqueness of the player tag :

CREATE OR REPLACE FUNCTION unique_player_tag()
RETURNS TRIGGER AS $$
DECLARE
	tag_count INT;
BEGIN
	SELECT COUNT(*) INTO tag_count
	FROM project.player
	WHERE tag_id = NEW.tag_id AND player_id != NEW.player_id;
	
	IF tag_count > 0 THEN 
	RAISE EXCEPTION 'player tag must be unique';
	END IF;
	RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

-- trigger definition to call the function on update or insert : 

CREATE TRIGGER trigger_unique_tag
BEFORE INSERT OR UPDATE ON project.player
FOR EACH ROW
EXECUTE FUNCTION unique_player_tag();
