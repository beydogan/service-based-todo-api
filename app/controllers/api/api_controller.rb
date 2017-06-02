class Api::ApiController < ActionController::API

  def call
    service = "#{params[:namespace].capitalize}::#{params[:command].capitalize}".constantize

    result = service.run(service_params(service.allowed_params).to_h)

    if result.success?
      render json: {success: true, result: result.result}
    else
      render json: {success: false, errors: result.errors.symbolic}
    end
  end

  def service_params(allowed_params)
    params.permit(allowed_params)
  end
end
