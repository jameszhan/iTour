class Deal < ActiveRecord::Base
  attr_accessible :intro, :price, :provider, :type, :url
end
