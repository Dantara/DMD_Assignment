SELECT room
  FROM SCHEDULE
 WHERE (date_time='2000-12-31') and (id1='6') and (id2 IN (
     SELECT did
       FROM DOCTOR
      WHERE ((name LIKE 'L%' OR name LIKE 'M%') AND NOT (name LIKE '% L%' OR name LIKE '% M%'))OR((name LIKE '% L%' OR name LIKE '% L%') AND NOT (name LIKE 'L%' OR name LIKE 'M%'))));
