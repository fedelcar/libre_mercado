class UserMailer < ApplicationMailer
  def new_offer_email(buyer)
    @user = buyer
    mail(to: @user.email, subject: 'Tenes una nueva oferta!')
  end

  def accepted_offer_email(seller)
    mail(to: seller.email, subject: 'Felicitaciones, has vendido un producto!')
  end

  def offer_rejected_email(offer, feedback)
    @user = offer.user
    @listing = offer.listing
    @feedback = feedback
    mail(to: @user.email, subject: 'Rechazaron tu oferta :(')
  end
end
