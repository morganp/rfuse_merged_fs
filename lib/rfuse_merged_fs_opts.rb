require 'optparse'
require 'optparse/time'
require 'ostruct'

class RFuseMergedFSOpts


    #
    # Return a structure describing the options.
    #
    def self.parse(args)
      @VERSION = "0.0.1"
      
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      
      options.verbose    = false
      options.mountpoint = ""
      options.input      = Array.new
       

      opts = OptionParser.new do |opts|
         opts.banner    = "Usage: #{__FILE__} [options]"
         opts.separator ""
         opts.separator "Common options:"

         # No argument, shows at tail. This will print an options summary.
         opts.on("-h", "--help", "Show this message") do
            puts opts
            exit
         end

         # Another typical switch to print the version.
         opts.on("--version", "Show version") do
            #puts OptionParser::Version.join('.')
            puts "Version #{@VERSION}"
            exit
         end

         # Boolean switch.
         #opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
         #   options.verbose = v
         #end

         opts.separator ""
         opts.separator "Specific options:"


         # Cast 'delay' argument to a Float.
         opts.on("--mountpoint path", String, "Root of new Filesystem") do |n|
            options.mountpoint = n
         end
         
         opts.on("--input N", String, "Folder FS will point to") do |n|
            options.input << n
         end
         
        
      end
      
      options.leftovers = opts.parse!(args)

      if (options.mountpoint == "") and (options.input.size == 0 ) and (options.leftovers.size>1)
         # NB without the ! reverse returns a new array which is popped but
         #   leftovers would stay the same length.
         options.mountpoint = options.leftovers.reverse!.pop
         options.input      = options.leftovers
      end
      return options
    end # parse()

  end # class OptparseExample

