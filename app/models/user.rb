class User < ActiveRecord::Base
  devise :database_authenticatable,
   :rememberable, :trackable, :validatables

  has_and_belongs_to_many :roles


  def add_role(role)
    self.roles << role
  end

  def add_role_by_name(role_name)
    role = Role.find_by(name: role_name)
    self.roles << role
  end

  def is_role?(role)
    self.roles.include?(role)
  end

  def is_role_by_name?(role_name)
    role = Role.find_by(name: role_name)
    self.is_role?(role)
  end
end
