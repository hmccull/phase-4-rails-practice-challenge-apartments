class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    # GET /tenants
    def index
        render json: Tenant.all
    end

    # GET /tenants/:id
    def show
        display_tenant = find_tenant
        render json: display_tenant, status: 200
    end

    # POST /tenants
    def create
        new_tenant = Tenant.create!(tenant_params)
        render json: new_tenant, status: 201
    end

    # PATCH /tenants/:id
    def update
        update_tenant = find_tenant
        update_tenant.update!(tenant_params)
        render json: update_tenant
    end

    # DESTROY /tenants/:id
    def destroy
        destroy_tenant = find_tenant
        destroy_tenant.destroy
        head :no_content
    end


    private

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: 404
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

end
