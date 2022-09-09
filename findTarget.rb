class Constants
    private
    ProjectPath = File.dirname(__FILE__)
    XcodeProjectFileType = ".xcodeproj"
end

class Targets
    class << self
    def names
        get_project_directory_names.flat_map { |name|
            directory = File.join( Constants::ProjectPath, name )
            childDirNames = Dir.entries(directory)
            .select {|f|
                f.include? Constants::XcodeProjectFileType
            }
            .map { |name|
                name.chomp(Constants::XcodeProjectFileType)
            }
        }
    end

    def get_target_path_by_index index
        directory = nil
        if index != 0
            name = names[index]
            directory = File.join( Constants::ProjectPath, name )
        elsif
            directory = Constants::ProjectPath
        end
        directory
    end
    
    def generamba_needs_to_set_up target_index
        target_path = get_target_path_by_index(target_index)
        !(Dir.entries(target_path).include?("Rambafile") and Dir.entries(target_path).include?("Templates"))
    end

    private
    def get_project_directory_names
        Dir.entries(Constants::ProjectPath).select {|f|
            File.directory? f and !f.include? Constants::XcodeProjectFileType
        }
    end
    end
end

