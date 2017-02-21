describe "counter caches" do
  it "increments associations when created" do
    user = User.create(first_name: "David", last_name: "Moore", email:"david@moore.com")

    #creating a thread with the user
    user.minions.create

    expect(user.minions_count).to eq 1

    #create a thread with its own class and associating it to the user
    Minion.create(user: user)

    expect(user.minions_count).to eq 2

    #destroy a forum thread and check if form_threads_count is updated
    Minion.last.destroy

    expect(user.reload.minions_count).to eq 1

  end


end