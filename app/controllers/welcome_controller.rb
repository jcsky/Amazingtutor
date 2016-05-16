class WelcomeController < ApplicationController
  def index
    if params[:language_id] && params[:week].nil?
      @lan_id = params[:language_id]
      @teachers = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: @lan_id })
    elsif params[:week] && params[:language_id].nil?
      @week = params[:week].to_i - 1
      @thedaytime = Time.now.utc.at_beginning_of_week + @week.day
      @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
      if @thedaytime == Time.now.utc.beginning_of_day
        @thedaytime = Time.now.utc
        @thedaytimeend = Time.now.utc.end_of_day
      elsif @thedaytime < Time.now.utc
        @thedaytime +=  7.day
        @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
      end
      @asfront = AvailableSection.where('start > ? AND start < ?', @thedaytime, @thedaytimeend)
      @asmid = AvailableSection.where('start < ? AND end > ?', @thedaytime, @thedaytimeend)
      @asend = AvailableSection.where('end > ? AND end < ?', @thedaytime, @thedaytimeend)
      @as = @asfront.ids + @asmid.ids + @asend.ids
      @as.uniq
      @teacher_id = AvailableSection.where(id: @as).pluck(:teacher_id).uniq
      @teachers = Teacher.where(id: @teacher_id)
    elsif params[:week] && params[:language_id]
      @week = params[:week].to_i - 1
      @thedaytime = Time.now.utc.at_beginning_of_week + @week.day
      @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
      if @thedaytime == Time.now.utc.beginning_of_day
        @thedaytime = Time.now.utc
        @thedaytimeend = Time.now.utc.end_of_day
      elsif @thedaytime < Time.now.utc
        @thedaytime +=  7.day
        @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
      end
      @asfront = AvailableSection.where('start > ? AND start < ?', @thedaytime, @thedaytimeend)
      @asmid = AvailableSection.where('start < ? AND end > ?', @thedaytime, @thedaytimeend)
      @asend = AvailableSection.where('end > ? AND end < ?', @thedaytime, @thedaytimeend)
      @as = @asfront.ids + @asmid.ids + @asend.ids
      @as.uniq
      @teacher_id = AvailableSection.where(id: @as).pluck(:teacher_id).uniq
      @teachera = Teacher.where(id: @teacher_id)
      @lan_id = params[:language_id]
      @teacherb = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: @lan_id })
      @teachers = @teachera & @teacherb
    else
      @teachers = Teacher.all
    end
  end

  def apply_teacher
  end

  def getprice
  end

  def scholarship
  end
end
