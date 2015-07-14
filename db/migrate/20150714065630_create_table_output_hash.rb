class CreateTableOutputHash < ActiveRecord::Migration
  def change
    create_table :output_hashes do |t|
      t.text 'answer', limit: 16_777_215
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
