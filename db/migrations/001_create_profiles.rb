class CreateProfiles < ActiveRecord::Migration

  def change
    create_table profiles do |t|
      t.string    :name
      t.string    :github
      t.string    :twitter
      t.text      :education
      t.text      :quote
      t.text      :blog
      
    end

  end

end