class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    # GET /apartments
    def index
        render json: Apartment.all
    end

    # GET /apartments/:id
    def show
        display_apartment = find_apartment
        render json: display_apartment, status: 200
    end

    # POST /apartments
    def create
        new_apartment = Apartment.create!(apartment_params)
        render json: new_apartment, status: 201
    end

    # PATCH /apartments/:id
    def update
        update_apartment = find_apartment
        update_apartment.update!(apartment_params)
        render json: update_apartment
    end

    # DESTROY /apartments/:id
    def destroy
        destroy_apartment = find_apartment
        destroy_apartment.destroy
        head :no_content
    end


    private

    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: 404
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end


end
