class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      
      t.float :salario_minimo
      t.float :fgts
      t.float :inss
      t.float :seguro_aci_trabalho
      t.float :sebrae
      t.float :incra
      t.float :salario_educacao
      t.float :sesc
      t.float :senac
      t.float :decimo_terceito
      t.float :um_terco_constitucional
      t.float :ferias
      t.float :pct_inss_sob_soma_decimo_um_terco_ferias
      t.float :pct_fgts_sob_soma_decimo_um_terco_ferias
      t.float :aviso_previo
      t.float :indenizacao_fgts
      t.float :indiceOperacional
      t.float :indiceAdministrativo
      t.float :valorIndiceAdministrativo
      t.float :valorIndiceOperacional
      t.float :horasDeCalculoAdNoturno
      t.float :coberturas
      t.float :aviso_previo_hx
      t.float :ferias_h_ex
      t.float :ferias_um_terco_constitucional
      t.float :aux_enfermidade

      t.timestamps null: false
    end
  end
end
