require ('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new({'name' => 'Han Solo',
                      'species' => 'Human',
                      'bounty_value' => '100000',
                      'cashed_in' => "false"
                    })

bounty1.save()
