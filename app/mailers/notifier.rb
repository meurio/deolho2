class Notifier < ApplicationMailer
  default from: "contato@nossascidades.org"

  def thanks_for_contributing contribution
    @user = contribution.user
    @project = contribution.project

    mail(
      to: @user.email,
      subject: "Que legal, agora você é um co-autor do nosso Projeto de Lei!"
    )
  end

  def thanks_for_signing signature
    @user = signature.user
    @project = signature.project

    mail(
      to: @user.email,
      subject: "Oba, você está apoiando nosso Projeto de Lei!"
    )
  end
end
