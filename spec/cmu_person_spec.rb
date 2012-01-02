require 'spec_helper'

describe CMU::Person do
  before(:all) do
    @seth = CMU::Person.new('svargo')
    @bryan = CMU::Person.new('bleach')
    @profh = CMU::Person.new('lheimann')
    @kaycee = CMU::Person.new('kpalko')
  end
  
  it 'should fetch a valid user' do
    @seth.first_name.should eql('Seth')
    @seth.last_name.should eql('Vargo')
    @seth.andrew_id.should eql('svargo')
  end
  
  it 'should fetch another valid user' do
    @bryan.first_name.should eql('Bryan')
    @bryan.last_name.should eql('Leach')
    @bryan.andrew_id.should eql('bleach')
  end
  
  it 'should raise an exception for an invalid user' do
    lambda { CMU::Person.new('not_a_real_user') }.should raise_exception(CMU::RecordNotFound)
  end
  
  it 'should return the user\'s email' do
    @seth.email.should eql('svargo@andrew.cmu.edu')
  end
  
  it 'should return the user\'s phone' do
    @seth.phone.should eql('8144211811')
  end
  
  it 'should return nil if phone is blank' do
    @bryan.phone.should be_nil
  end
  
  it 'should return the correct student type' do
    @seth.type.should eql('Student')
  end
  
  it 'should return the correct faculty type' do
    @profh.type.should eql('Faculty')
  end
  
  it 'should return the correct staff type' do
    @kaycee.type.should eql('Staff')
  end
  
  it 'should return the user\'s grade' do
    @seth.grade.should eql('Senior')
    @bryan.grade.should eql('Sophomore')
  end
  
  it 'should return nil if grade is blank' do
    @profh.grade.should be_nil
    @kaycee.grade.should be_nil
  end
end