class Notifier < ApplicationMailer
  default from: "contato@nossascidades.org"

  def thanks_for_contributing contribution
    @user = contribution.user
    @project = contribution.project
    @organization = @project.organization

    mail(
      to: @user.email,
      subject: "Que legal, agora você é um co-autor do nosso Projeto de Lei!",
      from: @project.user.email
    )
  end

  def thanks_for_signing signature
    @user = signature.user
    @project = signature.project
    @organization = @project.organization

    mail(
      to: @user.email,
      subject: "Oba, você está apoiando nosso Projeto de Lei!",
      from: @project.user.email
    )
  end
end
