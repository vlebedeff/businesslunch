desc 'Migrate all data to support groups'
task :migrate_to_groups => :environment do
  MANAGERS = ["vitali.tatarintev@yopeso.com",
              "lilian.erhan@yopeso.com",
              "dumitru.sciptov@yopeso.com",
              "victor.hadjioglo@yopeso.com",
              "dragos.gavrilovici@yopeso.com"]
  group = Group.where(name: 'Chisinau YOPESO').first_or_initialize
  group.currency_unit = 'Lei'
  group.save!

  Order.update_all(group_id: group.id)

  Freeze.update_all(group_id: group.id)

  User.find_each do |user|
    user.join_group group
    user.roles = nil
    user.save
    balance = User.where(id: user.id).pluck(:balance).first

    ug = user.current_user_group
    ug.balance = balance

    if MANAGERS.include? user.email
      ug.roles << :manager
    end

    ug.save!
  end
end
