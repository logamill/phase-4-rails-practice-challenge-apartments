class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created 
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        render json: {}
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_record_invalid(exception)
        render json: { error: exception }, status: :unprocessable_entity
    end
end
