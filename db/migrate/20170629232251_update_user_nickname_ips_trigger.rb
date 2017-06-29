class UpdateUserNicknameIpsTrigger < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE FUNCTION update_user_nickname_ips() RETURNS trigger AS $update_user_nickname_ips$
      DECLARE
        username users.nickname%TYPE;
      BEGIN
        SELECT INTO username nickname FROM users WHERE users.id = new.user_id;
      
        if NOT exists(select * FROM user_nickname_ips WHERE user_nickname_ips.nickname = username AND user_nickname_ips.user_ip = new.user_ip) then
          INSERT INTO user_nickname_ips (nickname, user_ip) VALUES (username, new.user_ip);
        end if;
        return new;
      END;
      $update_user_nickname_ips$ LANGUAGE  plpgsql;
      
      CREATE TRIGGER update_user_nickname_ips AFTER INSERT ON articles
      FOR EACH ROW EXECUTE PROCEDURE update_user_nickname_ips();
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS update_user_nickname_ips() CASCADE;
    SQL
  end
end
