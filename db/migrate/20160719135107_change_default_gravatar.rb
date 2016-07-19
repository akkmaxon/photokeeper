class ChangeDefaultGravatar < ActiveRecord::Migration
  def change
    change_column_default :users, :gravatar, true
  end
end
