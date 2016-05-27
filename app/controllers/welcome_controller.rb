class WelcomeController < ApplicationController
  def mainindex
  end

  def index
    # @teacher = Teacher.all
    # render layout: 'welcome'
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
      find_language_teacher
      @teachera = @teachers
      find_week_teacher
      @teacherb = @teachers
      @teachers = @teachera & @teacherb
    elsif params[:price]
      if cookies[:lan].blank? && cookies[:week].blank?
        find_price_teacher
      elsif cookies[:lan] && cookies[:week].blank?
        find_language_teacher
        @teachera = @teachers
        find_price_teacher
        @teacherb = @teachers
        @teachers = @teachera & @teacherb
      elsif cookies[:lan].blank? && cookies[:week]
        find_week_teacher
        @teachera = @teachers
        find_price_teacher
        @teacherb = @teachers
        @teachers = @teachera & @teacherb
      elsif cookies[:lan] && cookies[:week]
        find_language_teacher
        @teachera = @teachers
        find_week_teacher
        @teacherb = @teachers
        find_price_teacher
        @teacherc = @teachers
        @teachers = @teachera & @teacherb & @teacherc
      end
      respond_to do |format|
        format.js { render 'teacher' }
      end
    elsif params[:week].blank? && params[:language_id].blank?
      cookies[:lan] = nil
      cookies[:week] = nil
      @teachers = Teacher.all

    end

    @teachers = @teachers.page(params[:page]).per(10)

    if @teachers.last_page?
       @next_page = nil
    else
       @next_page = @teachers.next_page
    end

      end

  end

  def apply_teacher
  end

  def scholarship
    key = OpenSSL::Digest::SHA256.new('amazing_scholarship_tutor_lululala').digest
    crypt = ActiveSupport::MessageEncryptor.new(key)
    @encrypted_data = crypt.encrypt_and_sign(current_user.email) if current_user
    # decrypted_data = crypt.decrypt_and_verify(encrypted_data)
  end

  private

  def find_price_teacher
    @pricefir = params[:price].first.to_i
    @pricesec = params[:price].last.to_i
    @teachers = Teacher.where('ten_fee/10 >= ? AND one_fee <= ?', @pricefir, @pricesec)
    # @teachers = Teacher.where('(ten_fee/10 between ? and ?) AND (one_fee between ? and ?)', @pricefir, @pricesec)
  end

  def find_language_teacher
    @lan_id = cookies[:lan]
    @teachers = Teacher.includes(:teacher_languageships).where(teacher_languageships: { language_id: @lan_id }).uniq
  end

  def find_week_teacher
    @week = cookies[:week].to_i - 1
    @thedaytime = Time.now.utc.at_beginning_of_week + @week.day
    @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
    if @thedaytime == Time.now.utc.beginning_of_day
      @thedaytime = Time.now.utc
      @thedaytimeend = Time.now.utc.end_of_day
    elsif @thedaytime < Time.now.utc
      @thedaytime +=  7.day
      @thedaytimeend = @thedaytime + 60 * 60 * 24 - 1
    end
    @asfront = AvailableSection.select(:start,:start).where('start > ? AND start < ?', @thedaytime, @thedaytimeend)
    @asmid = AvailableSection.select(:start,:end).where('start < ? AND end > ?', @thedaytime, @thedaytimeend)
    @asend = AvailableSection.select(:end,:end).where('end > ? AND end < ?', @thedaytime, @thedaytimeend)
    @as = @asfront.ids + @asmid.ids + @asend.ids
    @as.uniq
    @teacher_id = AvailableSection.where(id: @as).pluck(:teacher_id).uniq
    @teachers = Teacher.where(id: @teacher_id).uniq
  end
end
