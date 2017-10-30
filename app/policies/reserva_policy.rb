class ReservaPolicy < ApplicationPolicy

  def index?
    return (@user.admin? || @user.employee?) 
  end
  
  def show?
    return (@user.admin? || @user.employee?)
  end
  
  def update?
    return (@user.admin? || @user.employee?)
  end
  
  def edit?
    update?
  end
  
  def new?
    return (@user.admin? || @user.employee?)
  end
  
  def create?
    new?
  end
  
  def destroy?
    return (@user.admin?)
  end
  
end