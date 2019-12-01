with Dates as (
  select *
    from generate_series(
      CURRENT_DATE - '1 year'::Interval,
      CURRENT_DATE,
      '1 day'::Interval
    )
)
select Doctor_Id, Day_Of_Week, count(Day_Of_Week)
  from (
    select Doctor_Id, to_char(Date, 'dy') as Day_Of_Week
      from SCHEDULE
     where Date in (select * from Dates)
  ) as With_Weekdays
 group by Day_Of_Week, Doctor_Id;