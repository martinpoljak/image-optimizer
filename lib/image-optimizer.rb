# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "jpegtran"
require "optipng"
require "jpegoptim"

require "mini_magick"
require "unix/whereis"
require "options-hash" 

module ImageOptimizer
    
    ##
    # Optimizes given file or folder.
    #
    # If array given, go recursively deep to it. Yields paths to 
    # optimized files.
    #
    # @param [String, Array] item path or paths to files or directories
    # @param [Hash] options options for optimizing
    # @param [Proc] block block for giving back the results
    # @option options [Boolean] :strip indicates it should strip metadata from JPEG files
    # @option options [Integer] :level indicates level of PNG optimizations
    #
    
    def self.optimize(item, options = { }, &block)
        if item.kind_of? Array
            item.each do |i|
                self::optimize(i, options, &block)
            end
        else
            if File.file? item
                self::optimize_file(item, options, &block)
            elsif File.directory? item
                self::optimize_directory(item, options, &block)
            end
        end
    end
    
    ##
    # Optimizes given folder. 
    # Yields paths to optimized files.
    #
    # @param [String] item path to directory
    # @param [Hash] options options for optimizing
    # @param [Proc] block block for giving back the results
    # @option options [Boolean] :strip indicates it should strip metadata from JPEG files
    # @option options [Integer] :level indicates level of PNG optimizations
    #
    
    def self.optimize_directory(item, options = { }, &block)
        Dir.open(item) do |dir|
            dir.each do |i|
                if i[0].chr != ?.
                    self::optimize(item + "/" + i, options, &block)
                end
            end
        end
    end
    
    ##
    # Optimizes given file.
    # Yields paths to optimized files.
    #
    # @param [String] item path to file
    # @param [Hash] options options for optimizing
    # @param [Proc] block block for giving back the results
    # @option options [Boolean] :strip indicates it should strip metadata from JPEG files
    # @option options [Integer] :level indicates level of PNG optimizations
    #
    
    def self.optimize_file(path, options = { }, &block)
        ext = File.extname(path)
        
        # Loads options
        opts = OptionsHash::get(options) [
            :strip => true,
            :level => 7
        ]
        
        case ext
            when ".png"
                block.call(path.dup)
                
                if Whereis.available? :convert
                    begin
                        image = MiniMagick::Image.open(path)
                        image.write(path)
                    rescue MiniMagick::Error
                        # skips
                    end
                end
                
                if Optipng.available?
                    Optipng.optimize(path, { :level => opts[:level] })
                end
                
            when ".jpg"
                block.call(path.dup)
                
                if Jpegoptim.available?
                    Jpegoptim.optimize(path, opts[:strip].true? ? { :strip => :all } : { })
                end
                
                if Jpegtran.available?
                    Jpegtran.optimize(path, { :optimize => true, :progressive => true })
                end
        end
    end

end
