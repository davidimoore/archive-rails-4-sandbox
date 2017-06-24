class Profile < SimpleDelegator
  extend ActiveModel::Naming

  # From https://robots.thoughtbot.com/decorating-activerecord

  def title
    "#{first_name} #{last_name}'s profile"
  end

  def to_model
    self
  end

  def to_partial_path
    "profiles/profile"
  end
end