module ApplicationHelper
  def legislative_fields_class
    if @project.legislative_processing.present? ||
      @project.legislative_chamber.present?
      "active"
    end
  end

  def facebook_share_fields_class
    if @project.facebook_share_title.present? ||
      @project.facebook_share_description.present? ||
      @project.facebook_share_image.present?
      "active"
    end
  end

  def twitter_share_fields_class
    if @project.twitter_share_message.present?
      "active"
    end
  end

  def email_fields_class
    if @project.email_to_contributor.present? ||
      @project.email_to_signer.present?
      "active"
    end
  end
end
