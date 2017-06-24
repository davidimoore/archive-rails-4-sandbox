# migrate things
[User, Thing, Minion].each(&:delete_all)

def attribute_set(columns, val)
  columns.inject({}) {|h, attr| h[attr] = val; h  }
end

def seed_things
  val = "x" * 100
  columns  = Thing.column_names - ["id", "created_at", "updated_at"]

  10000.times do |i|
    Thing.create(attribute_set(columns, val))
  end
end


def seed_users(quantity)
  quantity.times do
    User.create(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email
    )
  end
end

seed_users(10)


