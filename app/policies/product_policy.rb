class ProductPolicy < ApplicationPolicy
  def update?
    user && user.own?(record)
  end

  def destroy?
    update?
  end
end
