## Get Slides

This program gets a series of images from a website, all with a particular format (prefix+number+sufix). Then it appends a HTML navigation page for each image, which includes the images.

The idea was to download slides from a presentation online which used a similar structure, namely a presentation from Matz at OSCON 2003: <http://www.rubyist.net/~matz/slides/oscon2003/index.html>

### Usage

    chmod +x get_slides.rb
    ./gets_slides.rb url folder -V

Where -V means verbose (optional).

#### Examples

    ./get_slides.rb http://www.rubyist.net/~matz/slides/oscon2003/ temp
    ./get_slides.rb http://www.rubyist.net/~matz/slides/rc2002/ Matz-2002-RC-Be_Minor_Be_Cool -V
    ./get_slides.rb http://www.rubyist.net/~matz/slides/kyrgyz/ ../slides/Matz-2006-kyrgyz-Ruby_The_Object-Oriented_Language -V
    ./get_slides.rb http://www.rubyist.net/~matz/slides/rc2001-a/ ~/Downloads/Matz_slides/Matz-2001-rc-Human-Oriented_Programming_in_Ruby -V

### Note

  So far it is a bare bones program, with minimal error control on the arguments passed

February 2015
