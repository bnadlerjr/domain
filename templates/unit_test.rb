<%
unique = table.unique_fields.map { |f| ":#{f.column.name.underscore}" }.join(', ')
required = table.required_fields.map { |f| ":#{f.column.name.underscore}" }.join(', ')
-%>
require 'test_helper'

class <%= table.class_name %>Test < ActiveSupport::TestCase
  context 'a <%= table.class_name %> instance' do
    <%= "should_validate_presence_of #{required}" unless required.empty? %>
    <%= "should_validate_uniqueness_of #{unique}" unless unique.empty? %>
  end
end