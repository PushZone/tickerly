class Store < ActiveRecord::Base
  has_many :store_discounts, :dependent => :destroy
end
