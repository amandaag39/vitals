class VitalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def show?
    record.user_id == user.id 
  end

  def update?
    record.user_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    record.user_id == user.id
  end

  def chart?
    user.id == record.user_id
  end
end


