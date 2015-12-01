class AssetPolicy < ApplicationPolicy

  def show?
    user.try(:admin?) || record.ticket.project.has_member?(user)
  end
end
