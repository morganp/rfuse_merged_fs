require "rubygems"
require 'fusefs'
require 'rfuse_merged_fs_opts'


class RFuseMergedFS
  # http://rubydoc.info/gems/fusefs/0.7.0/FuseFS/MetaDir
  # contents( path )
  # file?( path )
  # directory?( path )
  # read_file( path )
  # size( path )
  # 
  # save
  # touch( path )
  # can_write?(path)
  # write_to(path,body)
  # 
  # can_delete?(path)
  # delete( path )
  #
  # can_mkdir?( path )
  # mkdir( path )
  # can_rmdir( path )
  # rmdir( path )
  # 

  def debug( msg )
    if false
      puts msg
    end
  end

  def initialize( options )
    debug "initialize( #{options.inspect} )"
    @base_dir = options.input
    debug "  @base_dir = #{@base_dir}"
  end

  def contents(path)
    debug "contents( #{path} )"
    n_path = File.expand_path( File.join( @base_dir, path ) )
    debug "  Expanded path: #{n_path}"


    Dir.chdir( n_path )  
    files = Dir.glob('*')

    debug files.inspect
    #Added command to OS X Finder not to index.
    #files << 'metadata_never_index'

    return files
  end

  def file?( path )
    debug "file?( #{path} )"
    #If path ends with metadata_never_index it is a file
    #if path =~ /metadata_never_index$/
    #  return true
    #end
    val = !( File.directory?( File.join( @base_dir, path ) ) ) 
    debug "  return #{val}"

    return val
  end

  def directory?( path )
    debug "directory?( #{path} )"
    val = File.directory?( File.join( @base_dir, path ) )
    debug "  return #{val}"
    return val
  end

  def read_file( path )
    debug "read_file( #{path} )" 
    if File.exists?( File.join( @base_dir, path ) )
      return File.new( File.join( @base_dir, path ) , "r").read
    end
    return "ERROR, file not found\n"

  end


  def size( path )
    debug "size( #{path} )" 
    #if File.exists?( @base_dir + path )
      return File.size( File.join( @base_dir, path ) )
    #else
    #  return 16
    #end
  end
end


if $0 == __FILE__

  options    = RFuseMergedFSOpts.parse(ARGV)
  filesystem = RFuseMergedFS.new( options )
  FuseFS.set_root( filesystem )

  # Mount under a directory given on the command line.
  FuseFS.mount_under options.mountpoint
  FuseFS.run
end

