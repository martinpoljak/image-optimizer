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
                `xcf2png #{Shellwords::escape(xcf_path)} > #{Shellwords::escape(png_path)} 2> /dev/null`
                FileUtils.rm(xcf_path)
                
                if protect
                    FileUtils.mv(protect, xcf_path)
                end
                         
            # Old method (ImageMagick)
            elsif ImageOptimizer.available? :convert
                block.call(:convert, ImageOptimizer::METHOD)
                `convert #{path_escaped} -quality 100 #{path_escaped} 2> /dev/null`
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