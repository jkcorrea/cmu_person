require 'spec_helper'

describe CMU::Person do
  before(:all) do
    @seth = CMU::Person.find('svargo')
    @jake = CMU::Person.find('jkcorrea')
    @evans = CMU::Person.find('ehauser')
    @profh = CMU::Person.find('lheimann')
    @kaycee = CMU::Person.find('kpalko')
  end

  it 'should fetch a valid user' do
    @seth.first_name.should eql('Seth')
    @seth.last_name.should eql('Vargo')
    @seth.andrew_id.should eql('svargo')
  end

  it 'should fetch another valid user' do
    @jake.first_name.should eql('Jacob')
    @jake.last_name.should eql('Correa')
    @jake.andrew_id.should eql('jkcorrea')
  end

  it 'new/find! should raise an exception for an invalid user' do
    lambda { CMU::Person.new('not_a_real_user') }.should raise_exception(CMU::RecordNotFound)
    lambda { CMU::Person.find!('not_a_real_user') }.should raise_exception(CMU::RecordNotFound)
  end

  it 'find not raise an exception for an an invalid user' do
    lambda { CMU::Person.find('not_a_real_user') }.should_not raise_exception
  end

  it 'should return the user\'s email' do
    @seth.email.should eql('svargo@andrew.cmu.edu')
  end

  it 'should return the user\'s phone' do
    @seth.phone.should eql('8144211811')
  end

  it 'should return nil if phone is blank' do
    @jake.phone.should be_nil
  end

  it 'should return the correct student type' do
    @jake.type.should eql('Student')
  end

  it 'should return the correct faculty type' do
    @profh.type.should eql('Faculty')
  end

  it 'should return the correct staff type' do
    @kaycee.type.should eql('Staff')
  end

  it 'should return the correct title' do
    @seth.title.should eql('Mr. President')
    @profh.title.should eql('Teaching Professor')
    @kaycee.title.should eql('Housefellow/Cdtr. Of Student Activities')
  end

  it 'should return nil if title is blank' do
    @evans.title.should be_nil
  end

  it 'should return the user\'s grade' do
    @seth.grade.should be_nil
    @jake.grade.should eql('Junior')
  end

  it 'should return nil if grade is blank' do
    @profh.grade.should be_nil
    @kaycee.grade.should be_nil
  end

  it 'should return the correct department' do
    @profh.department.should eql('Is Program In Dietrich')
    @kaycee.department.should eql('Student Campus Activities')
    @jake.department.should eql('Dietrich College Interdisciplinary')
    @evans.department.should eql('Electrical & Computer Engineering')
  end

  it 'should return the correct school' do
    @profh.school.should eql('Dietrich College of Humanities and Social Sciences')
    @seth.school.should eql('Dietrich College of H&SS')
    @evans.school.should eql('Carnegie Institute of Technology')
  end

  it 'should return nil if school is blank' do
    # Currently can't find anyone in system that has nil school..
    # @kaycee.school.should be_nil
  end
end
