class AddMailchimpSegmentUidToProject < ActiveRecord::Migration
  def change
    add_column :projects, :mailchimp_segment_uid, :string
  end
end
