SELECT SUM(count) FROM (SELECT COUNT(pid)*200 FROM PATIENT
                         WHERE (current_date-date_of_birth)/365<50 AND pid IN 
                               (SELECT id1 FROM
                                               (SELECT id1, COUNT(id1) FROM SCHEDULE WHERE
datetime>=current_date-interval'1 month'::date and datetime <=current_date::date)
                                 WHERE count<3
                               )
                           AND
                        SELECT COUNT(pid)*250 FROM PATIENT
                         WHERE (current_date-date_of_birth)/365<50 AND pid IN 
                               (SELECT id1 FROM
                                               (SELECT id1, COUNT(id1) FROM SCHEDULE WHERE
datetime>=current_date-interval'1 month'::date and datetime <=current_date::date)
                                 WHERE count>=3
                               )
                           AND
                        SELECT COUNT(pid)*400 FROM PATIENT
                         WHERE (current_date-date_of_birth)/365>=50 AND pid IN 
                               (SELECT id1 FROM
                                               (SELECT id1, COUNT(id1) FROM SCHEDULE WHERE
datetime>=current_date-interval'1 month'::date and datetime <=current_date::date)
                                 WHERE count<3
                               )
                           AND
                        SELECT COUNT(pid)*500 FROM PATIENT
                         WHERE (current_date-date_of_birth)/365>=50 AND pid IN 
                               (SELECT id1 FROM
                                               (SELECT id1, COUNT(id1) FROM SCHEDULE WHERE
datetime>=current_date-interval'1 month'::date and datetime <=current_date::date)
                                 WHERE count>=3
                               ));
