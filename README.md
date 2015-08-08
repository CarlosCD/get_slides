## Get Slides

This program gets a series of files from a website, assuming a particular format (prefix+number+sufix).

The idea was to download slides from a presentation online which uses this structure, a presentation from Matz at OSCON 2003: <http://www.rubyist.net/~matz/slides/oscon2003/index.html>

The script uses Threads. MRI allows parallelism on IO (even multicore), but assumes the GIL to compile the results of each Thread (lock to allow atomicity on Array#<<). So MRI has several advantages with this approach.

Tested with MRI Ruby 2.2.0.

### Usage

    chmod +x get_slides.rb
    ./gets_slides.rb url folder -V

Where -V means verbose (optional).

#### Examples

    ./get_slides.rb http://www.rubyist.net/~matz/slides/oscon2003/ temp
    ./get_slides.rb http://www.rubyist.net/~matz/slides/rc2002/ Matz-2002-RC-Be_Minor_Be_Cool -V
    ./get_slides.rb http://www.rubyist.net/~matz/slides/kyrgyz/ ../slides/Matz-2006-kyrgyz-Ruby_The_Object-Oriented_Language -V
    ./get_slides.rb http://www.rubyist.net/~matz/slides/rc2005/ ~/Downloads/Matz_slides/Matz-2005-RubyConf-Visions_for_the_Future -V

### Note

  It is so far a barebones program, with minimal error control on the arguments passed. A fast and dirty hack.

February 2015
