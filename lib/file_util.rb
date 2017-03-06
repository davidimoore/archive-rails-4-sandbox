module FileUtil
  def log_file(env: "development")
    "#{Rails.root}/log/#{env}.log"
  end

end