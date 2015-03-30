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

  
