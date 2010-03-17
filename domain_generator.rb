require "rexml/document"
require "#{File.dirname(__FILE__)}/lib/domain"

# == Description
# Generates models, unit tests and migrations for a domain based on the given
# input file.
class DomainGenerator < Rails::Generator::Base
  default_options :skip_timestamps => false, :skip_migration => false, :skip_fixture => true
  
  def manifest
    record do |m|
      # Create directories.
      m.directory 'app/models'
      m.directory 'test/unit'

      # Load SQL specification
      doc = REXML::Document.new(File.open(args.shift))
      domain = MyDomainGenerator::Domain.new(doc, args)
      
      # Generate files for each table
      domain.tables.values.each do |table|

        # Check for class naming collisions.
        m.class_collisions table.class_name, "#{table.class_name}Test"

        # Apply templates
        m.template 'model.rb', File.join('app/models', "#{table.file_name}.rb"), :assigns => { :table => table }
        m.template 'unit_test.rb',  File.join('test/unit', "#{table.file_name}_test.rb"), :assigns => { :table => table }

        # Migration
        migration_file_path = table.migration_file_name
        migration_name = table.class_name
        if ActiveRecord::Base.pluralize_table_names
          migration_name = migration_name.pluralize
          migration_file_path = migration_file_path.pluralize
        end

        unless options[:skip_migration]
          locals = { :table => table, :migration_name => "Create#{migration_name.gsub(/::/, '')}" }
          m.migration_template 'migration.rb', 'db/migrate', :assigns => locals, :migration_file_name => "create_#{migration_file_path}"
        end
      end
    end
  end

  protected
    def banner
      "Usage: #{$0} #{spec.name} inputfile [tables]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-timestamps",
             "Don't add timestamps to the migration file(s)") { |v| options[:skip_timestamps] = v }
      opt.on("--skip-migration", 
             "Don't generate a migration file(s)") { |v| options[:skip_migration] = v }
    end
end