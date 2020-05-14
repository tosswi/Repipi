if Rails.env.production?
    storage :fog
  else
    storage :file
  end