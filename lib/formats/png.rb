# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils"

module ImageOptimizer
  
    ##
    # PNG optimizing module.
    # @since 1.0
    #
    
    module Png
        
        def self.optimize(path, &block)
          
            # New method (GIMP & XcfTools)
            if ImageOptimizer.available? :gimp and ImageOptimizer.available? :xcf2png 
                dirname = File.dirname(path)
                basename = File.basename(path, '.png')
                basepath = dirname + '/' + basename
                png_path = basepath + '.png'
                xcf_path = basepath + '.xcf'
              
                # GIMP
                gimp = File.read(File.dirname(__FILE__) + '/png.script')
                gimp.gsub!(':from', png_path)
                gimp.gsub!(':to', xcf_path)
                `#{gimp}`
                
                # xcf2png
                `xcf2png #{xcf_path} > #{png_path}`
                            
            # Old method (ImageMagick)
            elsif ImageOptimizer.available? :convert
                `convert #{path} -quality 100 #{path}`
            end

            # General optimizers
            if ImageOptimizer.available? :pngcrush
                `pngcrush -brute -reduce #{path} #{path}`
            elsif ImageOptimizer.available? :optipng
                `optipng -o 7 #{path}`
            end            
          
            # calls back
            block.call(path.dup)
        end
        
    end
end