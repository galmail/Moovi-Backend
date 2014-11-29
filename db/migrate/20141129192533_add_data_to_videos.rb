class AddDataToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.uuid      :event_id
      t.date      :event_celebration_date
      t.datetime  :clips_submission_deadline
    end
  end
end
