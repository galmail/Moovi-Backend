class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips, id: :uuid do |t|
      t.belongs_to  :user
      t.uuid        :video_id
      t.string      :url
      t.string      :message
      t.timestamps
    end
  end
end
