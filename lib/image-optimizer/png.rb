# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils"
require "fileutils"
require "tmpdir"

module ImageOptimizer
  
    ##
    # PNG optimizing module.
    # @since 1.0
    #
    
    module Png
        
        def self.optimize(path, &block)
          
            # calls back
            block.call(path.dup, ImageOptimizer::BEFORE)
                      
            # New method (GIMP & XcfTools)
            if ImageOptimizer.available? :gimp and ImageOptimizer.available? :xcf2png 
                dirname = File.dirname(path)
                basename = File.basename(path, '.png')
                basepath = dirname + '/' + basename
                png_path = basepath + '.png'
                xcf_path = basepath + '.xcf'
                protect = File.exists? xcf_path
                
                if protect
                    protect = Dir.tmpdir + '/' + File.basename(xcf_path)
                    FileUtils.mv(xcf_path, protect)
                end
              
                # GIMP
                block.call(:gimp, ImageOptimizer::METHOD)
                gimp = File.read(File.dirname(__FILE__) + '/png.script')
                gimp.gsub!(':path', png_path)
                `#{gimp}`

                # xcf2png
                block.call(:xcf2png, ImageOptimizer::METHOD)
                `xcf2png #{xcf_path} > #{png_path} 2> /dev/null`
                FileUtils.rm(xcf_path)
                
                if protect
                    FileUtils.mv(protect, xcf_path)
                end
                         
            # Old method (ImageMagick)
            elsif ImageOptimizer.available? :convert
                block.call(:convert, ImageOptimizer::METHOD)
                `convert #{path} -quality 100 #{path} 2> /dev/null`
            end

            # General optimizers
            if ImageOptimizer.available? :pngcrush
                block.call(:pngcrush, ImageOptimizer::METHOD)
                `pngcrush -brute -reduce -ow #{path} 2> /dev/null`
            elsif ImageOptimizer.available? :optipng
                block.call(:optipng, ImageOptimizer::METHOD)
                `optipng -o 7 #{path} 2> /dev/null`
            end            
          
            # calls back
            block.call(path.dup, ImageOptimizer::AFTER)
            
        end
        
    end
end