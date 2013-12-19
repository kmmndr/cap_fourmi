module CapFourmi
  module Global
    ###
    # Checks an array of items to see if they are currently set within the
    # Capistrano scope.  If any of them fail, Capistrano execution will terminate.
    #
    # @param [Array, #each] required_variables An iterable list of items which
    #   represent the names of Capistrano environment variables.  Each item in this
    #   list is expected to be set.
    #
    # @raise [CapistranoGoBoom] Calls #abort on the Capistrano execution if any of
    #   the variables are not set.
    #
    # @example Using an array:
    #   verify_variables [:user, :deploy_base_dir, :app_server]
    #
    def verify_variables(*required_variables)
      required_variables.each do |expected_variable|
        abort( "You have not defined '#{expected_variable}' which is necessary for deployment." ) unless exists?(expected_variable)
      end
    end

    ###
    # Compresses a specific remote file before transferring it to the local
    # machine.  Once the transfer is completed, the file will be uncompressed
    # and the compressed version will be deleted.
    #
    # @param [String] remote The remote filename (optionally including path),
    # or directory that you would like to transfer.
    #
    # @param [String] local The location locally where you would like the file
    # or directory to be transferred.
    #
    # @param [String] options Any options that can be passed to Capistrano's
    # #download method.
    #
    # @example
    #   download_compressed! 'my/remote/file', 'my/local/file', :once => true
    #
    def download_compressed!(remote, local, options = {})
      remote_basename              = File.basename(remote)

      unless compressed_file? remote
        #remote_compressed_filename = "#{user_home}/#{remote_basename}.bz2"
        remote_compressed_filename = "#{remote}.bz2"
        local_compressed_filename  = "#{local}.bz2"

        #execute "bzip2 -zvck9 #{remote} > #{remote_compressed_filename}"
        execute compress_file(remote, :keep => true)
      end

      remote_compressed_filename  ||= remote
      local_compressed_filename   ||= local

      download! remote_compressed_filename, local_compressed_filename, options
    end


    def compress_file(file, options = {})
      keep_uncompressed = options[:keep] || false
      cmds = [ "bzip2 -zvck9 #{file} > #{file}.bz2" ]
      cmds << "rm -f #{file}" unless keep_uncompressed
      cmds.join(' && ')
    end

    ###
    # Checks to see if a filename has an extension which would imply that
    # it is compressed.
    #
    # @param [String] filename The filename whose extension will be checked.
    #
    # @return [Boolean] the result of whether the file has a compression
    # extension.
    #
    # @example
    #   compressed_file? 'file.bz2'
    #
    def compressed_file?(filename)
      filename =~ /.*\.bz2/
    end

    # capistrano 2 method
    def exists?(name)
      !fetch(name).nil?
    end
  end
end
