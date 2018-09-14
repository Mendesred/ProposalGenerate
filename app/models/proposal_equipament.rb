class ProposalEquipament < ActiveRecord::Base
  belongs_to :equipament
  belongs_to :proposal
  belongs_to :type_equipament
  belongs_to :sub_type

  accepts_nested_attributes_for :equipament, reject_if: :all_blank, allow_destroy:true

	after_save :preeche_capos_vazios

	validates :type_equipament_id, numericality: { only_integer: true,  message: "should happen once per year"}

private
	def preeche_capos_vazios
		if self.quantidade.nil?
			self.quantidade = 0
		end
		unless (depreciacao_aux.nil? )
			depreciacaoValida = depreciacao_aux
			puts"estou aqui"
		else
			depreciacaoValida = equipament.depreciacao.to_f
		end
		puts"entro no def #{depreciacao_aux}"

		depreciado = (quantidade*(self.equipament.valor.to_f / (depreciacaoValida.to_f == 0.0 ? 1 : depreciacaoValida.to_f))).round(2)
		nameEquipament = self.equipament.name_equipament
		update_column(:name_equipament,(nameEquipament))

		puts"entro no def depois"

		valorEquipament = equipament.valor.to_f
		update_column(:depreciacao_valida, (depreciacaoValida))
		update_column(:quantidade, (self.quantidade))
		update_column(:valor_equipament, (valorEquipament))
		update_column(:valor_depreciado, (depreciado))
		
	end
end
