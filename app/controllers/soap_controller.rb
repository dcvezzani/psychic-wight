class SoapController < ActionController::Base
  include WashOut::SOAP

  before_filter :dump_parameters
  

    # Simple case
  soap_action "integer_to_string",
              :args   => :integer,
              :return => :string

  def integer_to_string
    render :soap => params[:value].to_s
  end

  def dump_parameters
    Rails.logger.debug params.inspect
  end
end
