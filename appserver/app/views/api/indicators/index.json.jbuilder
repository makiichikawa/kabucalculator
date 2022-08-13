json.array! @all_indicators do |indicators|
	json.id indicators['id']
	json.symbol indicators['symbol']
	json.price indicators['price']
	json.probability_short indicators['probability_short']
	json.myuhat_short indicators['myuhat_short']
	json.sigmahat_short indicators['sigmahat_short']
	json.probability_medium indicators['probability_medium']
	json.myuhat_medium indicators['myuhat_medium']
	json.sigmahat_medium indicators['sigmahat_medium']
	json.probability_long indicators['probability_long']
	json.myuhat_long indicators['myuhat_long']
	json.sigmahat_long indicators['sigmahat_long']
end
