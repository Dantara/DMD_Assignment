SELECT room
  FROM SCHEDULE
 WHERE (date_time='2019-05-19') and (id1='13') and (id2 IN (
     SELECT did
       FROM DOCTOR
      WHERE ((name LIKE 'L%' OR name LIKE 'M%') AND NOT (name LIKE '% L%' OR name LIKE '% M%'))OR((name LIKE '% L%' OR name LIKE '% L%') AND NOT (name LIKE 'L%' OR name LIKE 'M%'))));
