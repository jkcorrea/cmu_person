require 'net/ldap'

module CMU
  class Person
  	def initialize(andrewid)
  		raise CMU::RecordNotFound unless @data = fetch(andrewid)
  	end

    def fetch(user)
      ldap = Net::LDAP.new(:host => 'ldap.andrew.cmu.edu')
      ldap.search(:base => 'ou=Person,dc=cmu,dc=edu', 
                  :filter => 'cmuAndrewId='+user ).first
    end

    def andrew_id
      @andrew_id ||= @data[:cmuAndrewId].last
    end

    def name
  		@name ||= @data[:cn].last
    end
  
    def last_name
  		@last_name ||= @data[:sn].last
    end
  
    def first_name
  		@first_name ||= @data[:givenname].last
    end
  
    def email
    	if @data.attribute_names.include?(:cmupreferredmail)
  	  	@email ||= @data[:cmupreferredmail].last
  	  else
    		@email ||= @data[:mail].last
    	end
    end
    
    def phone
      if @data.attribute_names.include?(:cmupreferredtelephone)
        @phone ||= @data[:cmupreferredtelephone].last.gsub(/[^0-9]/,'')
      else
        @phone ||= nil
      end
    end
  
    def type 
    	@type ||= @data[:edupersonaffiliation].last
    end
  
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
  
    def grade
    	if @data.attribute_names.include?(:cmustudentclass)
  			@grade ||= @data[:cmustudentclass].last
  		else
  			@grade ||= nil
  		end
  	end  	

    def department
  	  @department ||= @data[:cmudepartment].last
    end

    def school
  	  @school ||= @data[:edupersonschoolcollegename].last
    end
    
    def to_s
      @data
  		#@to_s ||= @data.collect{|i,j| i.to_s.ljust(30)+":\t"+(j.is_a?(Array) ? "[ "+j.join(", ")+" ]" : j.to_s)+"\n"}.join("\n")
  	end
  end
end