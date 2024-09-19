class Student::AccountsController < Student::Base
    def show
        @student = current_student
    end

    def edit
        @student = current_student
    end

    def update
        @student = current_student
        @student.assign_attributes(student_params)
        if @student.save
            flash.notice = "アカウント情報を更新しました。"
            redirect_to :student_account
        else
            render action: "edit"
        end
    end

    private def student_params
        params.require(:student).permit(
            :name, :name_kana, :email, :birthday, :has_deposited_phone
        )
    end
end
