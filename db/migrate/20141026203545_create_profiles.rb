class CreateProfiles < ActiveRecord::Migration

  def change
    create_table :profiles do |t|
      t.text    :name
      t.text    :quote
      t.text    :biography
      t.text    :education
      t.text    :work
      t.text    :github
      t.text    :twitter
      t.text    :linkedin

    end
  end

end