class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    def index
      students = Student.all
      render json: students  
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student.to_json, status: :ok
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def create
        student = Student.create!(params.permit(:name, :age, :major));
        render json: student, status: :created
      
    end

    def update
       student = Student.find(params[:id])
         student.update!(params.permit(:name, :age, :major))
          render json:student, status: :updated
       
      end

    def destroy
        student = Student.find_by(id: params[:id])
         student.destroy
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
