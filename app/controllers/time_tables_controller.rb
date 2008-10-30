class TimeTablesController < ApplicationController
  def index
    @members = Member.with_events
  end

end
