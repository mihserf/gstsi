class MemberEventDatesController < ApplicationController
  def destroy
    @date=MemberEventDate.find(params[:id])
    @date.destroy

    respond_to  do |format|
      format.js { render :xml => "destroied" }
    end
  end
end
