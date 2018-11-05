DataMapper.setup(:default, 'sqlite:database/database.sqlite')


# Main database setup
class Woods
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :imgurl, String
  property :name, String
  property :name_latin, String
  property :bio, Text
  property :heartwood, String
  property :sapwood, String
  property :density, Integer
  property :silica, String
  property :tangshrink, Float
  property :radshrink, Float
  property :movement, String
  property :texture, String
  property :workable, String
  property :rapture, Float
  property :elasticity, Float
  property :crush, Float
  property :sheer, Float
  property :purpose, String
  property :lang, String
  property :created_at, String
  property :created_by, Integer
  property :updated_at, String
  property :updated_by, Integer

end

class WoodLabels
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :alias, String
  property :description_en, String
  property :description_pt, String
  property :suffix, String
  property :lang, String
end

class Products
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :imgurl, String
  property :name, String
  property :bio, Text
  property :lang, String
  property :created_at, String
  property :created_by, Integer
  property :updated_at, String
  property :updated_by, Integer
end

class Editors
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :username, String
  property :email, String
  property :password, BCryptHash
  property :last_login, String
end

class Personel
	include DataMapper::Resource
	property :id, Serial, :key => true
	property :name, String
	property :imgurl, String
end


DataMapper.finalize
DataMapper.auto_upgrade!
