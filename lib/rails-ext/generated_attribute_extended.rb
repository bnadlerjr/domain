module Rails
  module Generator
    # == Description
    # An extended version of +GeneratedAttribute+ that adds support for indicating if the attribute
    # is indexed or unique. It also defines a convenience method for creating a 'migration declaration'
    # (see +to_migration+).
    class GeneratedAttributeExtended < Rails::Generator::GeneratedAttribute
      attr_accessor :indexed, :unique
      
      def initialize(name, type, default=nil, nullable=true, indexed=false, unique=false)
        @column = ActiveRecord::ConnectionAdapters::Column.new(name, default, type, nullable)
        @indexed, @unique = indexed, unique
      end
      
      # Converts field into a migration declaration like:
      #
      # <tt>t.string :name, :null => false, :default => 'Untitled'</tt>
      #
      # +obj+ is the name of the owner ('t' in the above example).
      def to_migration(obj)
        result = "#{obj}.#{@column.type} :#{@column.name.underscore}"
        result += ", :null => #{@column.null}"
        
        if @column.default
          @column.default.is_a?(String) ? value = "'#{@column.default}'" : value = @column.default
          result += ", :default => #{value}"
        end

        result += ", :limit => #{@column.limit}" if @column.limit
        result
      end
    end
  end
end