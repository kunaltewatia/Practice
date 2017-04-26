# metheds of mobile user controller
module MobileUserModule
  private

  def update_duplicate_user
    return unless @current_user && @current_user.subscriptions.blank? &&
                  !@current_user.is_verified
    if permitted_params[:subscriptions_attributes][0][:payment_type].zero?
      @current_user.update_attributes(permitted_params)
      @current_user.send_otp
    else
      @current_user.update_attributes(payu_permitted_params)
    end
    create_authentication(@current_user)
    render json: @current_user,
           uuid: current_uuid,
           params: permitted_params[:subscriptions_attributes][0],
           serializer: MobileUserRegisterSerializer
  end

  def add_lead
    return if lead?
    params[:mobile_user][:lead_address_attributes] =
      params[:mobile_user][:address_attributes]
    lead = Lead.new(permitted_lead_params)
    lead.save!
    render json: { message: 'lead added successfully', lead: lead }
  end

  def lead?
    permitted_params[:address_attributes][:area_id] &&
      permitted_params[:address_attributes][:locality_id] &&
      permitted_params[:address_attributes][:society_id]
  end

  def duplicate_user!
    @current_user = MobileUser.find_by(mobile_number:
                                       permitted_params[:mobile_number])

    render json: { message: 'User is already present' },
           status: :precondition_failed if @current_user &&
                                           @current_user.unsubscribed?
  end

  def duplicate_referral!
    contact = permitted_referral_params[:contact]
    logger.info "contact : #{contact} ======="
    customer = Customer.find_by_mobile_number(contact) if contact.present?
    msg = 'Oh no!
      The number you referred has either been referred by someone,
      or is already registered with us.
      Please refer a new user and get a bonus now!'
    render json: { message: msg },
           status: :precondition_failed if customer.present?
  end

  def permitted_params
    params.require(:mobile_user)
      .permit(:id, :first_name, :last_name, :mobile_number, :type,
              address_attributes: [:id, :flat_no, :mobile_user_id,
                                   :country_id, :state_id, :city_id,
                                   :area_id, :locality_id,
                                   :society_id, :wing_id],
              subscriptions_attributes: [:id, :plan_id, :mobile_user_id,
                                         :start_at, :ends_at, :payment_type,
                                         :payment_status])
  end

  def payu_permitted_params
    params.require(:mobile_user)
      .permit(:id, :first_name, :last_name, :mobile_number, :type,
              address_attributes: [:id, :flat_no, :mobile_user_id,
                                   :country_id, :state_id, :city_id,
                                   :area_id, :locality_id,
                                   :society_id, :wing_id])
  end

  def permitted_lead_params
    params.require(:mobile_user)
      .permit(:id, :first_name, :last_name, :mobile_number, :uuid,
              lead_address_attributes: [
                :id, :flat_no, :country_id, :state_id, :city_id, :area,
                :locality, :society, :wing])
  end

  def permitted_referral_params
    params.require(:referral).permit(:id, :mobile_user_id, :contact,
                                     :is_converted)
  end

  def create_authentication(mobile_user)
    auth = mobile_user.authentications.find_by_uuid(current_uuid)
    return auth if auth
    auth = mobile_user.authentications.new(uuid: current_uuid)
    auth.auth_token = SecureRandom.hex
    auth.save
    auth
  end
end
