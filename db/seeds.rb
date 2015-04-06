# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  roles = Role.create([{ name: 'admin', ability: 0  }, { name: 'origin', ability: 3 }])
  user = User.new
  user.username = "simon"
  user.encrypt_password = user.md5("simon123")
  user.email = "xsqfeather@126.com"
  user.mobile = "18820965455"
  user.role = roles.first
  user.save

  catalog = Catalog.new
  catalog .name = 'root'
  catalog.save

  catalog1 = Catalog.new
  catalog1.name = '软件'
  catalog1.fid = catalog._id

  catalog2 = Catalog.new
  catalog2.name = '食品'
  catalog2.fid = catalog._id
  
