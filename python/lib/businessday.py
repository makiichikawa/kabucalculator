import jpbizday
import datetime


class BusinessDay:
    def __init__(self, to_date=None):
        self.__to_date = to_date

    @property
    def to_date(self):
        pass

    @to_date.setter
    def to_date(self, to_date):
        self.__to_date = to_date

    def from_date(self, before_days):
        date = self.__to_date
        business_days = 1 if jpbizday.is_bizday(date) else 0
        while business_days < before_days:
            date -= datetime.timedelta(days=1)
            if jpbizday.is_bizday(date):
                business_days += 1
        return date
