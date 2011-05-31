class PaymentController < ApplicationController

  def index
    @job_id = params[:id]

    if request.post?

      if params[:promo_code] && params[:promo_code].upcase == "FREE30"
          job = Job.find(params[:job_id])
          job.status = 1;
          if job.save
            redirect_to(jobs_url, :notice => "Congratulations !!! The promo code was accepted. No amount was charged to your credit card. Job AD #{params[:job_id]} now activated.") 
          else
            flash[:error] = "Database error: Unable to activate job posting."
            redirect_to :controller => "payment", :action => "index", :id => params[:job_id]
          end
      else

        # Use the TrustCommerce test servers
        ActiveMerchant::Billing::Base.mode = :production

        # ActiveMerchant accepts all amounts as Integer values in cents
        # $49.00
        amount = 4900
        amount_str = sprintf("%.2f", amount / 100)

        # The card verification value is also known as CVV2, CVC2, or CID
        credit_card = ActiveMerchant::Billing::CreditCard.new(
          :first_name         => 'params[:first_name]',
          :last_name          => 'params[:last_name]',
          :number             => 'params[:card_number]',
          :month              => 'params[:expiry_month]',
          :year               => 'params[:expiry_year]',
          :verification_value => 'params[:verification]'
        )

        purchase_options = {
          :ip => request.remote_ip,
          :billing_address => {
            :name     => "#{params[:first_name]} #{params[:last_name]}",
            :address1 => "params[:address1]",
            :city     => "params[:city]",
            :state    => "params[:state]",
            :country  => "params[:country]",
            :zip      => "params[:zip]"
          }
        }

        job = Job.find(params[:job_id])

        # Validating the card automatically detects the card type
        if credit_card.valid?

          # Create a gateway object for the TrustCommerce service
          gateway = ActiveMerchant::Billing::PaypalGateway.new(
            :login => "support_api1.jobbslist.com",
            :password => "86D6WXTYDPWNKSKP",
            :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AuAZkiUj2EUCVnygzf-.-7Wr1W.m"
          )

          # Authorize for the amount
          response = gateway.purchase(amount, credit_card, purchase_options)

          if response.success?
            job = Job.find(params[:job_id])
            job.status = 1;
            if job.save
              JobPostMailer.deliver_confirm_payment(job, amount_str, credit_card.display_number, "#{params[:first_name]} #{params[:last_name]}")
              redirect_to(jobs_url, :notice => "Successfully charged $#{amount_str} to the credit card #{credit_card.display_number}. Job AD #{params[:job_id]} now activated.") 
            else
              flash[:error] = "Database error: Unable to activate job posting."
              redirect_to :controller => "payment", :action => "index", :id => params[:job_id]
            end
          else
            flash[:error] = response.message
            redirect_to :controller => "payment", :action => "index", :id => params[:job_id]
          end

        else
          flash[:error] = "credit card is not valid"
          redirect_to :controller => "payment", :action => "index", :id => params[:job_id]

        end

      end

    end

  end

  protected

  def authorize
  end

end
