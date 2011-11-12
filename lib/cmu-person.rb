require 'net/ldap'

module CMU
  class Person
  	class RecordNotFound < StandardError;	end

  	def initialize(andrewid)
  		raise RecordNotFound unless @data = fetch(andrewid)
  	end

    def fetch(user)
      ldap = Net::LDAP.new(:host => 'ldap.andrew.cmu.edu')
      ldap.search(:base => 'ou=Person,dc=cmu,dc=edu', 
                  :filter => 'cmuAndrewId='+user ).first
    end

    def andrew_id
      @data[:cmuAndrewId].last
    end

    def name
  		@data[:cn].last
    end
  
    def last_name
  		@data[:sn].last
    end
  
    def first_name
  		@data[:givenname].last
    end
  
    def email
    	if @data.attribute_names.include?(:cmupreferredmail)
  	  	@data[:cmupreferredmail].last
  	  else
    		@data[:mail].last
    	end
    end
  
    def type 
    	@data[:edupersonaffiliation].last
    end
  
    def title
     	if @data.attribute_names.include?(:title)
  			@data[:title].last
  		else
  	  	if @data.attribute_names.include?(:cmutitle)
  				@data[:cmutitle].last
  			else
  				nil
  			end
  		end  	
  	end
  
    def grade
    	if @data.attribute_names.include?(:cmustudentclass)
  			@data[:cmustudentclass].last
  		else
  			nil
  		end
  	end  	

    def department
  	  @data[:cmudepartment].last
    end

    def school
  	  @data[:edupersonschoolcollegename].last
    end
    
    def to_s
  		@data.collect{|i,j| i.to_s.ljust(30)+":\t"+(j.is_a?(Array) ? "[ "+j.join(", ")+" ]" : j.to_s)+"\n"}.join("\n")
  	end
  end
end