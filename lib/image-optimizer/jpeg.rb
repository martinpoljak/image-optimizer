# encoding: utf-8
# (c) 2012 Martin Kozák (martinkozak@martinkozak.net)

require "shellwords"

module ImageOptimizer

    ##
    # JPEG optimizing module.
    # @since 0.2
    #
    
    module Jpeg
        
        def self.optimize(path, &block)
            path_escaped = Shellwords::escape(path)
            
            # calls back
            block.call(path.dup, ImageOptimizer::BEFORE)
            
            if ImageOptimizer.available? :jpegoptim
                block.call(:jpegoptim, ImageOptimizer::METHOD)
                `jpegoptim --strip-all #{path_escaped} 2> /dev/null`
            end
            
            if ImageOptimizer.available? :jpegtran
                block.call(:jpegtran, ImageOptimizer::METHOD)
                `jpegtran -arithmetic -optimize -progressive -copy none #{path_escaped} 2> /dev/null`
            end
            
            # calls back
            block.call(path.dup, ImageOptimizer::AFTER)
            
        end
        
    end
end