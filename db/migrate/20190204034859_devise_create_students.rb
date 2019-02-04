class DeviseCreateStudents < ActiveRecord::Migration
  def change
    create_table(:students) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip


      t.string 'user_id'
      t.string 'password_digest'
      t.string 'first_name'
      t.string 'last_name'
      t.string 'email_id'
      t.string 'session_token'

      t.timestamps
    end

    add_index :students, :email,                unique: true
    add_index :students, :reset_password_token, unique: true
    add_index :students, :username, unique: true
  end
end
