with Doctors_Attendance as (
  select DOCTOR.did,
         count(ap_id)                       as count,
         extract(year from SHEDULE.date_time) as year
    from SHEDULE
           join doctor d on SHEDULE.id1 = DOCTOR.did
   where extract(year from SHEDULE.date_time) + 10 >= extract(year from CURRENT_DATE)
   group by DOCTOR.did, year
)
select *
  from (
    select did, count(year) as count, sum(count) as sum, year
      from SHEDULE
     group by did, year
  ) as Doctors_Att_Grouped
 where count >= 10 and sum >= 100
       ;
