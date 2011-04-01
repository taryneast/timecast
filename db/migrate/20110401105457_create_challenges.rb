class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.integer :estimate
      t.datetime :started_at
      t.datetime :stopped_at
      t.integer :completedin
      t.integer :user_id
      t.datetime :aborted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
