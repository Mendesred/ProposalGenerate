namespace :city do

	def criaCity(nomeCidade,qtdFeriado,valorVt,pcyIssqn)
		City.find_or_create_by!(
			nome:nomeCidade,
			feriado:qtdFeriado,
			valeTransporte:valorVt,
			issqn:pcyIssqn)

	end
	puts  "Cidades criadas"

  desc "TODO"
  task seed: :environment do
		require "csv"
	
		CSV.foreach(File.join(Rails.root,"db/issqn.csv"), :headers => true) do |row|
		  criaCity(row[1],0,0,row[0])
		end
  
  end


end
