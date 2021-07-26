require "stripe"

class ChargesController < ApplicationController

    def create
        Stripe.api_key = 'sk_test_51JFLXwAGIFi71zekCNINDENt5KtDRI42Zm4FjNl4m3KS15HOdBM4ko4uXF7l35Ybbt53uGIQntMogUU7D0vGSi5100X3kPk7fK'

    #    byebug

#        session = Stripe::Checkout::Session.create({
#     payment_method_types: ['card'],
#     line_items: [{
#       price_data: {
#         unit_amount: 2000,
#         currency: 'usd',
#         product_data: {
#           name: 'Stubborn Attachments',
#           images: ['https://i.imgur.com/EHyR2nP.png'],
#         },
#       },
#       quantity: 1,
#     }],
#     mode: 'payment',
#     success_url: 'http://localhost:3001/Donate'+ '?success=true',
#     cancel_url: 'http://localhost:3001/Donate' + '?canceled=true',
#   })
#   redirect session.url, 303
# end
        begin
            # byebug
            customer = Stripe::Customer.create(
                :email => params[:charge][:token][:email],
                :source => params[:charge][:token][:id]
            )

            charge = Stripe::Charge.create({
                :customer => customer.id,
                :amount => (params[:charge][:token][:amount].to_i * 100),
                :description => 'reebes wholsale shop donation',
                :currency => 'usd',

            }, {
                :idempotency_key => SecureRandom.hex(20)
            })
            render json: {message: 'payment sucssecful'}

        rescue Stripe::CardError => e 
            render json: {message: 'payment error'}, status: :not_acceptable 
        end
    end

end
