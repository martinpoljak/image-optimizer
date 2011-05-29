Image Optimizer
===============

**Image Optimizer** optimizes given JPEG and PNG images or images in 
given folder. Performs the following for PNG:

1. rewrites PNG file using `convert`,
2. optimizes it using `optipng`.

And for JPEG:

1. strips all unnecessary metadata using `jpegoptim`,
2. optimizes using `jpegtran`.

## Usage

Simply both for filrs or whole directories:
    
    ImageOptimizer::optimize("./some-dir", :strip => false, :level => 7) do |file|
        p file    # prints out target filename
    end

Where `:strip` option indicates it should strip all metadata from 
JPEG files. Default is `true`. `:level` indicates level of 
PNG optimization. Default is `7`.

## Requirements

Following software for full functionality is necessary:

* [UNIX][2]-like system (*required*),
* [Ruby][1] (*required*),
* [whereis][3] (*required*),
* [ImageMagick][8],
* [Jpegtran][5],
* [Jpegoptim][6],
* [OptiPNG][7].

Steps which requires non-strictly required components will be silently 
ignored if these components will not be available.

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][9] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.

Copyright
---------

Copyright &copy; 2011 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[1]: http://www.ruby-lang.org/
[2]: http://en.wikipedia.org/wiki/Unix
[3]: http://en.wikipedia.org/wiki/Linux
[4]: http://linux.die.net/man/1/whereis
[5]: http://linux.die.net/man/1/jpegtran
[6]: http://freshmeat.net/projects/jpegoptim/
[7]: http://optipng.sourceforge.net/
[8]: http://www.imagemagick.org/
[9]: http://github.com/martinkozak/image-optimizer/issues
[10]: http://www.martinkozak.net/
