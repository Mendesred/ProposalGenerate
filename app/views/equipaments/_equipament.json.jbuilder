json.extract! equipament, :id,:typeEquipament_id , :name_equipament, :valor, :depreciacao, :created_at, :updated_at
json.url equipament_url(equipament, format: :json)
