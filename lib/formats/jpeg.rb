# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

module ImageOptimizer

    ##
    # JPEG optimizing module.
    # @since 1.0
    #
    
    module Jpeg
        
        def self.optimize(path, &block)
            if ImageOptimizer.available? :jpegoptim
                `jpegoptim --strip-all #{path}`
            end
            
            if ImageOptimizer.available? :jpegtran
                `jpegtran -arithmetic -optimize -progressive -copy none #{path}`
            end
            
            # calls back
            block.call(path.dup)
        end
        
    end
end