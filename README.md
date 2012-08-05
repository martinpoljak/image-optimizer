Image Optimizer
===============

**Image Optimizer** optimizes given JPEG and PNG images or images in 
given folder. Uses several encoders for achieving the best possible 
*lossless* compression ratio and tries to employ the most advanced 
methods such as JPEG *algorithmic encoding* if available or PNG 
*transparent pixels stripping* and automatic color reduction. Performs 
the following for PNG:

1. converts the PNG file using `gimp` to the XCF format,
2. converts XCF back to the PNG without transparent pixels using `xcf2png`,
3. optimizes it using `pngcrush` or `optipng`.

Or:

1. rewrites the PNG file using `convert`,
3. optimizes it using `pngcrush` or `optipng`.

And for JPEG:

1. strips all unnecessary metadata using `jpegoptim`,
2. optimizes using `jpegtran`.

## Usage

For *command line* usage see help for the `image-optimizer` command.
For usage as *library* see source of the `image-optimizer` command.

## Requirements

Following software for full functionality is necessary:

* [Ruby][1] (*required*),
* [Bash][11] (*required*),
* [GIMP][3],
* [ImageMagick][8],
* [Jpegtran][5],
* [Jpegoptim][6],
* [OptiPNG][7],
* [Pngcrush][2],
* [Xcftools][4].

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
[2]: http://pmt.sourceforge.net/pngcrush/
[3]: http://www.gimp.org/
[4]: http://henning.makholm.net/software#xcftools,
[5]: http://linux.die.net/man/1/jpegtran
[6]: http://freshmeat.net/projects/jpegoptim/
[7]: http://optipng.sourceforge.net/
[8]: http://www.imagemagick.org/
[9]: http://github.com/martinkozak/image-optimizer/issues
[10]: http://www.martinkozak.net/
[11]: http://www.gnu.org/software/bash/
