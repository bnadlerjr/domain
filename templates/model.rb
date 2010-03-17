<% 
belongs_to = table.references[:belongs_to].map { |r| ":#{r.to_s.singularize}" }.join(', ')
has_many = table.references[:has_many].map { |r| ":#{r}" }.join(', ') 
unique = table.unique_fields.map { |f| ":#{f.column.name.underscore}" }.join(', ')
required = table.required_fields.map { |f| ":#{f.column.name.underscore}" }.join(', ')
-%>
# == Description
# <%= table.description %>
class <%= table.class_name %> < ActiveRecord::Base
  <%= "belongs_to " + belongs_to unless belongs_to.empty? %>
  <%= "has_many " + has_many unless has_many.empty? %>
  <%= "validates_presence_of " + required unless required.empty? %>
  <%= "validates_uniqueness_of " + unique unless unique.empty? %>
end