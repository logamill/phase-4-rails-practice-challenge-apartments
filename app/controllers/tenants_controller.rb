class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def index
        tenants = Tenant.all 
        render json: tenants 
    end

    def show 
        tenant = find_tenant
        render json: tenant 
    end

    def update 
        tenant = find_tenant
        tenant.update(tenant_params)
        render json: tenant
    end

    def create 
        tenant = Tenant.create(tenant_params)
        render json: tenant, status: :created 
    end

    def destroy 
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end


    private

    def render_response_not_found
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_record_invalid(exception)
        render json: { error: exception }, status: :unprocessable_entity
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    
end
