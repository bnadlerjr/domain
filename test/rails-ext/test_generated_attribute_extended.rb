$:.unshift(File.dirname(__FILE__) + "/../../rails_generators")
$:.unshift(File.dirname(__FILE__) + "/../../lib")

require "test/unit"
require 'rubygems'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'rails_generator'
require 'rails-ext/generated_attribute_extended'

class TestGeneratedAttributeExtended < Test::Unit::TestCase
  def test_can_initialize_with_defaults
    attribute = Rails::Generator::GeneratedAttributeExtended.new('MyField', "string(255)")
    assert_equal 'MyField', attribute.column.name
    assert !attribute.indexed
    assert !attribute.unique
  end
  
  def test_can_convert_attributes_to_readable_string
    attribute = Rails::Generator::GeneratedAttributeExtended.new('MyField', 'string(255)', 'Default Value')
    expected = "Name:    MyField\n\tType:    string\n\tDefault: Default Value\n\tIndexed: false\n\tUnique:  false\n"
    assert_equal expected, attribute.to_s
  end
  
  def test_can_create_string_migration_declaration_with_null
    attribute = Rails::Generator::GeneratedAttributeExtended.new('MyField', 'string(255)', 'Default Value')
    expected = "t.string :my_field, :null => true, :default => 'Default Value', :limit => 255"
    assert_equal expected, attribute.to_migration('t')
  end
  
  def test_can_create_string_migration_declaration_without_null
    attribute = Rails::Generator::GeneratedAttributeExtended.new('MyField', 'string(255)', 'Default Value', false)
    expected = "t.string :my_field, :null => false, :default => 'Default Value', :limit => 255"
    assert_equal expected, attribute.to_migration('t')    
  end
end