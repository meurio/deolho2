class Notifier < ApplicationMailer
  default from: "contato@nossascidades.org"

  def thanks_for_contributing contribution
    set_variables contribution

    mail(
      to: @user.email,
      subject: "Que legal, agora você é um editor do nosso Projeto de Lei!",
      from: @project.user.email
    )
  end

  def thanks_for_signing signature
    set_variables signature

    mail(
      to: @user.email,
      subject: "Oba, você assinou o nosso Projeto de Lei!",
      from: @project.user.email
    )
  end

  private
  def set_variables resource
    @user = resource.user
    @project = resource.project
    @organization = @project.organization
  end
end
