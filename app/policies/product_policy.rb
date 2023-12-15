# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def search
    index?
  end

  def my?
    user
  end

  def create?
    user
  end

  def update?
    user&.own?(record)
  end

  def destroy?
    update?
  end
end
