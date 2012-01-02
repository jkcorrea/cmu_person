require 'spec_helper'

describe CMU::Person do
  before(:all) do
    @seth = CMU::Person.find('svargo')
    @bryan = CMU::Person.find('bleach')
    @dano = CMU::Person.find('dorbegoz')
    @profh = CMU::Person.find('lheimann')
    @kaycee = CMU::Person.find('kpalko')
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
  
  it 'new/find should raise an exception for an invalid user' do
    lambda { CMU::Person.new('not_a_real_user') }.should raise_exception(CMU::RecordNotFound)
    lambda { CMU::Person.find('not_a_real_user') }.should raise_exception(CMU::RecordNotFound)
  end
  
  it 'find_by_andrew_id not raise an exception for an an invalid user' do
    lambda { CMU::Person.find_by_andrew_id('not_a_real_user') }.should_not raise_exception
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
  
  it 'should return the correct title' do
    @seth.title.should eql('Head Grader')
    @profh.title.should eql('Teaching Professor')
    @kaycee.title.should eql('Housefellow/cdtr. of Student Activities')
  end
  
  it 'should return nil if title is blank' do
    @dano.title.should be_nil
  end
  
  it 'should return the user\'s grade' do
    @seth.grade.should eql('Senior')
    @bryan.grade.should eql('Sophomore')
  end
  
  it 'should return nil if grade is blank' do
    @profh.grade.should be_nil
    @kaycee.grade.should be_nil
  end
  
  it 'should return the correct department' do
    @profh.department.should eql('Is Program In Dietrich')
    @kaycee.department.should eql('Student Campus Activities')
    @seth.department.should eql('H&SS Interdisciplinary')
    @bryan.department.should eql('Mechanical Engineering')
    @dano.department.should eql('Civil & Environmental Engineering')
  end

  it 'should return the correct school' do
    @profh.school.should eql('Dietrich College of Humanities and Social Sciences')
    @seth.school.should eql('Dietrich College of Humanities and Social Sciences')
    @bryan.school.should eql('Carnegie Institute of Technology')
  end
  
  it 'should return nil if school is blank' do
    @kaycee.school.should be_nil
  end
end