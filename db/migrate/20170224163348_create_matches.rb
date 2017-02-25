class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :name

      t.timestamps
    end

    add_reference :teams, :match
  end
end
