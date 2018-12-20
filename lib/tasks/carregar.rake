namespace :carregar do

		def criaEquipment(nomeFornecedor,typeEquiId,subTypeId,nameEquipament,macaMod,recManutencao,valor,depreciacao,obsEquipament)
		Equipament.find_or_create_by!(
       fornecedor:nomeFornecedor,#0
       type_equipament_id:typeEquiId,#1
       sub_type_id:subTypeId,#2
       name_equipament:nameEquipament,#3
       marca_mod:macaMod,#4
       rec_manutencao:recManutencao,#5
       valor:valor,#6
       depreciacao:depreciacao,#7
       obs_equipament:obsEquipament)#8
  end
desc "TODO"
  task equipamentos: :environment do
    require "csv"
  
    CSV.foreach(File.join(Rails.root,"db/equipamentos.csv" ), :headers => true,encoding:'iso-8859-1:utf-8') do |row|
      type = TypeEquipament.find_by(name_type: row[1])
      sub_type = SubType.find_by(name_sub_type: row[2],type_equipament_id: type.id)
      criaEquipment(row[0],type.id,sub_type.id,row[3],row[4],row[5],row[6],row[7],row[8])
    end
		puts"equipamento criado"
  
  end
end
# desc "Example of task with parameters and prerequisites"
# task escala: :rotation do

# Rotation.find_or_create_by(
#     tipo_escala:'5x1 dois periodo Matutino/Noturno e 1 escala 4h',
#     qtd_funcionarios:2,
#     efetivo:2.4,
#     dias_trabalhados:25.3646,
#     fator_escala:30.44,
#     v_reciclagem:28.78,
#     period:Period.find_by(id:6),
#     ad_vespertido_noturno:0.1,
#     ad_noturno:7)

# Rotation.find_or_create_by(
#     tipo_escala:'5x1 dois periodo Matutino e 1 escala 4h',
#     qtd_funcionarios:1,
#     efetivo:1.2,
#     dias_trabalhados:25.3646,
#     fator_escala:30.44,
#     v_reciclagem:28.78,
#     period:Period.find_by(id:6),
#     ad_vespertido_noturno:0,
#     ad_noturno:0)

# Rotation.find_or_create_by(
#     tipo_escala:'5x1 dois periodo Noturno e 1 escala 4h',
#     qtd_funcionarios:1,
#     efetivo:1.2,
#     dias_trabalhados:25.3646,
#     fator_escala:30.44,
#     v_reciclagem:28.78,
#     period:Period.find_by(id:6),
#     ad_vespertido_noturno:0.1,
#     ad_noturno:4)
#   end
# puts "escalas Criadas"

# desc "Example of task with parameters and prerequisites"
# task service: :service do

# Service.find_or_create_by!(
#   tipo_servico: 'Portaria Parcial', company: Company.last, desconto_vr:0.8, cesta:127.5)
# Service.find_or_create_by!(
#   tipo_servico: 'Limpeza Parcial', company: Company.last, desconto_vr:0.13, cesta:102.59)
# Service.find_or_create_by!(
#   tipo_servico: 'Manutenção Parcial', company: Company.last, desconto_vr:0.13, cesta:102.59)
# Service.find_or_create_by!(
#   tipo_servico: 'Jardinagem Parcial', company: Company.last, desconto_vr:0.13,cesta:102.59)
# end

# puts "escalas serviço"