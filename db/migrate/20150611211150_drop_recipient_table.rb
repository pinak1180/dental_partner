class DropRecipientTable < ActiveRecord::Migration
  def change
    drop_table :recipients
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
