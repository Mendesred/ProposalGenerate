class CalculosProposta
  def calculo_modelo_de_horas_extras(diasDoMesTrabalhados,diasDaSemana,diasDeJonadaDeHorasExtra,feriado = 0,quantidadeDePostos,horasExJornada,minutosExJornada)
		((diasDoMesTrabalhados/diasDaSemana *diasDeJonadaDeHorasExtra)+feriado)*(quantidadeDePostos)*(horasExJornada+minutosExJornada)
	# (25,36(dias trablahados no mes /5 *dias na semana (dias no mes)) *(numero de efetivo manha)+ => dias da semana de 1a5
	end

	def modelo_de_calculo_vt(diasDoMesTrabalhados,diasDaSemana,ajusteDePagamentoDoVt,feriado,quantidadeDeFuncionarios,mutiplicador)
		(((diasDoMesTrabalhados/diasDaSemana *ajusteDePagamentoDoVt)+feriado)*(quantidadeDeFuncionarios)*mutiplicador)
	end

end