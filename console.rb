require ('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new({'name' => 'Han Solo',
                      'species' => 'Human',
                      'bounty_value' => '100000',
                      'cashed_in' => 'false'
                    })

bounty1.save()

bounty2 = Bounty.new({'name' => 'Chewbacca',
                      'species' => 'Wookie',
                      'bounty_value' => '50000',
                      'cashed_in' => 'false'
                      })

bounty2.save()
result = Bounty.find_by_name('Han Solo')
result2 = Bounty.find_by_id(2)

binding.pry
bounty1.cashed_in = "true"
bounty1.update()


# result = Bounty.find_by_name('Han Solo')




# Bounty.delete_all()
# bounty2.delete()
