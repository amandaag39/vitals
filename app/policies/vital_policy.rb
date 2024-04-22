class VitalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def show?
    vital_owner
  end

  def update?
    vital_owner
  end

  def edit?
    vital_owner
  end

  def destroy?
    vital_owner
  end

  def chart?
    vital_owner
  end

  private
  
  def vital_owner
    record.user_id == user.id
  end
end
