module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!  # Ensures only logged-in users can access

    def index
      # You can add any code here to display in the admin dashboard
    end
  end
end
