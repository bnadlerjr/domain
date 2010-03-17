class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table.name.underscore %> do |t|
<% for field in table.fields -%>
      <%= field.to_migration('t') %>
<% end -%>
<% unless options[:skip_timestamps] %>
      t.timestamps
<% end -%>
    end

<% for field in table.indexed_fields -%>
    add_index :<%= table.name.underscore %>, :<%= field.column.name %>
<% end -%>
  end

  def self.down
<% for field in table.indexed_fields.reverse -%>
    remove_index :<%= table.name.underscore %>, :<%= field.column.name %>
<% end -%>
    drop_table :<%= table.name.underscore %>
  end
end