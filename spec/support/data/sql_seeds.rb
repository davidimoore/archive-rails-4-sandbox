def many_things_seed
  <<-END
      insert into things(
        col0,
        col1,
        col2,
        col3,
        col4,
        col5,
        col6,
        col7,
        col8,
        col9,
        created_at,
        updated_at)
        (select
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        rpad('x', 100, 'x'),
        '2017-07-25T22:11:31-07:00',
        '2017-07-25T22:11:31-07:00'
        from generate_series(1, 10000)
      );
  END
end