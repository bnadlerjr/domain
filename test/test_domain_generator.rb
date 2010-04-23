$:.unshift(File.dirname(__FILE__) + "/../../rails_generators")

require "test/unit"
require 'rubygems'
require "rails_generator"
require 'rails_generator/scripts/generate'
require 'active_record'

class TestDomainGenerator < Test::Unit::TestCase
  DELETE_TMP_APP = true # Set to false when debugging generated files to keep them around
  SAMPLES_ROOT = File.join(File.dirname(__FILE__), '/samples')
  
  def setup
    @app_root = File.join(File.dirname(__FILE__), '/../', 'tmp_rails_app')
    @models = %w[user post category comment]
    
    FileUtils.rm_rf(@app_root) if File.directory?(@app_root)
    FileUtils.mkdir(File.join(@app_root))
    
    args = [:domain, File.dirname(__FILE__) + "/example.sqs"]
    options = { :destination => @app_root, :quiet => true }
    Rails::Generator::Scripts::Generate.new.run(args, options)
  end
  
  def test_generates_model
    @models.each do |model|
      assert_files_equal File.join(SAMPLES_ROOT, "#{model}_model.rb"), File.join(@app_root, 'app/models', "#{model}.rb")
    end
  end
  
  def test_generates_unit_test
    @models.each do |model|
      assert_files_equal File.join(SAMPLES_ROOT, "#{model}_unit.rb"), File.join(@app_root, 'test/unit', "#{model}_test.rb")
    end
  end
  
  def test_generates_migration
    @models.each do |model|
      
    end
  end
  
  def teardown
    FileUtils.rm_rf(@app_root) unless !DELETE_TMP_APP
  end
  
  private
  
  def assert_files_equal(a, b)
    assert_equal File.open(a).read, File.open(b).read
  end
end