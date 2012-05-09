class Deal < ActiveRecord::Base
  attr_accessible :image, :intro, :price, :provider, :catalog, :url
end
