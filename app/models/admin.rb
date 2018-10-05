class Admin < ActiveRecord::Base
  #Relaxionamentos
  has_many :proposal

  #Enums
  enum privilegio: {:full_access =>0,:restricted_access =>1,:partial_access =>2, :salesman_access =>3 }

  #Scope
  scope :with_full_access, ->{where(privilegio:0)}
  scope :with_partial_access, ->{where(privilegio:2)}
  scope :with_salesman_access, ->{where(privilegio:2)}
  scope :with_restricted_access, ->{where(privilegio:1)}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   def privilerio_ptBR
    case 
    when  self.privilegio == 'full_access'
      'Acesso Completo'
    when self.privilegio == 'restricted_access'
      'Acesso Restrito'
    when self.privilegio == 'partial_access'
      `Acesso Parcial`
    when self.privilegio == 'salesman_access'
      `Acesso de Vendedor`    
    end
  end

end
