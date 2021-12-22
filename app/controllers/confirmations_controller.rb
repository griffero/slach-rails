class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_, resource)
    "https://www.slach.cl/#{resource.alias}?confirmed=true"
  end
end
