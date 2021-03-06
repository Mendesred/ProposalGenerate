class AdminPolicy < ApplicationPolicy
  def new?
  	user.full_access?
  end
   def destroy?
  	user.full_access?
  end
  def edit?
    user.full_access?
  end
def permitted_attributes
  if user.full_access?
    [:nome ,:privilegio ,:email, :password, :password_confirmation]
  else
    [:nome ,:password, :password_confirmation]
  end
end
  class Scope < Scope
    def resolvea
      if user.full_access?
      	scope.all
      else
      	scope.with_restricted_access
    	end
   	end
  end
end
