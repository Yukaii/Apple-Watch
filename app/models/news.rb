class News < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
end
