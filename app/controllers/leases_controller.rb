class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    # GET /leases
    def index
        render json: Lease.all
    end

    # CREATE /leases
    def create
        new_lease = Lease.create!(lease_params)
        render json: new_lease, status: 201
    end

    # DESTROY /leases/:id
    def destroy
        destroy_lease = Lease.find(params[:id])
        destroy_lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: 404
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

end
