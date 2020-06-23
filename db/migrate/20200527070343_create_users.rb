class CreateUsers < ActiveRecord::Migration[6.0]

  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :password
      t.string :email
      t.string :token
      t.string :secret
      t.string :profile_image

      t.timestamps
    end
  end
end
