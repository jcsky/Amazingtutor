class WelcomeController < ApplicationController
  before_action :find_language, only: :index

  def mainindex
  end

  def index
    if params[:language_id] && params[:week].blank?
      cookies[:lan] = params[:language_id]
      cookies[:week] = nil
      find_language_teacher
    elsif params[:week] && params[:language_id].blank?
      cookies[:lan] = nil
      cookies[:week] = params[:week]
      find_week_teacher

    elsif params[:week] && params[:language_id]
      cookies[:lan] = params[:language_id]
      cookies[:week] = params[:week]
      @teachers = find_language_teacher & find_week_teacher
    elsif params[:price]
      if cookies[:lan].blank? && cookies[:week].blank?
        find_price_teacher
      elsif cookies[:lan] && cookies[:week].blank?
        @teachers = find_language_teacher & find_price_teacher
      elsif cookies[:lan].blank? && cookies[:week]
        @teachers = find_week_teacher & find_price_teacher
      elsif cookies[:lan] && cookies[:week]
        @teachers = find_language_teacher & find_week_teacher & find_price_teacher
      end
      respond_to do |format|
        format.js { render 'teacher' }
      end

    elsif params[:week].blank? && params[:language_id].blank?
      cookies[:lan] = nil
      cookies[:week] = nil
      @teachers = Teacher.all
    end

    # @teachers = @teachers.page(params[:page]).per(10)
    #
    # if @teachers.last_page?
    #    @next_page = nil
    # else
    #    @next_page = @teachers.next_page
    # end
  end

  def apply_teacher
  end

  def scholarship
    @encrypted_data = amazing_crypt("encrypt",current_user.email) if current_user
  end

  private

  def find_language
    params[:language_id] ? @language = Language.find(params[:language_id]).language : @language = "Teacher also know the ...."
  end

  def find_price_teacher
    @teachers = Teacher.where('ten_fee >= ? AND one_fee <= ?', params[:price].first.to_i, params[:price].last.to_i)
  end

  def find_language_teacher
    @teachers = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: cookies[:lan] }).uniq
  end

  def find_week_teacher
    @week = cookies[:week].to_i - 1
    @thedaytime = Time.current.utc.at_beginning_of_week + @week.day
    @thedaytimeend = @thedaytime.end_of_day
    if @thedaytime == Time.current.utc.beginning_of_day
      @thedaytime = Time.current.utc+12.hours
      @thedaytimeend = Time.current.utc.end_of_day
      if @thedaytime >= @thedaytimeend
        @thedaytime = @thedaytimeend
      end
    elsif @thedaytime < Time.current.utc
      @thedaytime +=  7.day
      @thedaytimeend = @thedaytime.end_of_day
    end
    @as = (AvailableSection.where('start > ? AND start < ? AND end > ?', @thedaytime, @thedaytimeend,@thedaytimeend) +
           AvailableSection.where('start < ? AND end > ?', @thedaytime, @thedaytimeend) +
           AvailableSection.where('end > ? AND end < ? AND start < ?', @thedaytime, @thedaytimeend, @thedaytime) +
           AvailableSection.where('start > ? AND end < ?', @thedaytime, @thedaytimeend) ).uniq
    @teacher_id = AvailableSection.where(id: @as).pluck(:teacher_id).uniq
    @teachers = Teacher.where(id: @teacher_id)
  end

end
