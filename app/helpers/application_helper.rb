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

  def accepted_field_class
    "active" if @project.accepted?
  end

  def rejected_field_class
    "active" if @project.rejected? && !@project.accepted?
  end

  def meta_title
    content_for(:meta_title) || t("meta.title")
  end

  def meta_description
    content_for(:meta_description) || t("meta.description")
  end

  def meta_image
    content_for(:meta_image) || image_url("facebook_share_image.jpg")
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end

  def users_list users, verb
    if users.size < 4
      "<span>#{users.map{|u| link_to u.name, u}.to_sentence}</span> #{t("." + verb, count: users.size)}"
    else
      "<span>#{users[0..2].map{|u| link_to u.name, u}.join(', ')}</span> e mais #{users.size - 3} #{t("." + verb, count: users.size)}"
    end
  end

  def avatars_list users, limit = 6
    if users.size <= limit
      users.map{ |u| "<div class='adopter'>#{image_tag(u.avatar_url, title: u.name, class: 'avatar-image')}</div>" }.join('')
    else
      "#{users[0..limit-1].map{ |u| "<div class='adopter'>#{image_tag(u.avatar_url, title: u.name, class: 'avatar-image')}</div>" }.join('')}<div class='plus'>+#{users.size - limit}</div>"
    end
  end

  def step_bubble_class project
    if @project.finished?
      "StepsList-stepBubble--finished"
    elsif @project.processing?
      "StepsList-stepBubble--processing"
    elsif @project.adopted?
      "StepsList-stepBubble--adopted"
    end
  end
end
