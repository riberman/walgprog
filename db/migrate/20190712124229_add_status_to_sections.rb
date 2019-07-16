class AddStatusToSections < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE section_statuses AS ENUM ('active', 'inactive', 'alternative_content');
      ALTER TABLE sections ADD status section_statuses;
    SQL
  end

  def down
    remove_column :sections, :status
    execute <<-SQL
      DROP TYPE section_statuses;
    SQL
  end
end
