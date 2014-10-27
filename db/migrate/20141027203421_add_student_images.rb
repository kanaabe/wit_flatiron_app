class AddStudentImages < ActiveRecord::Migration
  def change
    add_column :profiles, :img_url, :text
  end
end
