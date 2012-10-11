# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils"
require "fileutils"
require "tmpdir"
require "shellwords"

module ImageOptimizer
  
    ##
    # PNG optimizing module.
    # @since 0.2
    #
    
    module Png
        
        def self.optimize(path, &block)
            path_escaped = Shellwords::escape(path)
          
            # calls back
            block.call(path.dup, ImageOptimizer::BEFORE)
                      
            # New method (GIMP & XcfTools)
            if ImageOptimizer.available? :gimp and ImageOptimizer.available? :xcf2png and ImageOptimizer.available? :convert
                
                Dir.mktmpdir do |tmpdir|
                
                    dirname = tmpdir
                    basename = File.basename(path, '.png')
                    basepath = dirname + '/' + basename 
                    png_path = basepath + '.png'
                    xcf_path = basepath + '.xcf'
                    tif_path = basepath + '.tif'
                    
                    # ImageMagick
                    block.call(:mogrify, ImageOptimizer::METHOD)
                    `convert #{path_escaped} #{Shellwords::escape(tif_path)} 2> /dev/null`
                  
                    # GIMP
                    block.call(:gimp, ImageOptimizer::METHOD)
                    gimp = File.read(File.dirname(__FILE__) + '/png.script')
                    gimp.gsub!(':path', tif_path)
                    `#{gimp}`

                    # xcf2png
                    block.call(:xcf2png, ImageOptimizer::METHOD)
                    `xcf2png #{Shellwords::escape(xcf_path)} > #{Shellwords::escape(path_escaped)} 2> /dev/null`
                    
                end
                
            # Old method (ImageMagick)
            elsif ImageOptimizer.available? :mogrify
                block.call(:convert, ImageOptimizer::METHOD)
                `mogrify #{path_escaped} -quality 100 2> /dev/null`
            end

            # General optimizers
            if ImageOptimizer.available? :optipng
                block.call(:optipng, ImageOptimizer::METHOD)
                `optipng -o 7 #{path_escaped} 2> /dev/null`
            elsif ImageOptimizer.available? :pngcrush
                block.call(:pngcrush, ImageOptimizer::METHOD)
                `pngcrush -reduce -brute -ow #{path_escaped} 2> /dev/null`

            end            
          
            # calls back
            block.call(path.dup, ImageOptimizer::AFTER)
            
        end
        
    end
end
