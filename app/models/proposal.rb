class Proposal < ActiveRecord::Base
	require 'calculos_proposta'

	belongs_to :city
	belongs_to :rotation
	belongs_to :company
	belongs_to :admin
	#belongs_to :role  #por hora a conecção sera has_many

	has_many :proposal_equipaments
	has_many :proposal_roles
	#has_many :equipaments, :through => :proposal_equipaments

	#######################################################################
	## Js Original com funções do collapse na pasta Bug_somente_consulta ##
	#######################################################################

	###############
	# Associações #
	###############
	accepts_nested_attributes_for :proposal_equipaments, allow_destroy:true
	accepts_nested_attributes_for :proposal_roles, allow_destroy:true


	after_save :execult_saving_routine
	after_save :prenche_vasio

	#validates :cliente, presence: true
	#validate :valida_dias_semana
	#def valida_dias_semana
	#	if (dias_jornada_ex_semana_all.to_f + dias_refeicao_ex_semana_all.to_f )>7 && ((h_extra_jornada_all==1) && (h_extra_refeicao_all==1))
	#		
	#		errors.add(:dias_jornada_ex_semana_all ,"A soma da quantidade de dias da semana entre jornada e refeição não pode ser superior a 7 por favor corrigir.")
	#	end
	#end

	private


		#def calculos_proposta.calculo_modelo_de_horas_extras(diasDoMesTrabalhados,diasDaSemana,diasDeJonadaDeHorasExtra,feriado = 0,quantidadeDePostos,horasExJornada,minutosExJornada)
		#	((diasDoMesTrabalhados/diasDaSemana *diasDeJonadaDeHorasExtra)+feriado)*(quantidadeDePostos)*(horasExJornada+minutosExJornada)
		#end

		def prenche_vasio

			if (cliente.blank?)
				cliente = Faker::DragonBall.character
				update_column(:cliente,(cliente))
			end

			if (codigo_cliente.blank?)
				codigo_cliente = rand(10000000..99999999)
				update_column(:codigo_cliente,(codigo_cliente))

			end
		end

	def execult_saving_routine
		select_calculation = Calculation.first
		calculos_proposta = CalculosProposta.new()

		vA = 0,totalEquipamento = 0.0,efetivoTotal = 0,totalSalarios = 0, baseCalculoSalarioMedio = 0,valorDeInsalubridade = 0,salario = 0, 
		valorDePericulosidade = 0,valorPeriOuIsalubri = 0,totalHrExtras = 0,totalFuncionarios = 0,
		efetivoIndivitual = 0,totalHrsAdNoturnoVespertino = 0,totalHrsAdNoturno = 0, acumuladorFuncionarios = 0, hAlmoco = 0,obgFGTS = 0,
		obgINSS = 0, obgseguro_aci_trabalho = 0,seguro_aci_trabalho = 0, obgsebrae = 0, obgincra = 0, obgsalario_educacao = 0, 
		obgsesc = 0 , obgsenac  = 0 ,totalIncargosDiretos = 0,totalferiasUmDozeAvos = 0,totalumTercoConstiUmDozeAvos = 0,
		totaldecimoTerceiroUmDozeAvos = 0,totalInssSobFeriasUnTercoDecimo = 0,totalFgtsSobFeriasUnTercoDecimo = 0,totalAvisoPrevio = 0,
		totalIndenizacaoSobreFGTS = 0,reservaTecnica = 0,totCesta = 0,totVR = 0,totAssiteciaMedica = 0,totSeguroVida = 0,totVT = 0,
		totReciclagem = 0,totUniforme = 0,vDeCalculoTotal = 0,pctTotal = 0, valorCofins= 0, valorPis = 0, vUniAssistMedica = 0,
		vUniUniforme = 0,vUniVR = 0,vUniSegVida = 0, horas_vespertino = 0,vUniPpr = 0,descontoVr = 0,tipoServico = 0, valorCesta  = 0,
		valorSocFamiliar = 0,valorBenNatalidade = 0, multiplicador = 0,totSocialFamiliar = 0,totBenNatalidade = 0,horas_trabalhadas = 0,
		h_refeicao = 0, qtdPostos = 0,teste1 = 0,	teste2 = 0,	teste3 = 0,	teste4 = 0,#teste5 = 'to no inicio'

		self.proposal_equipaments.each do |proposal_equipament| # for usado para pegar todos os equipamentos adcionados na proposta.
			unless (proposal_equipament.quantidade.blank? || proposal_equipament.equipament.depreciacao.nil?)
				totalEquipamento += (proposal_equipament.quantidade*
															(proposal_equipament.equipament.valor.to_f / 
																proposal_equipament.equipament.depreciacao.to_f ))# total do valor de equipamento (usar na soma de totais).
			end
		end

		self.proposal_roles.each do |proposal_role| # for para contar e somar quantidades de funcionarios e somar seus salarios.
			totalSalarios = totalSalarios+((proposal_role.role.salario.to_f*
												((proposal_role.role.gratificacao.to_f/100).round(2)+1)).round(2)*self.rotation.efetivo)*
													proposal_role.qtd_postos.to_f #acumulador de totais da soma de cima.

			efetivoTotal += self.rotation.efetivo*proposal_role.qtd_postos.to_f #total do efetivo da escala (efetivo*quantidade de postos)

			qtdPostos = qtdPostos+(proposal_role.qtd_postos) #total de Postos #total Efetivo no posto 
			 
			salario = proposal_role.role.salario.to_f #total Salario no posto 
			 
			efetivoIndivitual = self.rotation.efetivo/self.rotation.qtd_funcionarios.to_f
			
			acumuladorFuncionarios+=self.rotation.qtd_funcionarios*proposal_role.qtd_postos


			##########################################################################################################
			####### Abaixo esta alguns valores que será usado para calculos mais abaixo 											########
			####### aproveitei a requisição de porposal roles para armasenar o valor do ultimo cago adcionado ########
			####### Estou ciente que não é a melhor forma de pegar este dado porem foi a unica que encontei		########
			####### NOTA PARA FUTURAS MANUTENÇÕES																															########
			##########################################################################################################

			vUniAssistMedica = proposal_role.role.assist_medica.to_f

			descontoVr = proposal_role.role.service.desconto_vr.to_f

			valorCesta = proposal_role.role.service.cesta.to_f

			valorSocFamiliar = proposal_role.role.assist_Soc_Familiar.to_f

			valorBenNatalidade = proposal_role.role.beneficio_Natalidade.to_f

			tipoServico = proposal_role.role.service.tipo_servico
			
			vUniUniforme = proposal_role.role.uniformes.to_f
		
			vUniPpr = proposal_role.role.ppr.to_f
			
			vUniVR = proposal_role.role.vale_refeicao.to_f
			
			vUniSegVida = proposal_role.role.seg_vida.to_f
		end # fim do for proposal_role.

		efetivoTotal =(efetivoTotal).round(2)
		
		if (totalEquipamento.nil?)
			totalEquipamento = 0
			update_column(:total_equipamento, (totalEquipamento))
		else 
			update_column(:total_equipamento, (totalEquipamento))
		end

		update_column(:salario, (salario))
		update_column(:qtd_postos, (qtdPostos))
		update_column(:total_salarios, (totalSalarios).round(2))
		update_column(:efetivo_total, (efetivoTotal))
		update_column(:efetivo_indivitual, (efetivoIndivitual))
		update_column(:acumulador_funcionarios, (acumuladorFuncionarios))
		update_column(:valor_uni_assist_medica, (vUniAssistMedica))
		update_column(:valor_unitario_uniforme, (vUniUniforme))
		update_column(:valor_unitario_vr, (vUniVR))
		update_column(:valor_unitario_seg_vida, (vUniSegVida))
		update_column(:valor_unitario_ppr, (vUniPpr))
		update_column(:tipo_servico, (tipoServico))
		update_column(:valor_cesta, (valorCesta))
		update_column(:valor_ben_natalidade, (valorBenNatalidade))
		update_column(:valor_soc_familiar, (valorSocFamiliar))

		baseCalculoSalarioMedio = (totalSalarios/efetivoTotal).round(2)#divide o total do salario pelo efetivo para fins de calculos em outras formulas
		totalFuncionarios = efetivoTotal/efetivoIndivitual  # total de quantidade de funcionarios (soma quantidade de funcionarios definidos na escala com base na quantidade de postos)
		update_column(:total_funcionarios, (totalFuncionarios))

		###############################################################################################################################################
		## calculos de periculosidade e insalubridade #################################################################################################
		
		totalSalarios = (totalSalarios).round(2) #arredonda o total do salario
		
		valorDePericulosidade = (0.3*salario.to_f).round(2)
		valorDeInsalubridade = (grau_de_insalubridade*select_calculation.salario_minimo.to_f).round(2)
		if (adcional_periculosidade_insalubridade == 1)

			valorPeriOuIsalubri = valorDePericulosidade

		elsif (adcional_periculosidade_insalubridade == 2)

			valorPeriOuIsalubri = valorDeInsalubridade

		elsif (adcional_periculosidade_insalubridade == 0)
				valorPeriOuIsalubri = 0.0
		end

		update_column(:valor_peri_ou_isalubri, (valorPeriOuIsalubri))

		###############################################################################################################################################
		## adicional noturno e vespertino #############################################################################################################
		umTerco = totalFuncionarios / 3
		if (rotation.ad_noturno == 0) # testa quando não tem adicional noturno
			ajusteDivPorZero = 0 # ajuste de divizão por 0
			umTerco = 0 # transforma 1 terço em 0
			doisTerco = totalFuncionarios # pega total de funcionarios para calculo de horas feriados
		else
			ajusteDivPorZero = rotation.ad_noturno / rotation.ad_noturno # correção de erro de divizão por 0
			doisTerco = umTerco * 2 # pega apenas 2 terços quando adicional noturno for diferente de 0 e acrecenta para o calculo de horas extras feriados
		end 
		update_column(:ajuste_div_por_zero,(ajusteDivPorZero))
		update_column(:um_terco,(umTerco))
		update_column(:dois_terco,(doisTerco))

		if ((rotation.period_id == 2) || (rotation.period_id == 4) || (rotation.period_id == 6) || (rotation.period_id == 7))
			
			horas_vespertino = (((rotation.ad_vespertido_noturno*100)/select_calculation.horasDeCalculoAdNoturno).round(4)*rotation.fator_escala).round(4)
			update_column(:horas_vespertino,(horas_vespertino))
			totalHrsAdNoturnoVespertino=((((((baseCalculoSalarioMedio+valorPeriOuIsalubri).round(2)/220))*0.2*
																				horas_vespertino)*((totalFuncionarios/rotation.qtd_funcionarios)))/efetivoTotal).round(2) #adicional noturno vespertino
			update_column(:total_hrs_ad_noturno_vespertino, (totalHrsAdNoturnoVespertino))
		else
			horas_vespertino
			update_column(:horas_vespertino,(horas_vespertino))
			update_column(:total_hrs_ad_noturno_vespertino, (totalHrsAdNoturnoVespertino))
		end

		totalHrsAdNoturno = (((((baseCalculoSalarioMedio + valorPeriOuIsalubri).round(2)/220)) * 0.2 *
													(((ajusteDivPorZero * 60)/select_calculation.horasDeCalculoAdNoturno).round(6) * rotation.fator_escala * rotation.ad_noturno))*
															(totalFuncionarios/rotation.qtd_funcionarios)/efetivoTotal).round(2) #adicional noturno
		if totalHrsAdNoturno == 0
			totalHrsAdNoturno = 0
		else
			totalHrsAdNoturno =totalHrsAdNoturno
		end
		update_column(:total_hrs_ad_noturno, (totalHrsAdNoturno))
		#adVespertidoNoturno = rotation.ad_vespertido_noturno
		#update_column(:ad_vespertido_noturno, (adVespertidoNoturno))

		

		###############################################################################################################################################
		###### Começo dos ifs para hora extra  ########################################################################################################

		hExJornadaAll = 0
		mExJornadaAll = 0
		horasExtras = 0

		if (controle_hora_extra == 0)
			if (h_extra_jornada_all == 0)
				totalHrExtras = 0
				update_column(:total_hr_extras, (totalHrExtras))

			elsif (h_extra_jornada_all == 1)
				if ((dias_jornada_ex_semana_all < 7) && (h_ex_feriado_jornada_all == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
				hExJornadaAll = h_ex_jornada_all.to_f
				mExJornadaAll = m_ex_jornada_all.to_f/60
				if ((hExJornadaAll+mExJornadaAll) > 2)
					hExJornadaAll = 2
					mExJornadaAll = 0
				else
					hExJornadaAll = hExJornadaAll
					mExJornadaAll = mExJornadaAll
				end
				
				if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1
					if (dias_jornada_ex_semana_all > 7)
						diasJornadaExSemanaAll = 7
					else
						diasJornadaExSemanaAll = dias_jornada_ex_semana_all.to_f
					end
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 1) # if usado para tratar quando e Matutino/Vespertino/Noturno
						horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*2+
														calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142875).round(2)
							
					elsif ((rotation.id == 2)||(rotation.id == 3)||(rotation.id == 4))# if usado para tratar quando e Matutino ou Vespertino ou Noturno
						unless (rotation.id == 4)
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)).round(2)
						else
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857).round(2)
						end
					elsif ((rotation.id == 5)||(rotation.id == 6)||(rotation.id == 7)) # if usado para tratar quando e Matutino/Vespertino ou Matutino/Noturno ou Vespertino/Vespertino
						unless (rotation.id  == 6)||(rotation.id  == 7)
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*2).round(2)
						else
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)+
															(calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857)).round(2)
						end
					end
					
				elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
					if (dias_jornada_ex_semana_all >5)
						diasJornadaExSemanaAll = 5
					else
						diasJornadaExSemanaAll = dias_jornada_ex_semana_all.to_f
					end


					if ((dias_jornada_ex_semana_all < 7) && (h_ex_feriado_jornada_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 8) # if usado para tratar quando e Matutino/Noturno
						horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)+
														(calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857)).round(2)

					elsif (rotation.id == 9)||(rotation.id == 10)# if usado para tratar quando e Matutino ou Noturno
						unless (rotation.id == 10)
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)).round(2)
						else
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857).round(2)
						end
					end
				elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
					if (dias_jornada_ex_semana_all > 6)
						diasJornadaExSemanaAll = 6
					else
						diasJornadaExSemanaAll = dias_jornada_ex_semana_all.to_f
					end
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a6
					if (rotation.id == 11)# if usado para tratar quando e Matutino/Noturno
						horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(26.1,6,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)+
														(calculos_proposta.calculo_modelo_de_horas_extras(26.1,6,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857)).round(2)

					elsif (rotation.id == 12)||(rotation.id == 13)# if usado para tratar quando e Matutino ou Noturno
						unless (rotation.id == 13)
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(26.1,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)).round(2)
						else
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(26.1,5,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857).round(2)
						end
					end   
				elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
					if (dias_jornada_ex_semana_all > 7)
						diasJornadaExSemanaAll = 7
					else
						diasJornadaExSemanaAll = dias_jornada_ex_semana_all.to_f
					end
					if (rotation.id == 14) # if usado para tratar quando e Matutino/Noturno
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a7
						horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(15.22,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)+
													(calculos_proposta.calculo_modelo_de_horas_extras(15.22,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)*1.142857)).round(2)

					elsif (rotation.id == 15)||(rotation.id == 16)# if usado para tratar quando e Matutino ou Noturno
						unless (rotation.id == 16)
							horasExtras = (calculos_proposta.calculo_modelo_de_horas_extras(15.22,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll)).round(2)
						else
							horasExtras = ((calculos_proposta.calculo_modelo_de_horas_extras(15.22,7,diasJornadaExSemanaAll,feriadoParcial,qtdPostos,hExJornadaAll,mExJornadaAll))*1.142857).round(2)
						end
					end
				end
			end
		else #(controle_hora_extra == 1)
			# condições de horas para parcial.

		hExJornadaMatu = h_ex_jornada_matu.to_f
		mExJornadaMatu = m_ex_jornada_matu.to_f/60
		if ((hExJornadaMatu+mExJornadaMatu)>= 2)
			hExJornadaMatu = 2
			mExJornadaMatu = 0
		else
			hExJornadaMatu = hExJornadaMatu.to_f
			mExJornadaMatu = mExJornadaMatu.to_f
		end
		hExJornadaVesp = h_ex_jornada_vesp.to_f
		mExJornadaVesp = m_ex_jornada_vesp.to_f/60
		if ((hExJornadaVesp+mExJornadaVesp)>= 2)
			hExJornadaVesp = 2
			mExJornadaVesp = 0
		else
			hExJornadaVesp = hExJornadaVesp
			mExJornadaVesp = mExJornadaVesp
		end
		hExJornadaNotur = h_ex_jornada_notur.to_f
		mExJornadaNotur = m_ex_jornada_notur.to_f/60
		if ((h_ex_jornada_notur+m_ex_jornada_notur)>= 2)
			hExJornadaNotur = 2
			mExJornadaNotur = 0
		else
			hExJornadaNotur = hExJornadaNotur
			mExJornadaNotur = mExJornadaNotur
		end

			#
		if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1

			if (h_extra_jornada_matu == 1)&&((rotation.id == 1)||(rotation.id == 2)||(rotation.id == 5)||(rotation.id == 6))

				if (dias_ex_semana_matu > 7)# teste dias se maior que 7 e tranforma e 7
					ajustePgHoraExMatu = 7
				else
					ajustePgHoraExMatu = dias_ex_semana_matu.to_f
				end

				if ((dias_ex_semana_matu < 7) && (h_ex_feriado_jornada_matu == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end

				# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras1 = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,ajustePgHoraExMatu,feriadoParcial,qtdPostos,hExJornadaMatu,mExJornadaMatu)).round(2)
				#horasExtras1 = (((30.44/7 * ajustePgHoraExMatu)+feriadoParcial)*(qtdPostos)*(hExJornadaVesp+mExJornadaVesp)).round(2)
			else
				horasExtras1 = 0
			end
			if (h_extra_jornada_vesp == 1)&&((rotation.id == 1)||(rotation.id == 3)||(rotation.id == 5)||(rotation.id == 7))

				if (dias_ex_semana_vesp > 7)# teste dias se maior que 7 e tranforma e 7
					ajustePgHoraEXVesp = 7
				else
					ajustePgHoraEXVesp = dias_ex_semana_vesp.to_f
				end

				if ((dias_ex_semana_vesp < 7) && (h_ex_feriado_jornada_vesp == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end

				# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras2 = (calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaVesp,mExJornadaVesp)).round(2)
				#horasExtras2 = (((30.44/7 * ajustePgHoraEXVesp)+feriadoParcial)*(qtdPostos)*(hExJornadaVesp+mExJornadaVesp)).round(2)
			else
				horasExtras2 = 0
			end
			if (h_extra_jornada_notur == 1)&&((rotation.id == 1)||(rotation.id == 4)||(rotation.id == 6)||(rotation.id == 7))

				if (dias_ex_semana_notur > 7)# teste dias se maior que 7 e tranforma e 7
					ajustePgHoraExNotur = 7
				else
					ajustePgHoraExNotur = dias_ex_semana_notur.to_f
				end

				if ((dias_ex_semana_notur < 7) && (h_ex_feriado_jornada_notur == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
				# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras3 = ((calculos_proposta.calculo_modelo_de_horas_extras(30.44,7,ajustePgHoraEXVesp.to_f,feriadoParcial.to_f,qtdPostos,hExJornadaNotur,mExJornadaNotur)*1.142857)).round(2)
				#horasExtras3 = (((30.44/7 * ajustePgHoraExNotur)+feriadoParcial.to_f)*(qtdPostos)*((hExJornadaNotur+mExJornadaNotur)*1.142857)).round(2)
			else
				horasExtras3 = 0
			end

			horasExtras = horasExtras1+horasExtras2+horasExtras3
		elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
			if (h_extra_jornada_matu == 1)&&((rotation.id == 8)||(rotation.id == 9))
				if (dias_ex_semana_matu > 5)
					ajustePgHoraExMatu = 5
				else
					ajustePgHoraExMatu = dias_ex_semana_matu.to_f
				end

				if ((dias_ex_semana_matu < 6) && (h_ex_feriado_jornada_matu == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras1 = (calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaNotur,mExJornadaNotur)).round(2)
				#horasExtras1 = (((21.75/5 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*(hExJornadaMatu+mExJornadaMatu)).round(2)
				#((4.35*dias_ex_semana_matu)+h_ex_feriado_jornada_matu.to_f)*controleValorFuncionario.to_f
			else
				horasExtras1 = 0
			end

			if (vr_notur == 1)&&((rotation.id == 8)||(rotation.id == 10))

				if (dias_ex_semana_notur > 5)
					ajustePgHoraExNotur = 5
				else
					ajustePgHoraExNotur = dias_ex_semana_notur.to_f
				end

				if ((dias_ex_semana_notur < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
				horasExtras3 = ((calculos_proposta.calculo_modelo_de_horas_extras(21.75,5,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaNotur,mExJornadaNotur)*1.142857)).round(2)
				#horasExtras3 = (((21.75/5 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*((hExJornadaNotur+mExJornadaNotur)*1.142857)).round(2)
			else
				horasExtras3 = 0
			end
			horasExtras = horasExtras1+horasExtras3
		elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
			if (h_extra_jornada_matu == 1)&&((rotation.id == 11)||(rotation.id == 12))
				if (dias_ex_semana_matu > 6)
					ajustePgHoraExMatu = 6
				else
					ajustePgHoraExMatu = dias_ex_semana_matu.to_f
				end

				if ((dias_ex_semana_matu < 6) && (h_ex_feriado_jornada_matu == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras1 = (calculos_proposta.calculo_modelo_de_horas_extras(26.1,6,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaNotur,mExJornadaNotur)).round(2)
				#horasExtras1 = (((26.1/6 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*(hExJornadaMatu+mExJornadaMatu)).round(2)
			else
				horasExtras1 = 0
			end

			if (vr_notur == 1)&&((rotation.id == 11)||(rotation.id == 13))
				if (dias_pg_vr_semana_notur > 6)
					ajustePgHoraExNotur = 6
				else
					ajustePgHoraExNotur = dias_pg_vr_semana_notur.to_f
				end

				if ((dias_ex_semana_matu < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
				horasExtras3 = ((calculos_proposta.calculo_modelo_de_horas_extras(26.1,6,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaNotur,mExJornadaNotur)*1.142857)).round(2)
				# horasExtras3 = (((26.1/6 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*((hExJornadaNotur+mExJornadaNotur)*1.142857)).round(2)
			else
				horasExtras3 = 0
			end
			horasExtras = horasExtras1+horasExtras3
		elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
			if (h_extra_jornada_matu == 1)&&((rotation.id == 14)||(rotation.id == 15))
				if (dias_ex_semana_matu > 7)
					ajustePgHoraExMatu = 7
				else
					ajustePgHoraExMatu = dias_ex_semana_matu.to_f
				end

				if ((dias_ex_semana_matu < 6) && (h_ex_feriado_jornada_matu == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
				horasExtras1 = (((15.22/7 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*(hExJornadaMatu+mExJornadaMatu)).round(2)
					# ((4.35*dias_ex_semana_matu)+h_ex_feriado_jornada_matu)*controleValorFuncionario
			else
				horasExtras1 = 0
			end
			if (vr_notur == 1)&&((rotation.id == 14)||(rotation.id == 16))
				if (dias_pg_vr_semana_notur > 7)
					ajustePgHoraExNotur = 7
				else
					ajustePgHoraExNotur = dias_pg_vr_semana_notur.to_f
				end

				if ((dias_ex_semana_matu < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
					feriadoParcial = (city.feriado/12)
				else	
					feriadoParcial = 0
				end
				horasExtras3 = ((calculos_proposta.calculo_modelo_de_horas_extras(15.22,7,ajustePgHoraEXVesp,feriadoParcial,qtdPostos,hExJornadaNotur,mExJornadaNotur)*1.142857)).round(2)

				# horasExtras3 = (((15.22/7 * ajustePgHoraExNotur)+feriadoParcial)*(qtdPostos)*((hExJornadaNotur+mExJornadaNotur)*1.142857)).round(2)
			else
				horasExtras3 = 0
			end
			horasExtras = horasExtras1+horasExtras3
			end
		end
		update_column(:horas_extras, (horasExtras))

		###############################################################################################################################################
		## calculos horas extras ######################################################################################################################
		# Condicional criada para testar se a hora de almço é calculada 
		if ((h_extra_jornada_all+h_extra_jornada_matu+h_extra_jornada_vesp+h_extra_jornada_notur) == 0)  
			totalHrExtras = 0
			update_column(:total_hr_extras, (totalHrExtras))
		else
			totalHrExtras = (((((baseCalculoSalarioMedio+valorPeriOuIsalubri+totalHrsAdNoturnoVespertino+totalHrsAdNoturno)/220)*1.6)*
												horasExtras)/efetivoTotal).round(2)
		 #o calculo a cima é para calcular a cobrança de horas em extras de almoço (calculo de horas extras a mais é calculado de forma diferente)
			update_column(:total_hr_extras, (totalHrExtras))
		end

		vFeriadosDeCitiesMV = (city.feriado*0.6108) #Valor de feriado para carga horaia de matutino vespertino
			update_column(:valor_feriados_de_cities_mv, (vFeriadosDeCitiesMV))

		vFeriadosDeCitiesN = (city.feriado*0.666) #Valor de feriado para carga horaia de matutino vespertino
			update_column(:valor_feriados_de_cities_n, (vFeriadosDeCitiesN))

		if (h_feriado == 1)
			totalHrExtrasFeriado = (((baseCalculoSalarioMedio+valorPeriOuIsalubri+totalHrsAdNoturnoVespertino+totalHrsAdNoturno)/220)*
															((vFeriadosDeCitiesMV*doisTerco)+(vFeriadosDeCitiesN*umTerco)).round(2)/(efetivoTotal)).round(2)
			if totalHrExtrasFeriado == 0
				totalHrExtrasFeriado = 0
			end
			update_column(:total_hr_extras_feriado, (totalHrExtrasFeriado))
		elsif (h_feriado == 0)
			umTerco = 0.0
			doisTerco = 0.0
			totalHrExtrasFeriado = 0.0
			update_column(:total_hr_extras_feriado, (totalHrExtrasFeriado))
		end

		# Calculo para definir o valor de horas extras feriados feito apartir de horas trabalhadas dia pelas quantidade de feriados
		refexoDSR = ((totalHrsAdNoturnoVespertino + totalHrsAdNoturno + totalHrExtras + totalHrExtrasFeriado)/25.09*5.35).round(2)
		teste1 =totalHrsAdNoturnoVespertino
		teste2 =totalHrsAdNoturno
		teste3 =totalHrExtras
		teste4 =totalHrExtrasFeriado
		update_column(:refexo_dsr, (refexoDSR))
		salarioMedioFinal = (baseCalculoSalarioMedio+valorPeriOuIsalubri+totalHrsAdNoturnoVespertino+ totalHrsAdNoturno+ totalHrExtras+ totalHrExtrasFeriado+refexoDSR).round(2)
		if salarioMedioFinal == 0
			salarioMedioFinal = 0
		end
		update_column(:salario_medio_final, (salarioMedioFinal))
		massaSalarial = (salarioMedioFinal*efetivoTotal).round(2)
		update_column(:massa_salarial, (massaSalarial))
 
		###############################################################################################################################################
		## > Obrigações sociais sobre massa salarial ##################################################################################################
		###############################################################################################################################################


		obgFGTS = ((select_calculation.fgts/100)*massaSalarial).round(2)
		obgINSS = ((select_calculation.inss/100)*massaSalarial).round(2)
		seguro_aci_trabalho = (company.seguro_aci_trabalho)
		obgseguro_aci_trabalho = ((company.seguro_aci_trabalho/100)*massaSalarial).round(2)
		obgsebrae = ((select_calculation.sebrae/100)*massaSalarial).round(2)
		obgincra = ((select_calculation.incra/100)*massaSalarial).round(2)
		obgsalario_educacao = ((select_calculation.salario_educacao/100)*massaSalarial).round(2)
		obgsesc = ((select_calculation.sesc/100)*massaSalarial).round(2)
		obgsenac = ((select_calculation.senac/100)*massaSalarial).round(2)
		update_column(:obg_fgts, (obgFGTS))
		update_column(:obg_inss, (obgINSS))
		update_column(:seguro_aci_trabalho, (seguro_aci_trabalho))
		update_column(:obgseguro_aci_trabalho, (obgseguro_aci_trabalho))
		update_column(:obg_sebrae, (obgsebrae))
		update_column(:obg_incra, (obgincra))
		update_column(:obg_salario_educacao, (obgsalario_educacao))
		update_column(:obg_sesc, (obgsesc))
		update_column(:obg_senac, (obgsenac))

		totalIncargosDiretos = (obgFGTS+obgINSS+obgseguro_aci_trabalho+obgsebrae+obgincra+obgsalario_educacao+obgsesc+obgsenac).round(2)
		update_column(:total_incargos_diretos, (totalIncargosDiretos))

		###############################################################################################################################################
		## >  Provisões sobre massa salarial ##########################################################################################################
		###############################################################################################################################################

		
		totalferiasUmDozeAvos = ((efetivoTotal*salarioMedioFinal)*((select_calculation.ferias)/100)).round(2)
		totalumTercoConstiUmDozeAvos =((efetivoTotal*salarioMedioFinal)*((select_calculation.um_terco_constitucional)/100)).round(2)
		totaldecimoTerceiroUmDozeAvos = ((efetivoTotal*salarioMedioFinal)*((select_calculation.decimo_terceito)/100)).round(2)
		totalInssSobFeriasUnTercoDecimo = ((totalferiasUmDozeAvos+totalumTercoConstiUmDozeAvos+totaldecimoTerceiroUmDozeAvos)*(select_calculation.pct_inss_sob_soma_decimo_um_terco_ferias/100)).round(2)
		totalFgtsSobFeriasUnTercoDecimo = ((totalferiasUmDozeAvos+totalumTercoConstiUmDozeAvos+totaldecimoTerceiroUmDozeAvos)*(select_calculation.pct_fgts_sob_soma_decimo_um_terco_ferias/100)).round(2)
		totalAvisoPrevio = ((select_calculation.aviso_previo/100)*massaSalarial).round(2)
		totalIndenizacaoSobreFGTS = ((totalFgtsSobFeriasUnTercoDecimo+obgFGTS)*(select_calculation.indenizacao_fgts/100)).round(2)


		totalProvisaoMassaSalarial = (totalferiasUmDozeAvos+totalumTercoConstiUmDozeAvos+totaldecimoTerceiroUmDozeAvos+
																		totalInssSobFeriasUnTercoDecimo+totalFgtsSobFeriasUnTercoDecimo+totalAvisoPrevio+totalIndenizacaoSobreFGTS ).round(2)

		update_column(:total_ferias_um_doze_avos, (totalferiasUmDozeAvos))
		update_column(:total_um_terco_consti_um_doze_avos, (totalumTercoConstiUmDozeAvos))
		update_column(:total_decimo_terceiro_um_doze_avos, (totaldecimoTerceiroUmDozeAvos))
		update_column(:total_inss_sob_ferias_um_terco_decimo, (totalInssSobFeriasUnTercoDecimo))
		update_column(:total_fgts_sob_ferias_Um_terco_decimo, (totalFgtsSobFeriasUnTercoDecimo))
		update_column(:total_aviso_previo, (totalAvisoPrevio))
		update_column(:total_indenizacao_sobre_fgts, (totalIndenizacaoSobreFGTS))
		update_column(:total_provisao_massa_salarial, (totalProvisaoMassaSalarial))  


		###############################################################################################################################################
		## > Benefícios por Funcionário  ##############################################################################################################
		###############################################################################################################################################

		totCesta = (valorCesta*efetivoTotal).round(2)
######################colar aqui
		controleDePostosParaCalculoVt = 0
		if umTerco == 0
			controleValorFuncionario = efetivoIndivitual*qtdPostos
			controleValorFuncionarioSemEfetivo = qtdPostos
		end

		if (controle_vr == 0)
			if (vr_all == 0)
				qtdVrPagas = 0
			elsif (vr_all == 1)
				if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1
					if (dias_pg_vr_semana_all > 7)
						ajustePgVrAll = 7
					else
						ajustePgVrAll = dias_pg_vr_semana_all.to_f
					end
					if ((dias_pg_vr_semana_all < 7) && (dias_pg_vr_feriado_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 1) # if usado para tratar quando e Matutino/Vespertino/Noturno
								qtdVrPagas = (((30.44/7 *ajustePgVrAll)+feriadoParcial)*(qtdPostos))*3

					elsif ((rotation.id == 2)||(rotation.id == 3)||(rotation.id == 4))# if usado para tratar quando e Matutino ou Vespertino ou Noturno
								qtdVrPagas = ((30.44/7 *ajustePgVrAll)+feriadoParcial)*(qtdPostos)

					elsif ((rotation.id == 5)||(rotation.id == 6)||(rotation.id == 7)) # if usado para tratar quando e Matutino/Vespertino ou Matutino/Noturno ou Vespertino/Vespertino
								qtdVrPagas = (((30.44/7 *ajustePgVrAll)+feriadoParcial)*(qtdPostos))*2
					end

				elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
					if (dias_pg_vr_semana_all > 5)
						ajustePgVrAll = 5
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVrAll = dias_pg_vr_semana_all.to_f
						feriadoParcial = 0
					end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 8) # if usado para tratar quando e Matutino/Noturno
								qtdVrPagas = ((21.75/5 *diasJornadaExSemanaAll)+feriadoParcial)*(qtdPostos)*(hExJornadaAll+hExJornadaAll)+
															((21.75/5 *ajustePgVrAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
					elsif (rotation.id == 9)||(rotation.id == 10)# if usado para tratar quando e Matutino ou Noturno
								qtdVrPagas = ((21.75/5 *ajustePgVrAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
					end
				elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
					if dias_pg_vr_semana_all > 6
						ajustePgVrAll = 6
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVrAll = dias_pg_vr_semana_all.to_f
						feriadoParcial = 0
					end
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a6
					if (rotation.id == 11)# if usado para tratar quando e Matutino/Noturno
						qtdVrPagas = ((26.1/6 *ajustePgVrAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)+
													((26.1/6 *ajustePgVrAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
					elsif (rotation.id == 12)||(rotation.id == 13)# if usado para tratar quando e Matutino ou Noturno
						qtdVrPagas = ((26.1/6 *ajustePgVrAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
					end   
				elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
					if (dias_pg_vr_semana_all >= 6)
						ajustePgVrAll = 6
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVrAll = dias_pg_vr_semana_all.to_f
						feriadoParcial = 0
					end
					if (rotation.id == 14) # if usado para tratar quando e Matutino/Noturno
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a7
							qtdVrPagas = ((15.22/7 *ajustePgVrAll)+feriadoParcial)*(controleValorFuncionario)+
														((15.22/7 *ajustePgVrAll)+feriadoParcial)*(controleValorFuncionario)
					elsif (rotation.id == 15)||(rotation.id == 16)# if usado para tratar quando e Matutino ou Noturno
							qtdVrPagas = ((15.22/7 *ajustePgVrAll)+feriadoParcial)*(controleValorFuncionario)
					end
				end
			end
		else #(controle_vr == 1)

			if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1
				if (vr_matu == 1)&&((rotation.id == 1)||(rotation.id == 2)||(rotation.id == 5)||(rotation.id == 6))

					if (dias_pg_vr_semana_matu > 7)# teste dias se maior que 7 e tranforma e 7
						ajustePgVrMatu = 7
					else
						ajustePgVrMatu = dias_pg_vr_semana_matu.to_f
					end

					if ((dias_pg_vr_semana_matu < 7) && (dias_pg_vr_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVrPagas1 = ((30.44/7 *ajustePgVrMatu)+(feriadoParcial).round(2))*(qtdPostos)
				else
					qtdVrPagas1 = 0
				end
				if (vr_vesp == 1)&&((rotation.id == 1)||(rotation.id == 3)||(rotation.id == 5)||(rotation.id == 7))

					if (dias_pg_vr_semana_vesp > 7) # teste dias se maior que 7 e tranforma e 7
						ajustePgVrVesp = 7
					else
						ajustePgVrVesp = dias_pg_vr_semana_vesp.to_f
					end

					if ((dias_pg_vr_semana_matu < 7) && (dias_pg_vr_feriado_vesp == 1)) # teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					qtdVrPagas2 = ((30.44/7 *ajustePgVrVesp.to_f)+feriadoParcial)*(qtdPostos.to_f)
				else
					qtdVrPagas2 = 0   
				end
				if (vr_notur == 1)&&((rotation.id == 1)||(rotation.id == 4)||(rotation.id == 6)||(rotation.id == 7))

					if (dias_pg_vr_semana_notur > 7)# teste dias se maior que 7 e tranforma e 7
						ajustePgVrNotur = 7
					else
						ajustePgVrNotur = dias_pg_vr_semana_notur.to_f
					end

					if ((dias_pg_vr_semana_matu < 7) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

						qtdVrPagas3 = ((30.44/7 *ajustePgVrNotur.to_f)+feriadoParcial)*(qtdPostos.to_f)
				else
					qtdVrPagas3 = 0
				end
					qtdVrPagas = qtdVrPagas1+qtdVrPagas2+qtdVrPagas3
			elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
				if (vr_matu == 1)&&((rotation.id == 8)||(rotation.id == 9))
					if (dias_pg_vr_semana_matu > 5)
						ajustePgVrMatu = 5
					else
						ajustePgVrMatu = dias_pg_vr_semana_matu.to_f
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
							# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVrPagas1 = ((21.75/5 *ajustePgVrMatu.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
						#((4.35*dias_pg_vr_semana_matu)+dias_pg_vr_feriado_matu.to_f)*controleValorFuncionario.to_f
				else
					qtdVrPagas1 = 0
				end

				if (vr_notur == 1)&&((rotation.id == 8)||(rotation.id == 10))

					if (dias_pg_vr_semana_notur > 5)
						ajustePgVrNotur = 5
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVrNotur = dias_pg_vr_semana_notur.to_f
						feriadoParcial = 0
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					qtdVrPagas3 = ((21.75/5 *ajustePgVrNotur.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVrPagas3 = 0
				end
				qtdVrPagas = qtdVrPagas1+qtdVrPagas3
			elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
				if (vr_matu == 1)&&((rotation.id == 11)||(rotation.id == 12))
					if (dias_pg_vr_semana_matu > 6)
						ajustePgVrMatu = 6
					else
						ajustePgVrMatu = dias_pg_vr_semana_matu.to_f
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVrPagas1 = ((26.1/6 *ajustePgVrMatu.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVrPagas1 = 0
				end

				if (vr_notur == 1)&&((rotation.id == 11)||(rotation.id == 13))
					if (dias_pg_vr_semana_notur > 6)
						ajustePgVrNotur = 6
					else
						ajustePgVrNotur = dias_pg_vr_semana_notur.to_f
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					qtdVrPagas3 = ((26.1/6 *ajustePgVrNotur.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVrPagas3 = 0
				end
				qtdVrPagas = qtdVrPagas1+qtdVrPagas3
			elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
				if (vr_matu == 1)&&((rotation.id == 14)||(rotation.id == 15))
					if (dias_pg_vr_semana_matu > 7)
						ajustePgVrMatu = 7
					else
						ajustePgVrMatu = dias_pg_vr_semana_matu.to_f
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVrPagas1 = (15.22/7 *ajustePgVrMatu)*(controleValorFuncionario)
						#((4.35*dias_pg_vr_semana_matu)+dias_pg_vr_feriado_matu)*controleValorFuncionario
				else
					qtdVrPagas1 = 0
				end
				if (vr_notur == 1)&&((rotation.id == 14)||(rotation.id == 16))
					if (dias_pg_vr_semana_notur > 7)
						ajustePgVrNotur = 7
					else
						ajustePgVrNotur = dias_pg_vr_semana_notur.to_f
					end

					if ((dias_pg_vr_semana_matu < 6) && (dias_pg_vr_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					qtdVrPagas3 = (15.22/7 *ajustePgVrNotur)*(controleValorFuncionario)
				else
					qtdVrPagas3 = 0
				end
				qtdVrPagas = qtdVrPagas1+qtdVrPagas3
			end# fim do if que trata escala
		end

		update_column(:qtd_vr_pagas, (qtdVrPagas))

		if (descontoVr == 0.13)
			multiplicador = 0.0
			multiplicador = (((qtdVrPagas).round(2))+(efetivoTotal*(0.08333))).round(2) 
			totVR = ( multiplicador * (vUniVR-descontoVr)).round(2)

			totSocialFamiliar = (efetivoTotal*valorSocFamiliar).round(2) 
			totBenNatalidade = (efetivoTotal*valorBenNatalidade).round(2) 


			update_column(:multiplicador, (multiplicador))
			update_column(:tot_social_familiar, (totSocialFamiliar))
			update_column(:tot_ben_natalidade, (totBenNatalidade))

		else
			multiplicador = (qtdVrPagas).round(2)
			totVR = (multiplicador * (vUniVR*descontoVr)).round(1)
			update_column(:multiplicador, (multiplicador).round(1))
			update_column(:tot_social_familiar, (totSocialFamiliar))
			update_column(:tot_ben_natalidade, (totBenNatalidade))
		end
		if (vUniAssistMedica == 0)
			totAssiteciaMedica = 0
		else
			totAssiteciaMedica = ((vUniAssistMedica*efetivoTotal)-((salario*0.05)*efetivoTotal)).round(2)   
		end

		if (controle_vt == 0)
			if (vt_all == 0)
				qtdVtPagas = 0
			elsif (vt_all == 1)
				if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1
					if (dias_pg_vt_semana_all > 7)
						ajustePgVtAll = 7
					else
						ajustePgVtAll = dias_pg_vt_semana_all.to_f
					end
					if ((dias_pg_vt_semana_all < 7) && (dias_pg_vt_feriado_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 1) # if usado para tratar quando e Matutino/Vespertino/Noturno
								qtdVtPagas = ((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)+
															((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)+
																((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)
						controleDePostosParaCalculoVt = qtdPostos*3
					elsif ((rotation.id == 2)||(rotation.id == 3)||(rotation.id == 4))# if usado para tratar quando e Matutino ou Vespertino ou Noturno
								qtdVtPagas = ((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)
						controleDePostosParaCalculoVt = qtdPostos
					elsif ((rotation.id == 5)||(rotation.id == 6)||(rotation.id == 7)) # if usado para tratar quando e Matutino/Vespertino ou Matutino/Noturno ou Vespertino/Vespertino
								qtdVtPagas = ((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)+
															((30.44/7 *ajustePgVtAll)+feriadoParcial)*(qtdPostos)
						controleDePostosParaCalculoVt = qtdPostos*2
					end
				elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
					if (dias_pg_vt_semana_all > 5)
						ajustePgVtAll = 5
					else
						ajustePgVtAll = dias_pg_vt_semana_all.to_f
					end

					if ((dias_pg_vt_semana_all < 7) && (dias_pg_vt_feriado_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					if (rotation.id == 8) # if usado para tratar quando e Matutino/Noturno
								qtdVtPagas = ((21.75/5 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)+
															((21.75/5 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
						controleDePostosParaCalculoVt = qtdPostos*2
					elsif (rotation.id == 9)||(rotation.id == 10)# if usado para tratar quando e Matutino ou Noturno
								qtdVtPagas = ((21.75/5 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
						controleDePostosParaCalculoVt = qtdPostos
					end
				elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
					if dias_pg_vt_semana_all > 6
						ajustePgVtAll = 6
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVtAll = dias_pg_vt_semana_all.to_f
						feriadoParcial = 0
					end
					if ((dias_pg_vt_semana_matu < 7) && (dias_pg_vt_feriado_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a6
					if (rotation.id == 11)# if usado para tratar quando e Matutino/Noturno
						qtdVtPagas = ((26.1/6 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)+
													((26.1/6 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
						controleDePostosParaCalculoVt = qtdPostos*2
					elsif (rotation.id == 12)||(rotation.id == 13)# if usado para tratar quando e Matutino ou Noturno
						qtdVtPagas = ((26.1/6 *ajustePgVtAll.to_f)+feriadoParcial)*(controleValorFuncionario.to_f)
						controleDePostosParaCalculoVt = qtdPostos
					end   
				elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
					if (dias_pg_vt_semana_all >= 6)
						ajustePgVtAll = 6
					else
						ajustePgVtAll = dias_pg_vt_semana_all.to_f
					end

					if ((dias_pg_vt_semana_matu < 7) && (dias_pg_vt_feriado_all == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					if (rotation.id == 14) # if usado para tratar quando e Matutino/Noturno
					# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a7
							qtdVtPagas = ((15.22/7 *ajustePgVtAll)+feriadoParcial)*(controleValorFuncionario)+
														((15.22/7 *ajustePgVtAll)+feriadoParcial)*(controleValorFuncionario)
						controleDePostosParaCalculoVt = qtdPostos*2
					elsif (rotation.id == 15)||(rotation.id == 16)# if usado para tratar quando e Matutino ou Noturno
							qtdVtPagas = ((15.22/7 *ajustePgVtAll)+feriadoParcial)*(controleValorFuncionario)
					end
				end
			end
		else #(controle_vt == 1)

			if (rotation.dias_trabalhados == 25.3646)  #if que trata escala 5 por 1
				if (vt_matu == 1)&&((rotation.id == 1)||(rotation.id == 2)||(rotation.id == 5)||(rotation.id == 6))

					if (dias_pg_vt_semana_matu > 7)# teste dias se maior que 7 e tranforma e 7
						ajustePgVtMatu = 7
					else
						ajustePgVtMatu = dias_pg_vt_semana_matu.to_f
					end

					if ((dias_pg_vt_semana_matu < 7) && (dias_pg_vt_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVtPagas1 = ((30.44/7 *ajustePgVtMatu)+(feriadoParcial).round(2))*(qtdPostos)
				else
					qtdVtPagas1 = 0
				end
				if (vt_vesp == 1)&&((rotation.id == 1)||(rotation.id == 3)||(rotation.id == 5)||(rotation.id == 7))

					if (dias_pg_vt_semana_vesp > 7) # teste dias se maior que 7 e tranforma e 7
						ajustePgVtVesp = 7
					else
						ajustePgVtVesp = dias_pg_vt_semana_vesp.to_f
					end

					if ((dias_pg_vt_semana_matu < 7) && (dias_pg_vt_feriado_vesp == 1)) # teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					qtdVtPagas2 = ((30.44/7 *ajustePgVtVesp.to_f)+feriadoParcial)*(qtdPostos.to_f)
				else
					qtdVtPagas2 = 0   
				end
				if (vt_notur == 1)&&((rotation.id == 1)||(rotation.id == 4)||(rotation.id == 6)||(rotation.id == 7))

					if (dias_pg_vt_semana_notur > 7)# teste dias se maior que 7 e tranforma e 7
						ajustePgVtNotur = 7
					else
						ajustePgVtNotur = dias_pg_vt_semana_notur.to_f
					end

					if ((dias_pg_vt_semana_matu < 7) && (dias_pg_vt_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					qtdVtPagas3 = ((30.44/7 *ajustePgVtNotur.to_f)+feriadoParcial)*(qtdPostos.to_f)
				else
					qtdVtPagas3 = 0
				end
				if (qtdVtPagas1 != 0)
					mut = 1
				elsif (qtdVtPagas2 != 0)
					mut = 2
				elsif (qtdVtPagas3 != 0)
					mut = 3
				end
				controleDePostosParaCalculoVt = qtdPostos.to_f*mut.to_f
				qtdVtPagas = qtdVtPagas1+qtdVtPagas2+qtdVtPagas3
			elsif (rotation.dias_trabalhados == 21.75)  #if que trata escala 5 por 2
				if (vt_matu == 1)&&((rotation.id == 8)||(rotation.id == 9))
					if (dias_pg_vt_semana_matu > 5)
						ajustePgVtMatu = 5
					else
						ajustePgVtMatu = dias_pg_vt_semana_matu.to_f
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
							# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVtPagas1 = ((21.75/5 *ajustePgVtMatu.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
						#((4.35*dias_pg_vt_semana_matu)+dias_pg_vt_feriado_matu.to_f)*controleValorFuncionario.to_f
				else
					qtdVtPagas1 = 0
				end

				if (vt_notur == 1)&&((rotation.id == 8)||(rotation.id == 10))

					if (dias_pg_vt_semana_notur > 5)
						ajustePgVtNotur = 5
						feriadoParcial = (city.feriado/12)
					else
						ajustePgVtNotur = dias_pg_vt_semana_notur.to_f
						feriadoParcial = 0
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					qtdVtPagas3 = ((21.75/5 *ajustePgVtNotur.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVtPagas3 = 0
				end
				if (qtdVtPagas1 != 0)
					mut = 1
				elsif (qtdVtPagas3 != 0)
					mut = 2
				end
				controleDePostosParaCalculoVt = qtdPostos*mut
				qtdVtPagas = qtdVtPagas1+qtdVtPagas3
			elsif (rotation.dias_trabalhados == 26.1)  #if que trata escala 6 por 1
				if (vt_matu == 1)&&((rotation.id == 11)||(rotation.id == 12))
					if (dias_pg_vt_semana_matu > 6)
						ajustePgVtMatu = 6
					else
						ajustePgVtMatu = dias_pg_vt_semana_matu.to_f
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVtPagas1 = ((26.1/6 *ajustePgVtMatu.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVtPagas1 = 0
				end

				if (vt_notur == 1)&&((rotation.id == 11)||(rotation.id == 13))
					if (dias_pg_vt_semana_notur > 6)
						ajustePgVtNotur = 6
					else
						ajustePgVtNotur = dias_pg_vt_semana_notur.to_f
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end
					qtdVtPagas3 = ((26.1/6 *ajustePgVtNotur.to_f)+(feriadoParcial).round(2))*(controleValorFuncionario.to_f)
				else
					qtdVtPagas3 = 0
				end
				if (qtdVtPagas1 != 0)
					mut = 1
				elsif (qtdVtPagas3 != 0)
					mut = 2
				end
				controleDePostosParaCalculoVt = qtdPostos*mut
				qtdVtPagas = qtdVtPagas1+qtdVtPagas3
			elsif (rotation.dias_trabalhados == 15.22)  #if que trata escala 12 X 36
				if (vt_matu == 1)&&((rotation.id == 14)||(rotation.id == 15))
					if (dias_pg_vt_semana_matu > 7)
						ajustePgVtMatu = 7
					else
						ajustePgVtMatu = dias_pg_vt_semana_matu.to_f
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_matu == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

						# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
					qtdVtPagas1 = (15.22/7 *ajustePgVtMatu)*(controleValorFuncionario)
						#((4.35*dias_pg_vt_semana_matu)+dias_pg_vt_feriado_matu)*controleValorFuncionario
				else
					qtdVtPagas1 = 0
				end
				if (vt_notur == 1)&&((rotation.id == 14)||(rotation.id == 16))
					if (dias_pg_vt_semana_notur > 7)
						ajustePgVtNotur = 7
					else
						ajustePgVtNotur = dias_pg_vt_semana_notur.to_f
					end

					if ((dias_pg_vt_semana_matu < 6) && (dias_pg_vt_feriado_notur == 1))# teste dias se menor que 7 para calcular feriado
						feriadoParcial = (city.feriado/12)
					else	
						feriadoParcial = 0
					end

					qtdVtPagas3 = (15.22/7 *ajustePgVtNotur)*(controleValorFuncionario)
				else
					qtdVtPagas3 = 0
				end
				if (qtdVtPagas1 != 0)
					mut = 1
				elsif (qtdVtPagas3 != 0)
					mut = 2
				end
				controleDePostosParaCalculoVt = qtdPostos*mut
				qtdVtPagas = (qtdVtPagas1+qtdVtPagas3)
			end# fim do if que trata escala
		end
		update_column(:qtd_vt_pagas, (qtdVtPagas))

		if (intermunicipal == 0 || intermunicipal.nil?)
			valorPassagem = city.valeTransporte
		else
			valorPassagem = intermunicipal
		end

		update_column(:valor_passagem, (valorPassagem))

		totSeguroVida = (vUniSegVida*efetivoTotal).round(2)
		totVT = ((valorPassagem*((qtdVtPagas)*2))-((salario*(controleDePostosParaCalculoVt*efetivoIndivitual).round(2))*0.06)).round(2)
		
		if totVT < 0
			totVT = 0
		end
		
		if (company.id == 1)
			totReciclagem = (rotation.v_reciclagem*efetivoTotal).round(2)
		else
			totReciclagem = 0.0
		end    
		if (company.id == 2)
			totPpr = ((vUniPpr*efetivoTotal)/12).round(2)
		else
			totPpr = 0.0
		end  
		totUniforme = (vUniUniforme*efetivoTotal).round(2)

		totBeneficios =(totCesta+totVR+totAssiteciaMedica+totSeguroVida+totVT+totReciclagem+totUniforme+totPpr+totSocialFamiliar+totBenNatalidade).round(2)

		update_column(:total_cesta, (totCesta))
		update_column(:total_vr, (totVR))
		update_column(:total_assitecia_medica, (totAssiteciaMedica))
		update_column(:total_seguro_vida, (totSeguroVida))
		update_column(:total_vt, (totVT))
		update_column(:total_reciclagem, (totReciclagem))
		update_column(:total_ppr, (totPpr))
		update_column(:total_uniforme, (totUniforme))
		update_column(:total_beneficios, (totBeneficios))



		###############################################################################################################################################
		## > total mão de obra  #######################################################################################################################
		###############################################################################################################################################

		totMaoDeObraParcial = massaSalarial+totalIncargosDiretos+totalProvisaoMassaSalarial+totBeneficios
		reservaTecnicaOld = 0
		reservaTecnicaOld = (totMaoDeObraParcial/(1-(company.pct_reserva_tecnica)/100)-totMaoDeObraParcial).round(2)
		reservaTecnicaOld = 0 # mudar para opções de old caso use o normal
		update_column(:reserva_tecnica_old,(reservaTecnicaOld))
		totMaoDeObra = totMaoDeObraParcial+reservaTecnicaOld
		update_column(:total_mao_de_obra,(totMaoDeObra))
		

		###############################################################################################################################################
		## > Administração e Operação #################################################################################################################
		###############################################################################################################################################
		###############################################################################################################################################
		## > total de tudo sem o que tem porcentagem referencia circular na tabela  ###################################################################
		###############################################################################################################################################

		totParcialProposta = totMaoDeObra + totalEquipamento
		update_column(:tot_parcial_proposta,(totParcialProposta))



		###############################################################################################################################################
		## > calculo total mais lucro #################################################################################################################
		pctTotal = (company.pis*(1-(city.issqn/100)))+company.cofins*(1-(city.issqn/100))+company.csll+company.irrf+city.issqn+select_calculation.indiceAdministrativo+select_calculation.indiceOperacional+company.pct_reserva_tecnica
		update_column(:pct_total,(pctTotal))

		pctTotalAlicota = totParcialProposta/(1-((pctTotal)/100))-totParcialProposta
		update_column(:pct_total_alicota,(pctTotalAlicota))

		vDeCalculoTotal = pctTotalAlicota+totParcialProposta  #####-> valor total de mão de obra <-#####
		update_column(:valor_de_calculo_total,(vDeCalculoTotal))
		
		
		valorIndiceOperacional = pctTotalAlicota*select_calculation.indiceOperacional/pctTotal
		update_column(:valor_indice_operacional,(valorIndiceOperacional))

		###############################################################################################################################################
		## > lucro ####################################################################################################################################

		valorIndiceAdministrativo = pctTotalAlicota*select_calculation.indiceAdministrativo/pctTotal
		update_column(:valor_indice_administrativo,(valorIndiceAdministrativo))
		reservaTecnica = 0
		reservaTecnica = pctTotalAlicota*company.pct_reserva_tecnica/pctTotal
		update_column(:reserva_tecnica,(reservaTecnica))	
		
		###############################################################################################################################################
		## > Impotos  #################################################################################################################################
		###############################################################################################################################################
		valorIssqn = pctTotalAlicota*city.issqn/pctTotal
		update_column(:valor_issqn,(valorIssqn))

		valorPis = pctTotalAlicota*company.pis*(1-(city.issqn/100))/pctTotal
		valorCofins = pctTotalAlicota*company.cofins*(1-(city.issqn/100))/pctTotal
		valorCsll = pctTotalAlicota*company.csll/pctTotal
		valorIrrf = pctTotalAlicota*company.irrf/pctTotal
		update_column(:valor_pis,(valorPis))
		update_column(:valor_cofins,(valorCofins))
		update_column(:valor_csll,(valorCsll))
		update_column(:valor_irrf,(valorIrrf))
		
		## Total impostos sobre serviços ###

		totImpostoSobServico = valorIndiceOperacional+valorIndiceAdministrativo+valorPis+valorCofins+valorCsll+valorIrrf+valorIssqn+totalEquipamento+reservaTecnica
		update_column(:total_imposto_sob_servico,(totImpostoSobServico))

		update_column(:teste1, (teste1))
		update_column(:teste2, (teste2))
		update_column(:teste3, (teste3))
		update_column(:teste4, (teste4))
		update_column(:teste5, (teste5))
	end  
end
