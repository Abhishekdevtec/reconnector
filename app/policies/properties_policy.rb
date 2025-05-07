# frozen_string_literal: true

class PropertiesPolicy
  attr_reader :user, :property

  def initialize(property, user)
    @user = user
    @property = property
  end

  def self.edit?(property, user)
    new(property, user).edit?
  end

  def self.update?(property, user)
    new(property, user).update?
  end

  def self.destroy?(property, user)
    new(property, user).destroy?
  end

  def edit?
    user_is_owner_or_account_manager? || user_is_overlord?
  end

  def update?
    user_is_owner_or_account_manager? || user_is_overlord?
  end

  def destroy?
    user_is_owner_or_account_manager? || user_is_overlord?
  end

  private

  def user_is_owner_or_account_manager?
    user_is_owner? || user_is_account_manager?
  end

  def user_is_owner?
    @user.id == @property.agent_id
  end

  def user_is_account_manager?
    user_role == :account_manager && @user.account_id == @property.account_id
  end

  def user_is_overlord?
    @user.overlord?
  end

  def user_role
    @user.role.to_sym
  end
end
