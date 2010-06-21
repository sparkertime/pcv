class CreateMixes < ActiveRecord::Migration
  def self.up
    create_table :mixes do |t|
      t.string :name
      t.timestamps
    end

    create_table :feeds_mixes, :id => false do |t|
      t.integer :feed_id
      t.integer :mix_id
    end
  end

  def self.down
    drop_table :feeds_mixes

    drop_table :mixes
  end
end
