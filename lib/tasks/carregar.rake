namespace :carregar do

		def criaEquipment(nomeFornecedor,typeEquiId,subTypeId,nameEquipament,macaMod,recManutencao,valor,depreciacao,obsEquipament)
		Equipament.find_or_create_by!(
       fornecedor:nomeFornecedor,#0
       type_equipament_id:typeEquiId,#1
       sub_type_id:subTypeId,#2
       name_equipament:nameEquipament,#3
       maca_mod:macaMod,#4
       rec_manutencao:recManutencao,#5
       valor:valor,#6
       depreciacao:depreciacao,#7
       obs_equipament:obsEquipament)#8
		puts"equipamento criado"
  end
  desc "TODO"
  task equipamentos: :environment do
		require "csv"
	
		CSV.foreach(File.join(Rails.root,"db/equipamentos.csv" ), :headers => true,encoding:'iso-8859-1:utf-8') do |row|
			type = TypeEquipament.find_by(name_type: row[1])
			sub_type = SubType.find_by(name_sub_type: row[2])
		  criaEquipment(row[0],type.id,sub_type.id,row[3],row[4],row[5],row[6],row[7],row[8])
		end
  
  end
end
