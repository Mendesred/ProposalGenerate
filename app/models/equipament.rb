class Equipament < ActiveRecord::Base
	belongs_to :type_equipament
	belongs_to :sub_type
	has_many :proposal_equipaments
  #has_many :proposals, :through => :proposal_equipaments

  def name_select
    "#{name_equipament} - Ddp:#{depreciacao} - Val:R$ #{valor} - Nº#{id}"
  end
  before_save :atualiza_data_do_preco


private
	def atualiza_data_do_preco
		if valor_changed?
			if(valor_change[0] != valor_change[1])
				self.updated_date_valor = DateTime.now
			end
		end
		##valor_change[0] #Antigo
		##valor_change[1] #Novo
		###update_column(:updated_date_valor,(updatedDateValor))
	end

end
