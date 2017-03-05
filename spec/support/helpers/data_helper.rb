module DataHelper

  def data_file(name)
    data_path + "/" + name
  end

  def data_path
    Rails.root.join("spec/data")
  end

  def fixture_path
    Rails.root.join("spec/support/fixtures/")
  end

  def inspect_count_of(obj)
    puts "\n\n\n"
    puts "Count of #{obj.class} is :#{obj.all.count}"
    puts "\n\n\n"
  end

  RSpec.configure do |config|
    config.include DataHelper
  end

end