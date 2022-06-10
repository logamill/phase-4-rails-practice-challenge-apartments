class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def index
        apartments = Apartment.all 
        render json: apartments 
    end

    def show 
        apartment = find_apt
        render json: apartment 
    end

    def update 
        apartment = find_apt
        apartment.update(apt_params)
        render json: apartment
    end

    def create 
        apartment = Apartment.create(apt_params)
        render json: apartment, status: :created 
    end

    def destroy 
        apartment = find_apt
        apartment.destroy
        head :no_content
    end


    private

    def render_response_not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def render_record_invalid(exception)
        render json: { error: exception }, status: :unprocessable_entity
    end

    def find_apt
        Apartment.find(params[:id])
    end

    def apt_params
        params.permit(:number)
    end
end
