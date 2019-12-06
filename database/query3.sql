SELECT id1 FROM SCHEDULE
 WHERE (id1 IN 
        (SELECT id1 FROM
                        (SELECT id1, COUNT(id1) FROM SCHEDULE 
                          WHERE date_time<=date '$$given_date$$'-interval '3 weeks' AND date_time>=date '$$given_date$$'-interval '4 weeks' GROUP BY schedule.id1)as WEEK1 WHERE count>=2)
                          AND id1 IN
                          (SELECT id1 FROM 
                                          (SELECT id1, COUNT(id1) FROM SCHEDULE 
                                            WHERE date_time<=date '$$given_date$$'-interval '2 weeks' AND date_time>=date '$$given_date$$'-interval '3 weeks' GROUP BY schedule.id1)as WEEK2 WHERE count>=2)
                                            AND id1 IN
                                            (SELECT id1 FROM 
                                                            (SELECT id1, COUNT(id1) FROM SCHEDULE 
                                                              WHERE date_time<=date '$$given_date$$'-interval '1 week' AND date_time>=date '$$given_date$$'-interval '2 weeks' GROUP BY schedule.id1)as WEEK3 WHERE count>=2)
                                                              AND id1 IN
                                                              (SELECT id1 FROM 
                                                                              (SELECT id1, COUNT(id1) FROM SCHEDULE 
                                                                                WHERE date_time<=date '$$given_date$$' AND date_time>=date '$$given_date$$'-interval '1 week' GROUP BY schedule.id1)as WEEK4 WHERE count>=2)
 )
          ;
