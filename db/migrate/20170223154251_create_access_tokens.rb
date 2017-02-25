class CreateAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :access_tokens do |t|
      t.string :encrypted_token_value
      t.string :encrypted_token_value_iv

      t.timestamps
    end
  end
end
