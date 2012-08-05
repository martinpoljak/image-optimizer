# encoding: utf-8
# (c) 2011-2012 Martin Kozák (martinkozak@martinkozak.net)

require "which"
require "image-optimizer/formats/jpeg"
require "image-optimizer/formats/png"

module ImageOptimizer
  
    ##
    # Optimizers availiability cache.
    # 
    
    @optimizers
    
    ##
    # Optimizes given file or folder.
    #
    # If array given, go recursively deep to it. Yields paths to 
    # optimized files.
    #
    # @param [String, Array] item path or paths to files or directories
    # @param [Proc] block block for giving back the results
    #
    
    def self.optimize(item, &block)
        if item.kind_of? Array
            item.each do |i|
                self::optimize(i, &block)
            end
        else
            if File.file? item
                self::optimize_file(item, &block)
            elsif File.directory? item
                self::optimize_directory(item, &block)
            end
        end
    end
    
    ##
    # Optimizes given folder. 
    # Yields paths to optimized files.
    #
    # @param [String] item path to directory
    # @param [Proc] block block for giving back the results
    #
    
    def self.optimize_directory(item, &block)
        Dir.open(item) do |dir|
            dir.each do |i|
                if i[0].chr != ?.
                    self::optimize(item + "/" + i, &block)
                end
            end
        end
    end
    
    ##
    # Optimizes given file.
    # Yields paths to optimized files.
    #
    # @param [String] item path to file
    # @param [Proc] block block for giving back the results
    #
    
    def self.optimize_file(path, &block)
        ext = File.extname(path)
        
        case ext
            when ".png"
                ImageOptimizer::Png::optimize(path, &block)
                  
            when ".jpg"
                ImageOptimizer::Jpeg::optimize(path, &block)
                
        end
    end
    
    ##
    # Indicates, optimizer is available.
    #
    # @param [Symbol, String] command  command name
    # @return [Boolean]
    #
    
    def self.available?(command)
        @optimizers = { } if @optimizers.nil?
        
        if command.in? @optimizers
            return @optimizers[command]
        else
            available = (not Which.which(command.to_s).empty?)
            return @optimizers[command] = available 
        end
    end

end
