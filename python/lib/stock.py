import investpy

from lib.product import Product


class Stock(Product):

    @property
    def open_prices(self):
        return self.prices['open']

    @property
    def high_prices(self):
        return self.prices['high']

    @property
    def low_prices(self):
        return self.prices['low']

    @property
    def close_prices(self):
        return self.prices['close']

    def set_historical_prices(self, symbol):
        try:
            stocks_data = investpy.get_stock_historical_data(
                stock=symbol,
                country=self.country,
                from_date=self.from_date,
                to_date=self.to_date,
                order='ascending',
                interval=self.interval)
            self.prices['open'] = stocks_data['Open'].to_list()
            self.prices['high'] = stocks_data['High'].to_list()
            self.prices['low'] = stocks_data['Low'].to_list()
            self.prices['close'] = stocks_data['Close'].to_list()
        except IndexError:
            raise
