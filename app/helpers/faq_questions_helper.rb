# Helper for Faq Question
module FaqQuestionsHelper
  def new_faq_path
    return new_faq_question_path unless params[:faq_category_id]
    new_faq_category_faq_question_path(params[:faq_category_id])
  end

  def edit_faq_path(faq_question)
    return edit_faq_question_path(faq_question) unless params[:faq_category_id]
    edit_faq_category_faq_question_path(params[:faq_category_id], faq_question)
  end

  def show_faq_path(faq_question)
    faq_category_id = params[:faq_category_id] || faq_question.faq_category_id
    return faq_question_path(faq_question) unless faq_category_id
    faq_category_faq_question_path(faq_category_id, faq_question)
  end

  def delete_faq_path(faq_question)
    return faq_question_path(faq_question) unless params[:faq_category_id]
    faq_category_faq_question_path(params[:faq_category_id], faq_question)
  end
end
