@vA=0,@totalEquipamento=0.0,@efetivoTotal=0,@totalSalarios=0, @baseCalculoSalarioMedio=0,@valorDeInsalubridade=0,@salario = 0
@valorDePericulosidade=0,@valorCalculo220=220,@valorPeriOuIsalubri=0,@totalHrExtrasAlmoco=0,@horasDeCalculoAdNoturno=52.5,@totalFuncionarios=0
@efetivoIndivitual=0,@totalHrsAdNoturnoVespertino=0,@totalHrsAdNoturno=0, @acumuladorFuncionarios=0, @hAlmoco=0, @totalHrExtrasFeriado
select_calculation
##############################################################################################################################################
## Calculos dos equipamentos #################################################################################################################

@proposal.proposal_equipaments.each do |proposal_equipament| # for usado para pegar todos os equipamentos adcionados na proposta.
  @totalEquipamento += (proposal_equipament.quantidade*
                          (proposal_equipament.equipament.valor.to_f / 
                            proposal_equipament.equipament.depreciacao.to_f ))# total do valor de equipamento (usar na soma de totais).
end # fim do for proposal_equipament.
###############################################################################################################################################
## calculos de Salarios #######################################################################################################################
@proposal.proposal_roles.each do |proposal_role| # for para contar e somar quantidades de funcionarios e somar seus salarios.
   
      #  @vA = (((proposal_role.role.salario.to_f).round(2)*((proposal_role.role.gratificacao.to_f/100).round(2)+1)).round(2)*
      #      @proposal.rotation.efetivo).round(2) #Calculo de salario multiplicado pela porcentagem da gratificação e depois pelo efetivo.
  @totalSalarios = @totalSalarios+((proposal_role.role.salario.to_f*((proposal_role.role.gratificacao.to_f/100).round(2)+1)).round(2)*
                      @proposal.rotation.efetivo)*proposal_role.qtd_postos.to_f #acumulador de totais da soma de cima.
  @efetivoTotal += @proposal.rotation.efetivo*proposal_role.qtd_postos.to_f #total do efetivo da escala (efetivo*quantidade de postos)
  @salario = proposal_role.role.salario.to_f
  @efetivoIndivitual = @proposal.rotation.efetivo/@proposal.rotation.qtd_funcionarios.to_f
  @acumuladorFuncionarios+=@proposal.rotation.qtd_funcionarios*proposal_role.qtd_postos
  @vUniAssistMedica= proposal_role.role.assist_medica
  @vUniReciclagem = proposal_role.role.reciclagem
  @vUniUniforme = proposal_role.role.uniformes
  @vUniVR = proposal_role.role.vale_refeicao
  @vUniSegVida = proposal_role.role.seg_vida
end # fim do for proposal_role.

@totalSalarios=(@totalSalarios).round(2) #arredonda o total do salario
@baseCalculoSalarioMedio=(@totalSalarios/@efetivoTotal).round(2)#divide o total do salario pelo efetivo para fins de calculos em outras formulas
@totalFuncionarios = @efetivoTotal/@efetivoIndivitual  # total de quantidade de funcionarios (soma quantidade de funcionarios definidos na escala com base na quantidade de postos)
###############################################################################################################################################
## calculos de periculosidade e insalubridade #################################################################################################

@valorDePericulosidade = (0.3*@salario.to_f).round(2)
@valorDeInsalubridade = (0.4*@select_all_calculation.salario_minimo.to_f).round(2)
if @valorDePericulosidade>@valorDeInsalubridade
  @valorPeriOuIsalubri = @valorDePericulosidade
else
  @valorPeriOuIsalubri = @valorDeInsalubridade
end

###############################################################################################################################################
## adicional noturno e vespertino #############################################################################################################
@umTerco = @totalFuncionarios/3
if @proposal.rotation.ad_noturno== 0 # testa quando não tem adicional noturno
  @ajusteDivPorZero = 0 # ajuste de divizão por 0
  @umTerco = 0 # transforma 1 terço em 0
  @doisTerco = @totalFuncionarios # pega total de funcionarios para calculo de horas feriados
else
  @ajusteDivPorZero = @proposal.rotation.ad_noturno/@proposal.rotation.ad_noturno # correção de erro de divizão por 0
  @doisTerco =@umTerco*2 # pega apenas 2 terços quando adicional noturno for diferente de 0 e acrecenta para o calculo de horas extras feriados
end 

@totalHrsAdNoturnoVespertino=((((((@baseCalculoSalarioMedio+@valorPeriOuIsalubri).round(2)/220))*0.2*
                                  (((@proposal.rotation.ad_vespertido_noturno*100)/@horasDeCalculoAdNoturno).round(4)*@proposal.rotation.fator_escala).round(4))*
                                    ((@totalFuncionarios/@proposal.rotation.qtd_funcionarios)))/@efetivoTotal).round(2) #adicional noturno vespertino
@totalHrsAdNoturno=(((((@baseCalculoSalarioMedio + @valorPeriOuIsalubri).round(2)/220)) * 0.2 *
                      (((@ajusteDivPorZero * 60)/@horasDeCalculoAdNoturno).round(6) * @proposal.rotation.fator_escala * @proposal.rotation.ad_noturno))*
                          (@totalFuncionarios/@proposal.rotation.qtd_funcionarios)/@efetivoTotal).round(2) #adicional noturno

###############################################################################################################################################
## calculos horas extras ######################################################################################################################
if @proposal.h_almoco == 0 #Condicional criada para testar se a hora de almço é calculada  
  @hAlmoco = "Não"
  @totalHrExtrasAlmoco = 0
elsif @proposal.h_almoco == 1
  @hAlmoco = "Sim"
  @totalHrExtrasAlmoco = (((((@baseCalculoSalarioMedio+@valorPeriOuIsalubri+@totalHrsAdNoturnoVespertino+@totalHrsAdNoturno)/220)*1.6)*
                              (@acumuladorFuncionarios*@proposal.rotation.fator_escala))/@efetivoTotal).round(2)
                          #o calculo a cima é para calcular a cobrança de horas em extras de almoço (calculo de horas extras a mais é calculado de forma diferente)
end
@vFeriadosDeCitiesMV=(@proposal.city.feriado*0.6108) #Valor de feriado para carga horaia de matutino vespertino
@vFeriadosDeCitiesN=(@proposal.city.feriado*0.583) #Valor de feriado para carga horaia de matutino vespertino
@totalHrExtrasFeriado = (((@baseCalculoSalarioMedio+@valorPeriOuIsalubri+@totalHrsAdNoturnoVespertino+@totalHrsAdNoturno)/220)*
                          ((@vFeriadosDeCitiesMV*@doisTerco)+(@vFeriadosDeCitiesN*@umTerco)).round(2)/(@efetivoTotal)).round(2)
                          #Calculo para definir o valor de horas extras feriados feito apartir de horas trabalhadas dia pelas quantidade de feriados
@refexoDSR = ((@totalHrsAdNoturnoVespertino+ @totalHrsAdNoturno+ @totalHrExtrasAlmoco+ @totalHrExtrasFeriado)/25.09*5.35).round(2)
@salarioMedioFinal = (@baseCalculoSalarioMedio+@valorPeriOuIsalubri+@totalHrsAdNoturnoVespertino+ @totalHrsAdNoturno+ @totalHrExtrasAlmoco+ @totalHrExtrasFeriado+@refexoDSR).round(2)
@massaSalarial = @salarioMedioFinal*@efetivoTotal
###############################################################################################################################################
## > Obrigações sociais sobre massa salarial ##################################################################################################
###############################################################################################################################################
@ObgFGTS=0,@ObgINSS=0,@Obgseguro_aci_trabalho=0,@Obgsebrae=0,@Obgincra=0,@Obgsalario_educacao=0,@Obgsesc=0,@Obgsenac=0,@totalIncargosDiretos=0   

@ObgFGTS = ((@select_all_calculation.fgts/100)*@massaSalarial).round(2)
@ObgINSS = ((@select_all_calculation.inss/100)*@massaSalarial).round(2)
@Obgseguro_aci_trabalho = ((@select_all_calculation.seguro_aci_trabalho/100)*@massaSalarial).round(2)
@Obgsebrae = ((@select_all_calculation.sebrae/100)*@massaSalarial).round(2)
@Obgincra = ((@select_all_calculation.incra/100)*@massaSalarial).round(2)
@Obgsalario_educacao = ((@select_all_calculation.salario_educacao/100)*@massaSalarial).round(2)
@Obgsesc = ((@select_all_calculation.sesc/100)*@massaSalarial).round(2)
@Obgsenac = ((@select_all_calculation.senac/100)*@massaSalarial).round(2)


@totalIncargosDiretos = (@ObgFGTS+@ObgINSS+@Obgseguro_aci_trabalho+@Obgsebrae+@Obgincra+@Obgsalario_educacao+@Obgsesc+@Obgsenac).round(2)
###############################################################################################################################################
## >  Provisões sobre massa salarial ##########################################################################################################
###############################################################################################################################################
@totalferiasUmDozeAvos=0,@totalumTercoConstiUmDozeAvos=0,@totaldecimoTerceiroUmDozeAvos=0,@totalInssSobFeriasUnTercoDecimo=0,@totalFgtsSobFeriasUnTercoDecimo=0,@totalAvisoPrevio=0,@totalIndenizacaoSobreFGTS=0,@reservaTecnica=0

@totalferiasUmDozeAvos=((@efetivoTotal*@salarioMedioFinal)*((@select_all_calculation.ferias)/100)).round(2)
@totalumTercoConstiUmDozeAvos =((@efetivoTotal*@salarioMedioFinal)*((@select_all_calculation.um_terco_constitucional)/100)).round(2)
@totaldecimoTerceiroUmDozeAvos=((@efetivoTotal*@salarioMedioFinal)*((@select_all_calculation.decimo_terceito)/100)).round(2)
@totalInssSobFeriasUnTercoDecimo=((@totalferiasUmDozeAvos+@totalumTercoConstiUmDozeAvos+@totaldecimoTerceiroUmDozeAvos)*(@select_all_calculation.pct_inss_sob_soma_decimo_um_terco_ferias/100)).round(2)
@totalFgtsSobFeriasUnTercoDecimo=((@totalferiasUmDozeAvos+@totalumTercoConstiUmDozeAvos+@totaldecimoTerceiroUmDozeAvos)*(@select_all_calculation.pct_fgts_sob_soma_decimo_um_terco_ferias/100)).round(2)
@totalAvisoPrevio=((@select_all_calculation.aviso_previo/100)*@massaSalarial).round(2)
@totalIndenizacaoSobreFGTS=((@totalFgtsSobFeriasUnTercoDecimo+@ObgFGTS)*(@select_all_calculation.indenizacao_fgts/100)).round(2)
@reservaTecnica=(((2.2/100)*(@vDeCalculoTotal))))#512.32

@totalProvisaoMassaSalarial = (@totalferiasUmDozeAvos+@totalumTercoConstiUmDozeAvos+@totaldecimoTerceiroUmDozeAvos+
                                @totalInssSobFeriasUnTercoDecimo+@totalFgtsSobFeriasUnTercoDecimo+@totalAvisoPrevio+@totalIndenizacaoSobreFGTS+@reservaTecnica  ).round(2)
###############################################################################################################################################
## > Benefícios por Funcionário  ##############################################################################################################
###############################################################################################################################################
@totCesta=0,@totVR=0,@totAssiteciaMedica=0,@totSeguroVida=0,@totVT=0,@totReciclagem=0,@totUniforme=0

@totCesta = (@proposal.company.cesta*@efetivoTotal).round(2)
@totVR = ((@efetivoTotal*@proposal.rotation.horas_trabalhadas)*(@vUniVR*0.82)).round(2)
@totAssiteciaMedica = ((@vUniAssistMedica*@efetivoTotal)-((@salario*0.05)*@efetivoTotal)).round(2)
@totSeguroVida = (@vUniSegVida*@efetivoTotal).round(2)
@totVT = ((@proposal.city.valeTransporte*((@totalFuncionarios*30.44)*2))-((@salario*@efetivoTotal)*0.06)).round(2)
@totReciclagem = (@vUniReciclagem*@efetivoTotal).round(2)
@totUniforme = (@vUniUniforme*@efetivoTotal).round(2)

@totBeneficios=(@totCesta+@totVR+@totAssiteciaMedica+@totSeguroVida+@totVT+@totReciclagem+@totUniforme).round(2)

###############################################################################################################################################
## > total mão de obra  #######################################################################################################################
###############################################################################################################################################

@totMaoDeObra=@massaSalarial+@totalIncargosDiretos+@totalProvisaoMassaSalarial+@totBeneficios

###############################################################################################################################################
## > Administração e Operação #################################################################################################################
###############################################################################################################################################

@valorAdminOperacao = 1658.86

###############################################################################################################################################
## > total de tudo sem o que tem porcentagem referencia circular na tabela  ###################################################################
###############################################################################################################################################

@totParcialProposta=@totMaoDeObra+@totalEquipamento+@valorAdminOperacao




###############################################################################################################################################
## > lucro ####################################################################################################################################

@indceDeLucro = 8
@valorLucro=25284.89/(1-((@indceDeLucro)/100))-25284.89

###############################################################################################################################################
## > calculo total mais lucro #################################################################################################################
@pctTotal = @proposal.company.pis+@proposal.company.cofins+@proposal.company.csll+@proposal.company.irrf+@proposal.city.issqn+@indceDeLucro
@pctTotalAlicota=@totParcialProposta/(1-((@pctTotal)/100))-@totParcialProposta

@vDeCalculoTotal=@pctTotalAlicota+@totParcialProposta
###############################################################################################################################################
## > Impotos  #################################################################################################################################
###############################################################################################################################################

@valorCofins= 0
@valorPis=0

@valorPis=@vDeCalculoTotal/(1-((@proposal.company.pis)/100))-@vDeCalculoTotal
@valorCofins=@vDeCalculoTotal/(1-((@proposal.company.cofins)/100))-@vDeCalculoTotal
@valorCsll=@vDeCalculoTotal/(1-((@proposal.company.csll)/100))-@vDeCalculoTotal
@valorIrrf=@vDeCalculoTotal/(1-((@proposal.company.irrf)/100))-@vDeCalculoTotal
@valorIssqn=@vDeCalculoTotal/(1-((@proposal.city.issqn)/100))-@vDeCalculoTotal