class Api::V1::StatusesController < ApiController
  def liveness
    render_status_200
  end

  def readiness
    begin
      Employee.all.size
      render_status_200
    rescue => e
      render_status_500(e)
    end
  end

  private

  def render_status_200
    render json: { api: 'success' }, status: 200
  end

  def render_status_500(exception)
    logger.warn "render 500 server error with exception: #{exception}" if exception.present?
    render json: { api: 'fail' }, status: 500
  end
end
