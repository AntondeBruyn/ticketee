module Admin::BaseHelper
  def roles
    hash = {}
    ['manager', 'editor', 'viewer'].each do |role|
      hash[role.titleize] = role
    end
    hash
  end
end
  
