class RenamePollOptionsToAnswers < ActiveRecord::Migration
  def change
    rename_table :poll_options, :answers
    rename_column :poll_options_users, :poll_option_id, :answer_id
    rename_table :poll_options_users, :answers_users
  end
end
