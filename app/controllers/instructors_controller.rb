class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        instructors = Instructor.all
        render json: instructors  
      end
  
      def show
          instructor = Instructor.find_by(id: params[:id])
            render json: instructor.to_json, status: :ok

      end
  
      def create
          instructor = Instructor.create!(params.permit(:name));
          render json: instructor, status: :created
      end
  
      def update
         instructor = Instructor.find(params[:id])
           instructor.update!(params.permit(:name))
            render json:instructor, status: :updated

        end
  
      def destroy
          instructor = Instructor.find_by(id: params[:id])
              instructor.destroy
              render json: {}, status: :ok
      end

      private
      def render_not_found_response
          render json: {error: "Instructor not found"},status: :not_found
      end
  
      def render_unprocessable_entity_response(invalid)
          render json: { errors: invalid.record.errors }, status: :unprocessable_entity
        end
end
