$:.unshift(File.dirname(__FILE__) + "/../../rails_generators")
$:.unshift(File.dirname(__FILE__) + "/../lib")

require "test/unit"
require 'rubygems'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'rails_generator'
require 'domain'
require "rexml/document"

class TestDomain < Test::Unit::TestCase
  def setup
    @doc = REXML::Document.new(File.open(File.dirname(__FILE__) + '/example.sqs'))
  end
  
  def test_can_initialize_domain
    domain = MyDomainGenerator::Domain.new(@doc)
    %w[Users Posts Comments Categories CategoriesPosts].each do |table|
      assert_equal table, domain.tables[table.underscore.to_sym].name
    end
  end
  
  def test_can_initialize_domain_with_specific_tables
    domain = MyDomainGenerator::Domain.new(@doc, %w[Users Posts])
    assert_equal 2, domain.tables.size
    %w[Users Posts].each do |table|
      assert_equal table, domain.tables[table.underscore.to_sym].name
    end
  end
  
  def test_belongs_to_references_are_created
    domain = MyDomainGenerator::Domain.new(@doc, %w[Users Posts])
    assert_equal [:users], domain.tables[:posts].references[:belongs_to]
    assert_equal [], domain.tables[:users].references[:belongs_to]
  end
  
  def test_has_many_references_are_created
    domain = MyDomainGenerator::Domain.new(@doc, %w[Users Posts])
    assert_equal [:posts], domain.tables[:users].references[:has_many]
    assert_equal [], domain.tables[:posts].references[:has_many]
  end
end