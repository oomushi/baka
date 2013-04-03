class AddDefaultValueToConfirmCodeAttribute < ActiveRecord::Migration
  def up
    change_column_default :users, :confirm_code, ''
  end
  def down
    change_column_default :users, :confirm_code, nil
  end
end
