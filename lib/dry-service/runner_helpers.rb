# module DryService
#   module RunnerHelpers
#     def config_file_exists?
#       File.exist?(CONFIG_FILE_NAME)
#     end

#     def base_service
#       @base_service ||= (merged_options[:base_service] || DEFAULT_BASE_DRY_SERVICE).downcase
#     end

#     def base_service_filename
#       @base_service_filename ||= (base_service.servicify << ".rb")
#     end

#     def base_service_exists?
#       File.exist?("app/services/#{base_service_filename}")
#     end

#     def nondefault_base_service?
#       merged_options[:base_service] != DEFAULT_DRY
#     end

#     def merged_options
#       return options unless config_file_exists?

#       YAML.load_file(CONFIG_FILE_NAME)
#           .merge(options)
#     end
#   end
# end
