class ProposalEquipament < ActiveRecord::Base
  belongs_to :equipament
  belongs_to :proposal
  belongs_to :type_equipament

  accepts_nested_attributes_for :equipament, reject_if: :all_blank, allow_destroy:true

  
	

	#after_save :preeche_capos_vazios

	validates :type_equipament_id, numericality: { only_integer: true,  message: "should happen once per year"}

private
	def preeche_capos_vazios
		if quantidade.nil?
			quantidade = 0
		end

		if (depreciacao_aux != 1)
			depreciacao = depreciacao_aux
		else
			depreciacao = equipament.depreciacao.to_f
		end

		nameEquipament = equipament.name_equipament
		update_column(:depreciacao_aux,(depreciacao))
		update_column(:name_equipament,(nameEquipament))


		valorEquipament = equipament.valor.to_f
		depreciado = valorEquipament/equipament.depreciacao.to_f


		update_column(:quantidade, (quantidade))
		update_column(:valor_equipament, (valorEquipament))
		update_column(:valor_depreciado, (depreciado))
		
	end
end
