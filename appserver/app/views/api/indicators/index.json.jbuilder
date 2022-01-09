json.array! @indicators do |indicator|
	json.symbol indicator.symbol
	json.price indicator.price
end
