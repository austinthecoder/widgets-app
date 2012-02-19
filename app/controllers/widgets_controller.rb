class WidgetsController < ApplicationController

  helper_method :widget, :active_widgets, :inactive_widgets

  def create
    if widget.save
      flash.notice = "Widget was added."
      redirect_to widgets_url
    else
      flash.notice = widget.errors.join "\n"
      render :new
    end
  end

  def update
    if widget.save(params[:widget])
      flash.notice = "Widget was changed."
      redirect_to widgets_url
    else
      flash.notice = widget.errors.join "\n"
      render :edit
    end
  end

  def destroy
    widget.destroy!
    redirect_to widgets_url
  end

  ##################################################

  def widget
    @widget ||= if params[:id]
      Widget.find params[:id]
    else
      Widget.build params[:widget]
    end
  end

  def inactive_widgets
    @inactive_widgets ||= Widget.where :active => false
  end

  def active_widgets
    @active_widgets ||= Widget.active
  end

end