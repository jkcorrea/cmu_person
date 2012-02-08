require 'net/ldap'

# ::nodoc::
# @private
module CMU
  # A CMU::Person class
  class Person
    # Attempts to create and return a new CMU::Person from the CMU LDAP directory.
    #
    # @param [String] the Andrew ID to search for
    # @raise [CMU::RecordNotFound] if the Andrew ID does not exist
    # @return [CMU::Person] a `CMU::Person` object
    def self.find(andrew_id)
      CMU::Person.new(andrew_id)
    end

    # Attempts to create and return a new CMU::Person from the CMU LDAP directory.
    #   Unlink (see #find), this method will not raise an exception if the Andrew
    #   ID is not found.
    #
    # @param [String] the Andrew ID to search for
    # @return [CMU::Person] a `CMU::Person` object
    def self.find_by_andrew_id(andrew_id)
      begin
       find(andrew_id)
     rescue
       nil
     end
   end

    # ::nodoc::
    # @private
    def initialize(andrew_id)
      ldap = Net::LDAP.new(:host => 'ldap.andrew.cmu.edu')
      @data = ldap.search(:base => 'ou=Person,dc=cmu,dc=edu', :filter => 'cmuAndrewId=' + andrew_id).first
      raise CMU::RecordNotFound if @data.nil?
    end

    # Returns the Andrew ID of the CMU Person
    #
    # @return [String] the Andrew ID of the CMU Person
    def andrew_id
      @andrew_id ||= @data[:cmuAndrewId].last
    end

    # Returns the full name of the CMU Person
    #
    # @return [String] the full name of the current CMU Person
    def name
      @name ||= @data[:cn].last
    end

    # Returns the last name of the CMU Person
    #
    # @return [String] the last name of the current CMU Person
    def last_name
      @last_name ||= @data[:sn].last
    end

    # Returns the first name of the CMU Person
    #
    # @return [String] the first name of the current CMU Person
    def first_name
      @first_name ||= @data[:givenname].last
    end

    # Returns the email of the CMU Person. If the CMU Person has
    #   listed a preferred email, it will be displayed. Otherwise,
    #   the official Andrew Email will be used.
    #
    # @return [String] the email of the current CMU Person
    def email
      if @data.attribute_names.include?(:cmupreferredmail)
        @email ||= @data[:cmupreferredmail].last
      else
        @email ||= @data[:mail].last
      end
    end

    # Returns the phone number for the CMU Person
    #
    # @return [String, nil] the phone number of the current CMU Person
    #   or nil if the person did not provide a phone number
    def phone
      if @data.attribute_names.include?(:cmupreferredtelephone)
        @phone ||= @data[:cmupreferredtelephone].last.gsub(/[^0-9]/,'')
      else
        @phone ||= nil
      end
    end

    # Returns the type for the CMU Person
    #
    # @return [String] the type or role of the CMU Person
    def type
      @type ||= @data[:edupersonaffiliation].last
    end

    # Returns the official title for the CMU Person
    #
    # @return [String, nil] the official title for the CMU Person or
    #   nil if the CMU Person has not provided a title
    def title
      if @data.attribute_names.include?(:title)
        @title ||= @data[:title].last
      else
        if @data.attribute_names.include?(:cmutitle)
          @title ||= @data[:cmutitle].last
        else
          @title ||= nil
        end
      end
    end

    # Returns the String representation of the grade of the CMU Person
    #
    # @return [String, nil] the String representation of the grade of
    #   the CMU Person ('Freshman', 'Sophomore', 'Junior', 'Senior',
    #   'Masters', 'Doctorate') or nil for Faculty and Staff
    def grade
      if @data.attribute_names.include?(:cmustudentclass)
        @grade ||= @data[:cmustudentclass].last
      else
        @grade ||= nil
      end
    end

    # Returns department for the CMU Person
    #
    # @return [String, nil] the department for the current CMU Person
    #   or nil if the CMU Person is a student and/or has no department
    def department
      @department ||= @data[:cmudepartment].last
    end

    # Returns the "college" for the CMU Person
    #
    # @return [String, nil] the actual college the CMU Person belongs to
    def school
      filters = ['Student Employment', 'Undergraduate Admission and Student Aid', 'VP For Campus Affairs']
      @school ||= @data[:edupersonschoolcollegename].reject{|c| filters.include?(c)}.last
    end

    # ::nodoc::
    # @private
    def inspect
      fields = %w(andrew_id first_name last_name email phone type title)
      @inspect ||= "<CMU::Person #{fields.collect{|f| f + ': ' + self.send(f.to_sym).inspect}.join(', ')}>"
    end

    # ::nodoc::
    # @private
    def to_s
      @to_s ||= "<CMU::Person \"#{self.send(:name)} (#{self.send(:andrew_id)})\">"
    end
  end
end