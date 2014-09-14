class User < ActiveRecord::Base
  include UserExtention
  
  validate :nickname, presence: true, length: { maximum: 100 }
  
end
