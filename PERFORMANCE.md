###Tools
- Skylight
- [bullet gem](https://github.com/flyerhzm/bullet)
###Workers
- Enable for requests to 3rd party apps   
- Enable for processing Mailers
###ActiveRecord & SQL
- Indexes
- Identify any potential uses for find_each or find_in_batches
- Low-Level Caching
- Use ActiveRecord without instantiating models
  ```
  ActiveRecord::Base.connection.execute("select * from things")
  # returns unparsed values
  # => <PG::Result:0x007fbafb349d98 status=PGRES_TUPLES_OK ntuples=10 nfields=13 cmd_tuples=10> 
  ```
  ```
  ActiveRecord::Base.connection.select_values("select col5 from things")
  # returns an array of values
  # =>["xxxxxxxxxx", "xxxxxxxxxx", "xxxxxxxxxx", "xxxxxxxxxx", "xxxxxxxxxx"] 
  ```
  ```
  Thing.where("id < 10").update_all(col1: 'something')
  ```
- Preload any queries that include `has_many` or `belongs_to`  relationships
- Using select statements
  ```
  Thing.all.select([:id, :col1, :col5]).load
  ```
- Use joins with `select` and `array_agg` (for postgres)	
  ```
  Minion.where(id: 1).joins(:thing).select("things.col1", "minions.mcol4")
  ```
  VS
  
  ```
   query = “select id, col1, array_agg(mcol4) from things
            inner join
            (
                select thing_id, mcol4 from minions
            ) 
         minions on (things.id = minions.thing_id)
         group by id, col1"

    Thing.find_by_sql(query)
   ```
###Views
- ActionView
  ``` 
  # instead of
  
  <% objects.each do |object| %>
  <%= render partial: 'object', locals: { object: object } %>
  <% end %>
  
  # use
  <%= render @objects %>
  ```        
- Fragment Caching
  ```
  <% cache(action_suffix: "primary") do %>  
  <section class="hero">  
    <div class="container">
      ...
    </div>
  </section>
  
  <section class="data">  
    <div class="container">
      ...
    </div>
  </section>  
  ...
  <% end %> 
  ```
- Collection Caching
  ```
   <%= render partial: 'products/product', collection: @products, cached: true %>
   ```
- Russian Doll Caching for nested views

###Reference
- [Rails Guides - Performance Testing](http://guides.rubyonrails.org/v3.2.13/performance_testing.html)

