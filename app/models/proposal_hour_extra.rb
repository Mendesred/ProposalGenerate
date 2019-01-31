class ProposalHourExtra < ActiveRecord::Base
  require 'calculos_proposta'
  
  belongs_to :city
  belongs_to :rotation
  belongs_to :company
  belongs_to :admin

	has_many :hour_extra_roles, dependent: :destroy

	accepts_nested_attributes_for :hour_extra_roles, allow_destroy:true
	after_save :execult_saving_routine


	def execult_saving_routine
		select_calculation = Calculation.first
		calculos_proposta = CalculosProposta.new()

		totalSalarios = 0,efetivoTotal = 0,qtdPostos = 0,salario = 0,efetivoIndivitual = 0,acumuladorFuncionarios = 0,somaSup = 0, salarioMedio = 0,horasDeSalario = 0
		descontoVr = 0 ,tipoServico = 0,vUniUniforme = 0,vUniVR = 0, salarioUmCargo = 0,divisorTipoDeServico = 0,adNoturno = 0,horasAdNoturno = 0

		self.hour_extra_roles.each do |proposal_role| # for para contar e somar quantidades de funcionarios e somar seus salarios.##local que tem o 1 mudar para quantidade de funcionarios
			
			totalSalarios = (((proposal_role.role.salario.to_f*((proposal_role.role.gratificacao.to_f/100)+1)).round(2))*proposal_role.qtd_postos.to_f) #acumulador de totais da soma de cima.
			somaSup += totalSalarios
		
			qtdPostos = qtdPostos+(proposal_role.qtd_postos) #total de Postos #total Efetivo no posto 
		
			salario = proposal_role.role.salario.to_f #total Salario no posto 
			efetivoTotal += proposal_role.qtd_postos.to_f #total do efetivo da escala (efetivo*quantidade de postos)

			acumuladorFuncionarios += proposal_role.qtd_postos

			descontoVr = proposal_role.role.service.desconto_vr.to_f

			tipoServico = proposal_role.role.service.tipo_servico
			
			vUniUniforme = proposal_role.role.uniformes.to_f
		
			vUniVR = proposal_role.role.vale_refeicao.to_f

		end # fim do for proposal_role.

		efetivoTotal = (efetivoTotal).round(2)
		
		update_column(:salario, (salario))
		update_column(:qtd_postos, (qtdPostos))
		update_column(:total_salario, (somaSup).round(2))
		update_column(:efetivo_total, (efetivoTotal))
		update_column(:acumulador_funcionarios, (acumuladorFuncionarios))
		update_column(:tipo_servico, (tipoServico))
		
		salarioMedio = totalSalarios/qtdPostos

		if company.id == 1
			divisorTipoDeServico = 1.6
		else
			divisorTipoDeServico = 1.5
		end
		horasAdNoturno = ad_noturno*1.1429
		noturno = ((((salarioMedio/220)*0.2)*horasAdNoturno)/qtdPostos)
		horasDeSalario = ((((salarioMedio+noturno)/220)*divisorTipoDeServico*horas_extras)/qtdPostos)
		reflexos = ((horasDeSalario+noturno)/25.09*5.35)
		remuneracaoBasePorFunc = (horasDeSalario+noturno+reflexos)
		salarioTotal = (remuneracaoBasePorFunc * qtdPostos)

		fgts = ((select_calculation.fgts/100)*salarioTotal)
		inss = ((select_calculation.inss/100)*salarioTotal)
		a_seguro_aci_trabalho = (company.seguro_aci_trabalho)
		seguro_aci_trabalho = ((a_seguro_aci_trabalho/100)*salarioTotal)
		sebrae = ((select_calculation.sebrae/100)*salarioTotal)
		incra = ((select_calculation.incra/100)*salarioTotal)
		salario_educacao = ((select_calculation.salario_educacao/100)*salarioTotal)
		sesc = ((select_calculation.sesc/100)*salarioTotal)
		senac = ((select_calculation.senac/100)*salarioTotal)

		totalIncargosDiretos = (fgts+inss+seguro_aci_trabalho+sebrae+incra+salario_educacao+sesc+senac)

		feriasImpostos =								(salarioTotal*(select_calculation.ferias_h_ex/100))
		feriasUmTercoConstiUmDozeAvos =	(salarioTotal*(select_calculation.ferias_um_terco_constitucional/100))
		decimoTerceiroUmDozeAvos =			(salarioTotal*(select_calculation.decimo_terceito/100))
		inssSobFeriasUnTercoDecimo = 		((feriasImpostos+decimoTerceiroUmDozeAvos)*(select_calculation.pct_inss_sob_soma_decimo_um_terco_ferias/100))
		fgtsSobFeriasUnTercoDecimo = 		((feriasImpostos+decimoTerceiroUmDozeAvos)*(select_calculation.pct_fgts_sob_soma_decimo_um_terco_ferias/100))
		auxilioEnfermidade =						(0*(select_calculation.aux_enfermidade/100))
		avisoPrevio = 									(salarioTotal*(select_calculation.aviso_previo_hx/100))
		indenizacaoSobreFGTS = 					((fgts+fgtsSobFeriasUnTercoDecimo)*(select_calculation.indenizacao_fgts/100))
		coberturas = 										(0*(select_calculation.coberturas/100))

		totalProvisaoMassaSalarial = ( feriasImpostos+feriasUmTercoConstiUmDozeAvos+decimoTerceiroUmDozeAvos+inssSobFeriasUnTercoDecimo+
																	 fgtsSobFeriasUnTercoDecimo+auxilioEnfermidade+avisoPrevio+indenizacaoSobreFGTS+coberturas )
		
		#valor hora base é feito para ajustar ao calculo CRIAR ESSE CAMPO
		if descontoVr == 0.13
			valeRefeicaoHx = ((acumuladorFuncionarios*(vUniVR-0.13))/v_hora_base)
		elsif descontoVr == 0.8
			valeRefeicaoHx = ((acumuladorFuncionarios*vUniVR*0.8)/v_hora_base)
		elsif descontoVr == 0.82
			valeRefeicaoHx = ((acumuladorFuncionarios*vUniVR*0.82)/v_hora_base)
		end

		#criar variavel no formulario
		if (intermunicipal == 0 || intermunicipal.nil?)
			valorPassagem = city.valeTransporte
		else
			valorPassagem = intermunicipal
		end

		valeTransporte = ((valorPassagem*acumuladorFuncionarios*2)/v_hora_base)
		totBeneficios = valeRefeicaoHx+valeTransporte

		#####-> valor total de mão de obra <-#####
		totMaoDeObraParcial = salarioTotal+totalIncargosDiretos+totalProvisaoMassaSalarial+totBeneficios

		###############################################################################################################################################
		##-> calculo total mais lucro <-###############################################################################################################

		txOpr = 0

		#criar variavel no formulario
		if (tx_opracional.nil? || tx_opracional == 0)
			txOpr = select_calculation.indiceOperacional
		else
			txOpr = tx_opracional
		end
		valorIndiceOperacional = totMaoDeObraParcial*(txOpr/100)
		update_column(:taxa_operacional, (txOpr))

		###############################################################################################################################################
		##-> lucro ####################################################################################################################################
		
		txAdm = 0
		if (tx_administrativa.nil? || tx_administrativa == 0)
			txAdm = select_calculation.indiceAdministrativo
		else
			txAdm = tx_administrativa
		end
		update_column(:taxa_administrativo, (txAdm))

		valorIndiceAdministrativo = (valorIndiceOperacional+totMaoDeObraParcial)*(txAdm/100)
		operacionalAdminstrativo = valorIndiceAdministrativo+valorIndiceOperacional
		totMaoDeObraParcialIndiceOpcAdm = totMaoDeObraParcial+operacionalAdminstrativo

		valorIssqn = 	(totMaoDeObraParcialIndiceOpcAdm*(city.issqn/100))#totalDeServicos
		valorPis = 		(totMaoDeObraParcialIndiceOpcAdm*(company.pis/100))#totalDeServicos
		valorCofins = (totMaoDeObraParcialIndiceOpcAdm*(company.cofins/100))#totalDeServicos
		valorCsll = 	(totMaoDeObraParcialIndiceOpcAdm*(company.csll/100))#totalDeServicos
		valorIrrf = 	(totMaoDeObraParcialIndiceOpcAdm*(company.irrf/100))#totalDeServicos
		
		totImpostoSobServico =	valorPis+valorCofins+valorCsll+valorIrrf+valorIssqn
		vDeCalculoTotal =				valorPis+valorCofins+valorCsll+valorIrrf+valorIssqn+totMaoDeObraParcialIndiceOpcAdm

		valorHorasProposta =	vDeCalculoTotal/horas_extras


		puts"A - Encargos diretos"
		puts"salário base médio = #{horasDeSalario}"
		update_column(:calc_horas_extras, (horasDeSalario))
		puts"adicional noturno = #{noturno}"
		update_column(:calc_ad_noturno, (noturno))
		puts"reflexos = #{reflexos}"
		update_column(:calc_reflexos, (reflexos))
		puts"remuneracaoBasePorFunc = #{remuneracaoBasePorFunc}"
		update_column(:calc_remuneracao_base_p_func, (remuneracaoBasePorFunc))
		puts"salarioTotal = #{salarioTotal}"
		update_column(:calc_total_salario, (salarioTotal))

		puts"B - Encargos diretos"

		puts"Fgts = #{fgts}"
		update_column(:b_fgts, (fgts))
		puts"Inss = #{inss}"
		update_column(:b_inss, (inss))
		puts"seguro acidente do trabalho = #{seguro_aci_trabalho}"
		update_column(:seguro_aci_trabalho, (a_seguro_aci_trabalho))
		update_column(:b_seg_acidente_trabalho, (seguro_aci_trabalho))
		puts"Sebrae = #{sebrae}"
		update_column(:b_sebrae, (sebrae))
		puts"Incra = #{incra}"
		update_column(:b_incra, (incra))
		puts"salário educação = #{salario_educacao}"
		update_column(:b_salario_educacao, (salario_educacao))
		puts"Sesc = #{sesc}"
		update_column(:b_sesc, (sesc))
		puts"Senac = #{senac}"
		update_column(:b_senac, (senac))
		puts"total encargos diretos = #{totalIncargosDiretos}"
		update_column(:b_total_incargos_diretos, (totalIncargosDiretos))

		puts"C - Encargos diretos"

		puts"feriasImpostos = #{feriasImpostos}"
		update_column(:c_ferias, (feriasImpostos))
		puts"férias 1/3 constitucional = #{feriasUmTercoConstiUmDozeAvos}"
		update_column(:c_ferias_um_terco_constitucional, (feriasUmTercoConstiUmDozeAvos))
		puts"13º salário = #{decimoTerceiroUmDozeAvos}"
		update_column(:c_decimo_terceiro_salario, (decimoTerceiroUmDozeAvos))
		puts"inssSobFeriasUnTercoDecimo = #{inssSobFeriasUnTercoDecimo} #{ select_calculation.pct_inss_sob_soma_decimo_um_terco_ferias}"
		update_column(:c_inss, (inssSobFeriasUnTercoDecimo))
		puts"fgtsSobFeriasUnTercoDecimo = #{fgtsSobFeriasUnTercoDecimo} #{ select_calculation.pct_fgts_sob_soma_decimo_um_terco_ferias}"
		update_column(:c_fgts, (fgtsSobFeriasUnTercoDecimo))
		puts"auxilio Enfermidade = #{auxilioEnfermidade}"
		update_column(:c_auxilio_enfermidade, (auxilioEnfermidade))
		puts"aviso Previo = #{avisoPrevio}"
		update_column(:c_aviso_previo, (avisoPrevio))
		puts"indenizacao Sobre FGTS = #{indenizacaoSobreFGTS}"
		update_column(:c_fgts_indenizado, (indenizacaoSobreFGTS))
		puts"coberturas = #{coberturas}"
		update_column(:c_cooberturas, (coberturas))
		puts"total Provisao Massa Salarial = #{totalProvisaoMassaSalarial}"
		update_column(:c_total_previsões, (totalProvisaoMassaSalarial))

		puts"D - Encargos diretos"

		puts"vale refeição = #{valeRefeicaoHx}"
		update_column(:d_uni_vr, (vUniVR))
		update_column(:d_vr, (valeRefeicaoHx))

		puts"vale transporte = #{valeTransporte} #{valorPassagem}"
		update_column(:d_uni_vt, (valorPassagem))
		update_column(:d_vt, (valeTransporte))

		puts"total benefícios = #{totBeneficios}"
		update_column(:tot_beneficios, (totBeneficios))

		puts"Total (I) - Mao de obra = #{totMaoDeObraParcial}"
		update_column(:tot_mao_de_obra_parcial, (totMaoDeObraParcial))

		puts"E - Operação"
		puts"Gestão Operacional = #{valorIndiceOperacional} #{txOpr}"
		update_column(:gestao_operacional, (valorIndiceOperacional))
		puts"F - Administração"
		puts"Gestão Administrativa = #{valorIndiceAdministrativo} #{txAdm}"
		update_column(:gestao_administrativa, (valorIndiceAdministrativo))
		puts"Total (II) - Operação e Administração #{operacionalAdminstrativo}"
		update_column(:operacional_administrativo, (operacionalAdminstrativo))
		puts"total (I+II)#{totMaoDeObraParcialIndiceOpcAdm}"
		puts"G - Impostos sobre serviços"
		puts"valorIssqn = #{valorIssqn}"
		update_column(:inss, (valorIssqn))
		puts"valorPis = #{valorPis}"
		update_column(:pis, (valorPis))
		puts"valorCofins = #{valorCofins}"
		update_column(:cofins, (valorCofins))
		puts"valorCsll = #{valorCsll}"
		update_column(:csll, (valorCsll))
		puts"valorIrrf = #{valorIrrf}"
		update_column(:irrf, (valorIrrf))
		puts"total (III) #{totImpostoSobServico}"
		update_column(:tot_impostos_sob_servico, (totImpostoSobServico))

		puts"Valor dos serviços#{totMaoDeObraParcialIndiceOpcAdm}"
		update_column(:valor_servico, (totMaoDeObraParcialIndiceOpcAdm))

		 

		#update_column(:vDeCalculoTotal, (totMaoDeObraParcialIndiceOpcAdm))
		puts"Valor de impostos#{totImpostoSobServico}"
		puts"Valor Total Mensal#{vDeCalculoTotal}"
		puts"n Horas#{horas_extras}"
		update_column(:n_horas_extras, (horas_extras))
		puts"valor da hora#{valorHorasProposta}"
		update_column(:v_hora_proposta, (valorHorasProposta))

    #t.float :salario
    #t.float :n_funcionario
    #t.float :acumulador_funcionarios
	end
end