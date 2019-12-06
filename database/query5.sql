with Doctors_Attendance as (
  select d.did,
         count(schid)                       as count,
         extract(year from SCHEDULE.date_time) as year
    from SCHEDULE
           join doctor d on SCHEDULE.id1 = d.did
   where extract(year from SCHEDULE.date_time) + 1 >= extract(year from CURRENT_DATE)
   group by d.did, year
)
select *
  from (
    select did, count(year) as count, sum(count) as sum, year
      from Doctors_Attendance
     group by did, year
  ) as Doctors_Att_Grouped
 where count >= 1 and sum >= 100;
