class Api::TvProgramController < Api::BaseController
  def capture
    expressions = [params[:expression0], params[:expression1], params[:expression2], params[:expression3], params[:expression4]].map(&:to_i)
    max = expressions.max
    cat = expressions.index(max)
    face = @user.face_captures.create!(expression_category: FaceCapture.expression_categories.invert[cat])
    target = FaceCapture.where.not(user_id: @user.id).where("created_at > ?", 30.second.ago).sample.try(:user)
    if target.present?
      Device.send_message({title: "奇跡が起こりました!", message: "今すぐ起こった奇跡を確認してみよう!!"}, [target.id, @user.id])
    end
    head(:ok)
  end
end
