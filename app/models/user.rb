
require 'role_model'

class User < ActiveRecord::Base
  include RoleModel
  acts_as_liker

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
         
  ROLES = %w[admin crew normal guest banned]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
         
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :roles, :roles_mask, :avatar
  
  has_attached_file :avatar, :styles => { :thumb => "80x80#" }, :default_style => :thumb, :default_url => "/assets/default_avatar.png"
                    
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] }
  
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end
  
end
