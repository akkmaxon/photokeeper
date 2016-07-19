class ChangeDefaultFullName < ActiveRecord::Migration
  def change
    change_column_default :users, :full_name, 'Undefined User'
  end
end
