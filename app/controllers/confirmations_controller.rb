class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_, resource)
    redirect_to "https://www.slach.cl/#{resource.alias}?confirmed=true"
  end
end
