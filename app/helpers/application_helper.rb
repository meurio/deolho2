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

  def taf_fields_class
    if @project.taf_message.present?
      "active"
    end
  end

  def meta_title
    content_for(:meta_title) || t("meta.title")
  end

  def meta_description
    content_for(:meta_description) || t("meta.description")
  end

  def meta_image
    content_for(:meta_image) || image_url("legislando.png")
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end

  def project_status project
    if project.processing_in_legislative?
      "Tramitando"
    elsif project.adopted?
      "Adotado"
    else
      "Cocriando"
    end
  end
end
