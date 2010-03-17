$:.unshift(File.dirname(__FILE__) + "/../../rails_generators")
$:.unshift(File.dirname(__FILE__) + "/../lib")

require "test/unit"
require 'rubygems'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'rails_generator'
require 'table'
require "rexml/document"

class TestTable < Test::Unit::TestCase
  def setup
    doc = REXML::Document.new(File.open(File.dirname(__FILE__) + '/example.sqs'))
    @users_table = MyDomainGenerator::Table.new(doc.root.elements["SQLTable[name='Users']"])
    @posts_table = MyDomainGenerator::Table.new(doc.root.elements["SQLTable[name='Posts']"])
  end
  
  def test_can_initialize
    assert_not_nil @users_table
    assert_equal 'Users', @users_table.name
  end
  
  def test_can_get_description
    assert_equal 'Holds general user information.', @users_table.description
  end
  
  def test_can_get_class_name
    assert_equal 'User', @users_table.class_name
  end
  
  def test_can_get_file_name
    assert_equal 'user', @users_table.file_name
  end
  
  def test_can_get_migration_file_name
    assert_equal 'user', @users_table.migration_file_name
  end
  
  def test_can_get_fields
    assert_equal 3, @users_table.fields.size
  end
  
  def test_can_get_indexed_fields
    assert_equal 1, @posts_table.indexed_fields.size
  end
  
  def test_can_get_unique_fields
    assert_equal 1, @posts_table.unique_fields.size
    assert_equal 'title', @posts_table.unique_fields[0].column.name
  end
  
  def test_can_get_required_fields
    assert_equal 2, @posts_table.required_fields.size
    assert_equal ['title', 'user_id'], @posts_table.required_fields.map { |f| f.column.name }
  end
  
  def test_can_get_belongs_to_references
    assert_equal [:users], @posts_table.references[:belongs_to]
    assert_equal [], @users_table.references[:belongs_to]
  end
end