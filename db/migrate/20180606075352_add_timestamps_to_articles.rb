class AddTimestampsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :articles, default: DateTime.now
    change_column_default :articles, :created_at, nil
    change_column_default :articles, :updated_at, nil
  end
end
