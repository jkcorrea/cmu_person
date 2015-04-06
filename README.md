CMU Person
==========

[![Build Status](https://travis-ci.org/jkcorrea/cmu_person.svg)](https://travis-ci.org/jkcorrea/cmu_person)

A fork of [Seth Vargo's](https://github.com/sethvargo) [gem](https://github.com/sethvargo/cmu_person) being maintained here now. Originally inspired by [David Taylor](https://github.com/tinystatemachine)'s [andrewid](https://github.com/tinystatemachine/andrewid), CMU Person is a simple rubygem used for searching Carnegie Mellon's LDAP servers for student information.

Installation
------------
If you want to use this gem for personal use in your terminal, just type the following command in bash:

```bash
gem install cmu_person
```

If you plan to use this in a Rails project (or other project managed by Bundler), add the following to your `Gemfile`:

```ruby
gem 'cmu_person'
```

Don't forget to run the `bundle` command to install the gem!

Usage
-----

```ruby
user = CMU::Person.find('svargo')
user.first_name #=> "Seth"
user.grade #=> "Junior"
```

```ruby
user = CMU::Person.new('i_dont_exist') #=> CMU::RecordNotFound Exception
```

For a complete list of methods, view the [YARD Documentation](http://rubydoc.info/gems/cmu_person/0.0.3/frames)

License
-------
```text
Copyright (c) 2012-2013 Seth Vargo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
