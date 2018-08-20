class Admin < ActiveRecord::Base
  #Relaxionamentos
  has_many :proposal

  #Enums
  enum privilegio: {:full_access =>0,:restricted_access =>1 }

  #Scope
  scope :with_full_access, ->{where(privilegio:0)}
  scope :with_restricted_access, ->{where(privilegio:1)}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   def privilerio_ptBR
   	if self.privilegio == 'full_access'
   		'Acesso Completo'
   	else
   		'Acesso Restrito'
   	end
   	
   end


end
