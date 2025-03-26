
-- ----------------------------
-- Procedure structure for Proc_GetTopSieuHang
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_GetTopSieuHang`;
delimiter ;;
CREATE PROCEDURE `Proc_GetTopSieuHang`(IN `$player_id` INT, IN `$get_can_fight` SMALLINT)
    SQL SECURITY INVOKER
BEGIN
  DECLARE $rank int DEFAULT 0;
  DECLARE $id int DEFAULT 0;
  DECLARE $message varchar(100);
  DECLARE $count int;
  DECLARE $i int DEFAULT 0;

SELECT
    `rank` INTO $rank
FROM `super`
WHERE player_id = $player_id;

IF $get_can_fight = 0 THEN
    DROP TEMPORARY TABLE IF EXISTS tbResult;
    CREATE TEMPORARY TABLE IF NOT EXISTS tbResult
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    CAST('' AS char(100)) AS message
FROM `super`
ORDER BY `rank`
    LIMIT 0, 100;

INSERT INTO tbResult
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    CAST('' AS char(100)) AS message
FROM `super`
WHERE `rank` BETWEEN $rank - 5 AND $rank + 5;
ELSE
    DROP TEMPORARY TABLE IF EXISTS tbResult;
    CREATE TEMPORARY TABLE IF NOT EXISTS tbResult
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    CAST('' AS char(100)) AS message
FROM `super`
WHERE player_id = $player_id;

INSERT INTO tbResult
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    CAST('' AS char(100)) AS message
FROM `super`
WHERE `rank` < $rank
  AND is_fight <> TRUE
ORDER BY `rank` DESC
    LIMIT 0, 10;

INSERT INTO tbResult
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    CAST('' AS char(100)) AS message
FROM `super`
WHERE `rank` BETWEEN $rank - 505 AND $rank - 500;
END IF;

SELECT
    COUNT(1) INTO $count
FROM tbResult;

WHILE $i < $count DO
SELECT
    player_id INTO $id
FROM tbResult
ORDER BY `rank`
    LIMIT $i, 1;

UPDATE tbResult a
    INNER JOIN (SELECT
    id,
    GROUP_CONCAT(a.tb SEPARATOR ' /n ') AS message
    FROM (SELECT
    $id AS id,
    CONCAT(a.dau, a.giua, a.sau) AS `tb`
    FROM (SELECT
    CASE WHEN player_attack = $id THEN CASE WHEN status = 1 THEN 'Hạ ' ELSE 'Thua ' END ELSE CASE WHEN status = 1 THEN 'Thua bởi ' ELSE 'Hạ bởi ' END END AS `dau`,
    CASE WHEN player_attack = $id THEN CONCAT(c.name, ' ', '[', a.be_rank, '] ') ELSE CONCAT(b.name, ' ', '[', a.rank, '] ') END `giua`,
    CASE WHEN HOUR(TIMEDIFF(NOW(), a.created_date)) > 0 THEN CONCAT(HOUR(TIMEDIFF(NOW(), a.created_date)), 'giờ trước') ELSE CASE WHEN MINUTE(TIMEDIFF(NOW(), a.created_date)) > 0 THEN CONCAT(MINUTE(TIMEDIFF(NOW(), a.created_date)), 'phút trước') ELSE CONCAT(SECOND(TIMEDIFF(NOW(), a.created_date)), 'giây trước') END END AS `sau`
    FROM super_history a
    INNER JOIN player b
    ON a.player_attack = b.id
    INNER JOIN player c
    ON a.player_be_attack = c.id
    WHERE (player_attack = $id
    OR player_be_attack = $id)
    AND YEAR(created_date) = YEAR(NOW())
    AND MONTH(created_date) = MONTH(NOW())
    AND DAY(created_date) = DAY(NOW())
    ORDER BY a.created_date DESC) a) a) b
ON a.player_id = b.id
    SET a.message = b.message
WHERE a.player_id = $id;

SET $i = $i + 1;
END WHILE;

SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    dame,
    defend,
    rank,
    message
FROM tbResult
GROUP BY player_id,
         head,
         name,
         data_point,
         items_body,
         pet_info,
         dame,
         defend,
         rank,
         message
ORDER BY `rank`;

DROP TEMPORARY TABLE IF EXISTS tbResult;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Proc_Insert_TopWhis_History
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_Insert_TopWhis_History`;
delimiter ;;
CREATE PROCEDURE `Proc_Insert_TopWhis_History`(IN `$player_id` DOUBLE, IN `$time` DOUBLE)
    SQL SECURITY INVOKER
BEGIN
  DECLARE $level int DEFAULT 0;
SELECT
    COALESCE(MAX(level), 0) AS level INTO $level
FROM top_whis
WHERE player_id = $player_id;

SET $level = $level + 1;

INSERT INTO top_whis (player_id, time_kill, LEVEL, last_time_attack)
VALUES ($player_id, $time, $level, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Proc_Update_BXH_New_Day_Super
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_Update_BXH_New_Day_Super`;
delimiter ;;
CREATE PROCEDURE `Proc_Update_BXH_New_Day_Super`()
    SQL SECURITY INVOKER
BEGIN
TRUNCATE TABLE super_top;

INSERT INTO super_top (player_id, head, NAME, data_point, items_body, pet_info, hp, dame, defend, `rank`, can_get_reward, is_fight, turn_per_day, is_get_reward_day, modified_date)
SELECT
    player_id,
    head,
    name,
    data_point,
    items_body,
    pet_info,
    hp,
    dame,
    defend,
    rank,
    can_get_reward,
    is_fight,
    turn_per_day,
    is_get_reward_day,
    modified_date
FROM super
WHERE rank >= 1
  AND rank <= 30;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Proc_Update_RankSuper
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_Update_RankSuper`;
delimiter ;;
CREATE PROCEDURE `Proc_Update_RankSuper`(IN `$player_win` INT, IN `$player_lose` INT)
    SQL SECURITY INVOKER
BEGIN
  DECLARE $rankMax int DEFAULT 0;
  DECLARE $rankMaxOne int DEFAULT 0;
  DECLARE $rankMaxTwo int DEFAULT 0;

  DECLARE $rankMaxOneOld int DEFAULT 0;
  DECLARE $rankMaxTwoOld int DEFAULT 0;

SELECT
    MAX(`rank`) INTO $rankMax
FROM `super`;

SELECT
    `rank` INTO $rankMaxOneOld
FROM `super`
WHERE player_id = $player_win;

SELECT
    `rank` INTO $rankMaxTwoOld
FROM `super`
WHERE player_id = $player_lose;

SET $rankMaxOne = $rankMax + FLOOR(1000 + RAND() * (2000 - 1000 + 1));
  SET $rankMaxTwo = $rankMax + FLOOR(2000 + RAND() * (3000 - 2000 + 1));

UPDATE `super`
SET `rank` = $rankMaxOne * (-1)
WHERE player_id = $player_win;

UPDATE `super`
SET `rank` = $rankMaxTwo * (-1)
WHERE player_id = $player_lose;

UPDATE `super`
SET `rank` = $rankMaxTwoOld
WHERE player_id = $player_win;

UPDATE `super`
SET `rank` = $rankMaxOneOld
WHERE player_id = $player_lose;
END
;;
delimiter ;
