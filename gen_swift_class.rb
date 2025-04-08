require 'active_support/inflector'

input_file_name = ARGV[0]

unless input_file_name
    print "Input input file name:\n"
    input_file_name = STDIN.gets.chomp
end

file = File.open(input_file_name)
file_data = file.readlines.map(&:chomp)
file.close

class_name, properties = classNameAndProperties(file_data)


new_file = File.open(class_name.first + '.swift', "w")

printImports(new_file)
printKeysEnum(class_name, properties, new_file)
printClass(class_name, properties, new_file)
new_file.close


BEGIN {

def classNameAndProperties(file_data)
  class_name = file_data.first.split(':').map {|i| i.chomp.strip }
  properties = file_data.drop(1).reduce({}) do |acc, i|
    k_v = i.split(':')
    acc[k_v.first.chomp.strip] = k_v.last.chomp.strip
    acc
  end
  return class_name, properties
end

def printImports(file)
    first_line = 'import Foundation'
    file.write first_line << "\n"
    first_line = 'import ObjectMapper'
    file.write first_line << "\n"
end

def printKeysEnum(class_name, properties, file)
    file.write "\n"
    
    first_line = "private enum #{class_name.first}Key: String {"
    file.write first_line << "\n"
    properties.each do |k_v|
      file.write "  case #{k_v.first}" << "\n"
    end

    file.write '}'
end

def printProperties(properties, file)
    properties.each do |k_v|
      file.write "  public var #{k_v.first}: #{k_v.last}" << "\n"
    end
end

def printRequiredInit(class_name, file)
  file.write "\n"

  line = '  required init?(map: Map) {'
  file.write line << "\n"
  line = '      super.init(map: map)'
  file.write line << "\n"
  file.write "\n"
  line = "      guard self.type == \"#{class_name.first.camelize(:lower)}\" else {"
  file.write line << "\n"
  line = '          return nil'
  file.write line << "\n"
  file.write '      }' << "\n"
  file.write '  }' << "\n"
end

def printPublicRequiredInit(file)
  file.write "\n"

  line = '  public required init() {'
  file.write line << "\n"
  line = '      fatalError("init() has not been implemented")'
  file.write line << "\n"
  file.write '  }' << "\n"
end

def printMapping(class_name, properties, file)
  file.write "\n"

  line = '  override public func mapping(map: Map) {'
  file.write line << "\n"
  line = '     super.mapping(map: map)'
  file.write line << "\n"
  file.write "\n"
  class_name_key = "#{class_name.first}Key"
  properties.each do |k_v|
    property = k_v.first
    file.write "     self.#{property} <- map[#{class_name_key}.#{property}.rawValue]" << "\n"
  end

  file.write '  }' << "\n"
end

def printClass(class_name, properties, file)
    file.write "\n"
    file.write "\n"
    first_line = "public class #{class_name.first}: #{class_name.last} {"
    file.write first_line << "\n"
    file.write "\n"
    printProperties(properties, file)
    printRequiredInit(class_name, file)
    printPublicRequiredInit(file)
    printMapping(class_name, properties, file)
    file.write '}'
end
}