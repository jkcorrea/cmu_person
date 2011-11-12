CMU Person
==========

Originally inspired by [David Taylor](https://github.com/tinystatemachine)'s [andrewid](https://github.com/tinystatemachine/andrewid), CMU Person is a simple rubygem used for searching Carnegie Mellon's LDAP servers for student information.

Installation
------------
If you want to use this gem for personal use in your terminal, just type the following command in bash:
```bash
gem install cmu-person
```

If you plan to use this in a Rails project, add the following to your `Gemfile`:

```ruby
gem 'cmu-person'
```

Don't forget to run the `bundle` command to install the gem!

Usage
-----

```ruby
user = CMU::Person.new('svargo')
user.first_name #=> "Seth"
user.grade #=> "Junior"
```

```ruby
user = CMU::Person.new('i_dont_exist')
#=> RecordNotFound Exception
```