require_relative 'findTarget'
require_relative 'stringExtensions'

# Base constants
class Constants
    private
    TABLE_SEPARATOR = "+----------------------------------------------------------------------------------+"
    PARAMETER_SEPARATOR = "-------------------------------------------------------------------------------"
    SETUP_GENERAMBA = "./setup_generamba.sh"
    GENERATE_MODULE = "./generate_module.sh"
    GENERAMBA_SCRIPT_NAME = "generamba gen"
    TEMPLATE_NAME = "vpn_viper_swift"
end

# Parameters values
Parameter_hasViewManager = 1
Parameter_hasPresenterModuleOutput = 2
Parameter_modulePath = 3
Parameter_type = 4
Parameter_none = 5
Parameter_generate = 0
Parameter_frameworkFolder = 9
ScriptParameterIndexes = [
    Parameter_hasViewManager,
    Parameter_hasPresenterModuleOutput,
    Parameter_modulePath,
    Parameter_type,
    Parameter_none,
    Parameter_frameworkFolder
]

# Script starting !
puts ""
puts ""
puts "--- Welcome to Generamba! ---".green
puts "Enter module name:"
entered_name = gets
module_name = entered_name.strip

puts ""
puts "Started creating #{module_name} module".yellow

# Variables
parameters_array = Array.new
attributes = ""
entered_parameter = nil
target_name = nil

until entered_parameter == 0

    # Script stage #1
    # Choose parameter
    header_string = "Custom parameters:"
    generate_string = "0. generate"
    header_string = "|                                #{header_string}                                |"
    parameterString = nil
    puts ""
    puts Constants::TABLE_SEPARATOR
    puts header_string
    puts Constants::TABLE_SEPARATOR
    if !parameters_array.include?(Parameter_hasViewManager)
        parameterString = "1. hasViewManager = true/false(default)"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if !parameters_array.include?(Parameter_hasPresenterModuleOutput)
        parameterString = "2. hasPresenterModuleOutput = true(default)/false"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if !parameters_array.include?(Parameter_modulePath)
        parameterString = "3. modulePath = example: [BigModule] or nested variant: [BigModule.SubModule]"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if !parameters_array.include?(Parameter_type)
        parameterString = "4. type = MVP, VIPER(default)"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if parameters_array.count == 0
        parameterString = "5. none"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if !parameters_array.include?(Parameter_frameworkFolder)
        parameterString = "9. framework"
        puts String::build_parameter_option(header_string, parameterString)
    end
    if parameters_array.count > 0
        parameterString = generate_string
        puts Constants::TABLE_SEPARATOR
        puts String::build_parameter_option(header_string, parameterString)
    end
    puts Constants::TABLE_SEPARATOR
    puts "Which number would you like run?".yellow

    entered_parameter = gets.strip.chomp.to_i

    if ScriptParameterIndexes.include?(entered_parameter) and !parameters_array.include?(entered_parameter)
        # Script stage #2
        # Choose parameter value
        case entered_parameter
        when Parameter_hasViewManager
            hasViewManager = "hasViewManager:"
            attributes.concat(hasViewManager)

            puts ""
            puts Constants::PARAMETER_SEPARATOR
            puts hasViewManager
            puts Constants::PARAMETER_SEPARATOR
            puts "# 1. true"
            puts "# 2. false"

            enteredValue = gets
            parameterValue = enteredValue.strip.chomp.to_i
            
            if parameterValue == 1
                attributes.concat("true")
            elsif parameterValue == 2
                attributes.concat("false")
            end
        when Parameter_hasPresenterModuleOutput
            hasPresenterModuleOutput = "hasPresenterModuleOutput:"
            attributes.concat(hasPresenterModuleOutput)

            puts ""
            puts Constants::PARAMETER_SEPARATOR
            puts hasPresenterModuleOutput
            puts Constants::PARAMETER_SEPARATOR
            puts "# 1. true"
            puts "# 2. false"

            enteredValue = gets
            parameterValue = enteredValue.strip.chomp.to_i
            
            if parameterValue == 1
                attributes.concat("true")
            elsif parameterValue == 2
                attributes.concat("false")
            end
        when Parameter_modulePath
            modulePath = "modulePath:"
            attributes.concat(modulePath)

            puts ""
            puts Constants::PARAMETER_SEPARATOR
            puts modulePath
            puts Constants::PARAMETER_SEPARATOR
            puts "# Enter path:"

            enteredValue = gets
            parameterValue = enteredValue.strip
            attributes.concat(parameterValue)
        when Parameter_type
            type = "type:"
            attributes.concat(type)
            viper_module = "VIPER"
            mvp_module = "MVP"

            puts ""
            puts Constants::PARAMETER_SEPARATOR
            puts type
            puts Constants::PARAMETER_SEPARATOR
            puts "# Choose module type:"
            puts "# 1. #{viper_module}"
            puts "# 2. #{mvp_module}"

            enteredValue = gets
            parameterValue = enteredValue.strip.chomp.to_i
            
            if parameterValue == 1
                attributes.concat(viper_module)
            elsif parameterValue == 2
                attributes.concat(mvp_module)
            end
        when Parameter_none
            if parameters_array.count == 0
                attributes = ""
                entered_parameter = 0
            end
        when Parameter_frameworkFolder
            header = "|                                Choose Framework                                  |"
            puts Constants::TABLE_SEPARATOR
                puts header
                puts Constants::TABLE_SEPARATOR
            Targets::names.reduce(1) { |result, name|
                framework_name = "#{result}. #{name}"
                framework_name = String::build_parameter_option(header, framework_name)
                puts framework_name

                result + 1
            }
            puts Constants::TABLE_SEPARATOR
            puts "Which number would you like run?".yellow

            enteredValue = gets
            parameterValue = enteredValue.strip.chomp.to_i - 1
            if parameterValue > 0
                target_name = Targets::names[parameterValue]
            end
            generamba_needs_to_set_up = Targets::generamba_needs_to_set_up(parameterValue)
            if generamba_needs_to_set_up
                system("#{Constants::SETUP_GENERAMBA} #{target_name}")
            end
        end
        if entered_parameter != Parameter_generate
            parameters_array.push(entered_parameter)
        end
    end
    if parameters_array.count > 0
        attributes.concat(" ")
    end
end

# Run Generamba
generamba_command = nil
if !target_name.nil?
    generamba_command =  "#{Constants::GENERATE_MODULE} #{target_name} #{module_name} #{attributes}"
else
    if attributes.length > 0
        generamba_command = "#{Constants::GENERAMBA_SCRIPT_NAME} #{module_name} #{Constants::TEMPLATE_NAME} --custom-parameters=#{attributes}"
    else
        generamba_command = "#{Constants::GENERAMBA_SCRIPT_NAME} #{module_name} #{Constants::TEMPLATE_NAME}"
    end
end

system(generamba_command)
