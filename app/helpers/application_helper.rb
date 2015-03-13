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
    content_for(:meta_image) || image_url("legislando.png")
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end

  def project_status project
    if project.accepted?
      "Agora é lei!"
    elsif project.rejected?
      "Rejeitado"
    elsif project.processing?
      "Em tramitação"
    elsif project.adopted?
      "Adotado"
    elsif !project.open?
      "Edição encerrada"
    else
      "Em edição"
    end
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end

  def contributions_list contributions
    if contributions.size < 4
      "<span>#{contributions.map{|c| link_to c.user.name, c.user}.to_sentence}</span> #{t(".contributed", count: contributions.size)}"
    else
      "<span>#{contributions[0..2].map{|c| link_to c.user.name, c.user}.join(', ')}</span> e mais #{contributions.size - 3} #{t(".contributed", count: contributions.size)}"
    end
  end

  def signatures_list signatures
    if signatures.size < 4
      "<span>#{signatures.map{|c| link_to c.user.name, c.user}.to_sentence}</span> #{t(".signed", count: signatures.size)}"
    else
      "<span>#{signatures[0..2].map{|c| link_to c.user.name, c.user}.join(', ')}</span> e mais #{signatures.size - 3} #{t(".signed", count: signatures.size)}"
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
