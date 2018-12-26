# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Company.find_or_create_by(
		name_company: "Iron",
		irrf:1.0,
		csll:1.0,
		pis:0.65,
		cofins:3.0,
		seguro_aci_trabalho:2.9631,
		pct_reserva_tecnica:3.73)
Company.find_or_create_by(
		name_company: "Vetor",
		irrf:1.0,
		csll:1.0,
		pis:1.65,
		cofins:7.6,
		seguro_aci_trabalho:2.4648,
		pct_reserva_tecnica:3.73)

puts "Empresas criadas"
Service.find_or_create_by!(
		tipo_servico: 'Segurança', company: Company.first, desconto_vr:0.82, cesta:49.11)
Service.find_or_create_by!(
		tipo_servico: 'Portaria',	company: Company.last, desconto_vr:0.8,	cesta:127.5)
Service.find_or_create_by!(
		tipo_servico: 'Limpeza', 	company: Company.last, desconto_vr:0.13, cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Manutenção',	company: Company.last, desconto_vr:0.13, cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Jardinagem', company: Company.last, desconto_vr:0.13, cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Outros', company: Company.last, desconto_vr:0.13, cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Segurança Parcial', company: Company.first,	desconto_vr:0.82,	cesta:49.11)
Service.find_or_create_by!(
		tipo_servico: 'Portaria Parcial', company: Company.last, desconto_vr:0.8,	cesta:127.5)
Service.find_or_create_by!(
		tipo_servico: 'Limpeza Parcial', company: Company.last,	desconto_vr:0.13,	cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Manutenção Parcial', company: Company.last, desconto_vr:0.13, cesta:102.59)
Service.find_or_create_by!(
		tipo_servico: 'Jardinagem Parcial', company: Company.last, desconto_vr:0.13,cesta:102.59)

puts  "Tipos de serviços criados"
							
periods = [ "Matutino",
						"Vespertino",
						"Noturno",
						"Matutino/Vespertino",
						"Matutino/Noturno",
						"Vespertino/Noturno",
						"Matutino/Vespertino/Noturno"]

periods.each do |period|
	Period.find_or_create_by(periodo: period)
end
puts  "Periodos criados"

Rotation.find_or_create_by(
		tipo_escala:'5x1 24h Padrão três periodos três funcinarios',
		qtd_funcionarios:3,
		efetivo:3.6,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.last,
		ad_vespertido_noturno:0.1,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'5x1 um periodo, MATUTINO e 1 funcinario por posto',
		qtd_funcionarios:1,
		efetivo:1.2,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'5x1 um periodo, VESPERTINO e 1 funcinario por posto',
		qtd_funcionarios:1,
		efetivo:1.2,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:2),
		ad_vespertido_noturno:0.1,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'5x1 um periodo, NOTURNO e 1 funcinario por posto',
		qtd_funcionarios:1,
		efetivo:1.2,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:3),
		ad_vespertido_noturno:0.0,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'5x1 dois periodo Matutino/Vespertino e 1 funcinario por posto e preiodo',
		qtd_funcionarios:2,
		efetivo:2.4,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:4),
		ad_vespertido_noturno:0.1,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'5x1 dois periodo Noturno/Matutino e 1 funcinario por posto e preiodo',
		qtd_funcionarios:2,
		efetivo:2.4,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:5),
		ad_vespertido_noturno:0.0,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'5x1 dois periodo Vespertino/Noturno e 1 funcinario por posto e preiodo',
		qtd_funcionarios:2,
		efetivo:2.4,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:66.88,
		period:Period.find_by(id:6),
		ad_vespertido_noturno:0.1,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'5x2h Diurno/Noturno 44H Semanais',
		qtd_funcionarios:2,
		efetivo:2,
		dias_trabalhados:21.75,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.last,
		ad_vespertido_noturno:0.0,
		ad_noturno:9.14)

Rotation.find_or_create_by(
		tipo_escala:'5x2h DIURNO 44H Semanais',
		qtd_funcionarios:1,
		efetivo:1,
		dias_trabalhados:21.75,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'5x2h NOTURNO 44H Semanais',
		qtd_funcionarios:1,
		efetivo:1,
		dias_trabalhados:21.75,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.find_by(id:3),
		ad_vespertido_noturno:0.0,
		ad_noturno:9.14)

Rotation.find_or_create_by(
		tipo_escala:'6x1h Diurno/Noturno 44H Semanais',
		qtd_funcionarios:2,
		efetivo:2,
		dias_trabalhados:26.1,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.last,
		ad_vespertido_noturno:0.0,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'6x1h DIURNO 44H Semanais',
		qtd_funcionarios:1,
		efetivo:1,
		dias_trabalhados:26.1,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:0.0)

Rotation.find_or_create_by(
		tipo_escala:'6x1h NOTURNO 44H Semanais',
		qtd_funcionarios:1,
		efetivo:1,
		dias_trabalhados:26.1,
		fator_escala:30.44,
		v_reciclagem:74.55,
		period:Period.find_by(id:3),
		ad_vespertido_noturno:0.0,
		ad_noturno:9.14)

Rotation.find_or_create_by(
		tipo_escala:'12x36 24h Padrão dois periodos',
		qtd_funcionarios:2,
		efetivo:4,
		dias_trabalhados:15.22,
		fator_escala:30.44,
		v_reciclagem:91.23,
		period:Period.last,
		ad_vespertido_noturno:0.0,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'12x36 12h Dia',
		qtd_funcionarios:1,
		efetivo:2,
		dias_trabalhados:15.22,
		fator_escala:30.44,
		v_reciclagem:91.23,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:0)

Rotation.find_or_create_by(
		tipo_escala:'12x36 12h Noite',
		qtd_funcionarios:1,
		efetivo:2,
		dias_trabalhados:15.22,
		fator_escala:30.44,
		v_reciclagem:91.23,
		period:Period.find_by(id:3),
		ad_vespertido_noturno:0.0,
		ad_noturno:7)

Rotation.find_or_create_by(
		tipo_escala:'5x1 4h Dia',
		qtd_funcionarios:1,
		efetivo:1.2,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:28.78,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:0)

Rotation.find_or_create_by(
		tipo_escala:'5x1 4h Noite',
		qtd_funcionarios:1,
		efetivo:1.2,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:28.78,
		period:Period.find_by(id:1),
		ad_vespertido_noturno:0.0,
		ad_noturno:4)

Rotation.find_or_create_by(
		tipo_escala:'5x1 dois periodo Matutino/Noturno e 1 escala 4h',
		qtd_funcionarios:2,
		efetivo:2.4,
		dias_trabalhados:25.3646,
		fator_escala:30.44,
		v_reciclagem:28.78,
		period:Period.find_by(id:6),
		ad_vespertido_noturno:0.1,
		ad_noturno:5)


puts  "Escala criada"
	
# City.find_or_create_by!(
# 		nome:'Campinas',
# 		feriado:13,
# 		valeTransporte:4.30,
# 		issqn:2.0)
# City.find_or_create_by!(
# 		nome:'Valinhos',
# 		feriado:14,
# 		valeTransporte:4.0,
# 		issqn:3.0)
# City.find_or_create_by!(
# 		nome:'Teste 0',
# 		feriado:11,
# 		valeTransporte:2,
# 		issqn:0.0)

#puts  "Cidade criada"


Role.find_or_create_by!(
		cargo:'Vigilante',
		salario:1486.9,
		gratificacao:0.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante Monitor de Segurança Eletrônica',
		salario:1486.9,
		gratificacao:5.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante Condutor de Veículo / Cão',
		salario:1486.9,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)
												
Role.find_or_create_by!(
		cargo:'Vigilante Lider',
		salario:1486.9,
		gratificacao:12.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Controlador de Acesso',
		salario:1296.69,
		gratificacao:0.0,
		vale_refeicao:16.6,
		assist_medica:0.0,
		seg_vida:1.84,
		uniformes:26.38,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:224.4,
		service: Service.find(2))

Role.find_or_create_by!(
		cargo:'Auxiliar de Limpeza',
		salario:1110.70,
		gratificacao:0.0,
		vale_refeicao:14.73,
		assist_medica:0.0,
		seg_vida:1.84,
		uniformes:16.83,
		assist_Soc_Familiar:9.33,
		beneficio_Natalidade:3.76,
		ppr:258.57,
		service: Service.find(3))
#*novos Cargos*#
Role.find_or_create_by!(
		cargo:'Jardineiro',
		salario:1279.88,
		gratificacao:0.0,
		vale_refeicao:14.73,
		assist_medica:0.0,
		seg_vida:1.84,
		uniformes:16.83,
		assist_Soc_Familiar:9.33,
		beneficio_Natalidade:3.76,
		ppr:258.57,
		service: Service.find(5))

Role.find_or_create_by!(
		cargo:'Auxiliar de Manutenção',
		salario:1179.11,
		gratificacao:0.0,
		vale_refeicao:14.73,
		assist_medica:0.0,
		seg_vida:1.84,
		uniformes:16.83,
		assist_Soc_Familiar:9.33,
		beneficio_Natalidade:3.76,
		ppr:258.57,
		service: Service.find(4))

Role.find_or_create_by!(
		cargo:'Líder de Limpeza',
		salario:1500.00,
		gratificacao:0.0,
		vale_refeicao:14.73,
		assist_medica:0.0,
		seg_vida:1.84,
		uniformes:16.83,
		assist_Soc_Familiar:9.33,
		beneficio_Natalidade:3.76,
		ppr:258.57,
		service: Service.find(3))

Role.find_or_create_by!(
		cargo:'Vigilante/Condutor de Veículos Motorizados',
		salario:1486.9,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:24.81,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante/Segurança Pessoal',
		salario:1486.9,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:24.81,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante Balanceiro',
		salario:1486.9,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:24.81,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante/Brigadista',
		salario:1486.9,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:231.92,
		seg_vida:7.76,
		uniformes:24.81,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.first)

Role.find_or_create_by!(
		cargo:'Vigilante em Regime de Tempo Parcial',
		salario:878.65,
		gratificacao:0.0,
		vale_refeicao:22.62,
		assist_medica:227.71,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.find(7))

Role.find_or_create_by!(
		cargo:'Vigilante Condutor em Regime de Tempo Parcial',
		salario:878.65,
		gratificacao:10.0,
		vale_refeicao:22.62,
		assist_medica:227.71,
		seg_vida:7.76,
		uniformes:36.79,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:0.0,
		service: Service.find(7))

Role.find_or_create_by!(
		cargo:'Controlador em Regime de Tempo Parcial',
		salario:666.03,
		gratificacao:0.0,
		vale_refeicao:16.6,
		assist_medica:0.0,
		seg_vida:1.79,
		uniformes:26.39,
		assist_Soc_Familiar:0.0,
		beneficio_Natalidade:0.0,
		ppr:224.4,
		service: Service.find(8))

Role.find_or_create_by!(
		cargo:'Auxiliar de Limpeza (piso)',
		salario:555.35,
		gratificacao:0.0,
		vale_refeicao:14.73,
		assist_medica:0.0,
		seg_vida:1.79,
		uniformes:16.89,
		assist_Soc_Familiar:9.33,
		beneficio_Natalidade:3.76,
		ppr:258.57,
		service: Service.find(9))

puts  "Cargo criado"

category = ["Acabamentos",
						"Descartáveis",
						"Especiais",
						"Jardim",
						"Limpeza",
						"Seg/Port"]

category.each do |cate|
	TypeEquipament.find_or_create_by(name_type: cate)
end

puts  "Categoria Equipamento criado"

subCategory = [	["Acabamento","Acabamentos"],
								["Container","Especiais"],
								["Descartável","Descartáveis"],
								["EPI","Jardim"],
								["EPI","Limpeza"],
								["Equipamento","Jardim"],
								["Equipamento","Limpeza"],
								["Ferramenta","Jardim"],
								["Jardim","Especiais"],
								["Lavadora","Especiais"],
								["Produto","Limpeza"],
								["Seg/Port","Seg/Port"],
								["Utensílio","Limpeza"]]

subCategory.each do |row|
	SubType.find_or_create_by(name_sub_type: row[0],type_equipament_id: TypeEquipament.find_by(name_type: row[1]).id)
end
puts  "Sub-Categoria Equipamento criado"

Calculation.find_or_create_by( 
		salario_minimo:954.00,
		fgts:8.0,
		inss:20.0,
		sebrae:0.6,
		incra:0.2,
		salario_educacao:2.5,
		sesc:1.5,
		senac:1.0,
		ferias:8.3333 ,
		um_terco_constitucional:2.7775 ,
		decimo_terceito: 8.3333,
		pct_inss_sob_soma_decimo_um_terco_ferias: 28.8,
		pct_fgts_sob_soma_decimo_um_terco_ferias: 8,
		aviso_previo:0.18 ,
		indenizacao_fgts: 50.0,
		indiceAdministrativo: 5.6,
		indiceOperacional: 9.85,
		horasDeCalculoAdNoturno:52.5)

puts  "Campos de calculos criados"
# Admin.create!( 
# 		nome: "Administrador",
# 		email:"ti@grupoiron.com",
# 		password:"123456",
# 		password_confirmation:"123456",
# 		privilegio: 0)
# Admin.create!( 
# 		nome: "vivian",
# 		email:"vivian@grupoiron.com",
# 		password:"123456",
# 		password_confirmation:"123456",
# 		privilegio: 0)
# Admin.create!( 
# 		nome: "usuario",
# 		email:"usuario@grupoiron.com",
# 		password:"123456",
# 		password_confirmation:"123456",
# 		privilegio: 1)
# Admin.create!( 
# 		nome: "luiz",
# 		email:"luiz@grupoiron.com",
# 		password:"123456",
# 		password_confirmation:"123456",
# 		privilegio: 1)
# puts  "Campos de Admins criados"
=begin
10.times do
	Proposal.find_or_create_by!(
		cliente: Faker::Name.first_name,
		codigo_cliente: Faker::Address.building_number,
		admin: Admin.all.sample,
		city: City.all.sample,
		company: Company.all.sample,
		rotation: Rotation.all.sample,
		equipament_id: Equipament.all.sample,
		proposal_roles: Proposal_role.role_id.all.sample,
		proposal_roles: Proposal_role.qtd_postos(Random.rand(1..3)),
		role_id: Role.all.sample,
		h_almoco:(Random.rand(0.01..10)),
		h_feriado:(Random.rand(0.01..10)),
		adcional_periculosidade_insalubridade:(Random.rand(0.01..10)),
		indice_retorno:(Random.rand(0.01..10)),
		taxa_admin:(Random.rand(0.01..10)),
		intermunicipal:(Random.rand(0.01..10)),
		dias_vr:(Random.rand(0.01..10)),
		dias_vt:(Random.rand(0.01..10)))
	end
=end
puts  "propostas criados"