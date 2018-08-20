namespace :proposal do
  desc "TODO"
  task new: :environment do
    10.times do|i|
	   puts  "Criando Proposta"
	   createProposal()
	   puts  "Proposta Criada"
   end
  end


  def createProposal()
  	service = Service.first#Service.order("RANDOM()").first

  	proposta = Proposal.new()
    proposta.admin_id = Admin.first.id
  	proposta.user_criate = Admin.first.nome
  	proposta.city_id = City.first.id#City.order("RANDOM()").first.id
  	proposta.rotation_id = Rotation.first.id
  	proposta.period_id = Period.order("RANDOM()").first.id
  	proposta.intermunicipal = rand(0..10)
  	proposta.company_id = service.company_id
  	proposta.adcional_periculosidade_insalubridade = rand(0..3)
  	proposta.grau_de_insalubridade = [0,0.10,0.20,0.40].shuffle.first
  	proposta.controle_hora_extra = rand(0..1)
  	proposta.h_extra_jornada_all = rand(0..1)
  	proposta.dias_jornada_ex_semana_all = rand(1..7)
  	proposta.h_ex_jornada_all= rand(0..2)
  	proposta.m_ex_jornada_all= rand(0..59)
  	proposta.h_ex_feriado_jornada_all = rand(0..1)
  	proposta.h_extra_jornada_matu = rand(0..1)
  	proposta.dias_ex_semana_matu = rand(1..7)
  	proposta.h_ex_jornada_matu= rand(0..2)
  	proposta.m_ex_jornada_matu= rand(0..59)
  	proposta.h_ex_feriado_jornada_matu = rand(0..1)
  	proposta.h_extra_jornada_vesp = rand(0..1)
  	proposta.dias_ex_semana_vesp = rand(1..7)
  	proposta.h_ex_jornada_vesp= rand(0..2)
  	proposta.m_ex_jornada_vesp= rand(0..59)
  	proposta.h_ex_feriado_jornada_vesp = rand(0..1)
  	proposta.h_extra_jornada_notur = rand(0..1)
  	proposta.dias_ex_semana_notur = rand(1..7)
  	proposta.h_ex_jornada_notur= rand(0..2)
  	proposta.m_ex_jornada_notur= rand(0..59)
  	proposta.h_ex_feriado_jornada_notur = rand(0..1)
    proposta.controle_vr = rand(0..1)
  	proposta.h_feriado = rand(0..1)
  	proposta.vr_all = rand(0..1)
  	proposta.dias_pg_vr_semana_all = rand(1..7)
  	proposta.dias_pg_vr_feriado_all = rand(0..1)
  	proposta.vr_matu = rand(0..1)
  	proposta.dias_pg_vr_semana_matu= rand(1..7)
  	proposta.dias_pg_vr_feriado_matu = rand(0..1)
  	proposta.vr_vesp = rand(0..1)
  	proposta.dias_pg_vr_semana_vesp= rand(1..7)
  	proposta.dias_pg_vr_feriado_vesp = rand(0..1)
  	proposta.vr_notur= rand(0..1)
  	proposta.dias_pg_vr_semana_notur= rand(1..7)
  	proposta.dias_pg_vr_feriado_notur= rand(0..1)
  	proposta.controle_vt = rand(0..1)
  	proposta.vt_all = rand(0..1)
  	proposta.dias_pg_vt_semana_all = rand(1..7)
  	proposta.dias_pg_vt_feriado_all = rand(0..1)
  	proposta.vt_matu = rand(0..1)
  	proposta.dias_pg_vt_semana_matu= rand(1..7)
  	proposta.dias_pg_vt_feriado_matu = rand(0..1)
  	proposta.vt_vesp = rand(0..1)
  	proposta.dias_pg_vt_semana_vesp= rand(1..7)
  	proposta.dias_pg_vt_feriado_vesp = rand(0..1)
  	proposta.vt_notur= rand(0..1)
  	proposta.dias_pg_vt_semana_notur= rand(1..7)
  	proposta.dias_pg_vt_feriado_notur= rand(0..1)
    p_e = ProposalEquipament.new()
    p_e.equipament_id = Equipament.where(["id > 1"]).order("RANDOM()").first.id
    p_e.quantidade = rand(1..7)
    p_e.proposal_id = proposta.id
    proposta.proposal_equipaments << p_e

    p_r = ProposalRole.new()
    p_r.role_id = Role.where(["service_id =?", service.id]).first.id
    p_r.qtd_postos = rand(1..7)
    p_r.proposal_id = proposta.id
    proposta.proposal_roles << p_r

  	proposta.save()
  end

end

