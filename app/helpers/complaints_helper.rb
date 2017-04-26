# ComplaintsHelper
module ComplaintsHelper
  def complaint_status(status)
    case status
    when true
      'Resolved'
    else
      'Unresolved'
    end
  end

  def default_user(object)
    return if object.new_record?
    object.mobile_user.full_name + " (" + object.mobile_user.mobile_number + ')'
  end
end
