require 'helper'

class TestCmuPerson < Test::Unit::TestCase
  should 'fetch a valid user' do
    user = CMU::Person.new('svargo')
    assert user.first_name == 'Seth'
    assert user.last_name == 'Vargo'
    assert user.andrew_id == 'svargo'
  end
  
  should 'not fetch an invalid user' do
    assert_raise(CMU::Person::RecordNotFound) { CMU::Person.new('not_a_user') }
  end
end