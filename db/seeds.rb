# migrate things
Thing.delete_all
Minion.delete_all



def attribute_set(columns, val)
  columns.inject({}) {|h, attr| h[attr] = val; h  }
end
val = "x" * 100
columns  = Thing.column_names - ["id", "created_at", "updated_at"]

10000.times do |i|
  Thing.create(attribute_set(columns, val))
end
