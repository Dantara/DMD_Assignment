with Dates as (
  select *
    from generate_series(
      CURRENT_DATE - '1 year'::Interval,
      CURRENT_DATE,
      '1 day'::Interval
    )
)
select id2, Day_Of_Week, count(Day_Of_Week)
  from (
    select id2, to_char(date_time, 'dy') as Day_Of_Week
      from SCHEDULE
     where date_time in (select * from Dates)
  ) as With_Weekdays
 group by Day_Of_Week, id2;
