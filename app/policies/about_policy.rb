class AboutPolicy < ApplicationPolicy

  def admon?
    return (@user.admin? || @user.employee?)
  end
  
end