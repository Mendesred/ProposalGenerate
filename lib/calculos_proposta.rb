class CalculosProposta

  def calculo_modelo_de_horas_extras(diasDoMesTrabalhados,diasDaSemana,diasDeJonadaDeHorasExtra,feriado = 0,quantidadeDePostos,horasExJornada,minutosExJornada)
		((diasDoMesTrabalhados/diasDaSemana *diasDeJonadaDeHorasExtra)+feriado)*(quantidadeDePostos)*(horasExJornada+minutosExJornada)
	end

	def modelo_de_calculo_vt(diasDoMesTrabalhados,diasDaSemana,ajusteDePagamentoDoVt,feriado,quantidadeDeFuncionarios,mutiplicador)
		(((diasDoMesTrabalhados/diasDaSemana *ajusteDePagamentoDoVt)+feriado)*(quantidadeDeFuncionarios)*mutiplicador)
	end

end