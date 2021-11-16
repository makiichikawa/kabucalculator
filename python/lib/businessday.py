import jpbizday
import datetime


class BusinessDay:
    def __init__(self, enddate=None):
        self.__enddate = enddate

    @property
    def enddate(self):
        pass

    @enddate.setter
    def enddate(self, enddate):
        self.__enddate = enddate

    def startdate(self, before_days):
        business_days = 1
        date = self.__enddate
        while business_days < before_days:
            date -= datetime.timedelta(days=1)
            if jpbizday.is_bizday(date):
                business_days += 1
        return date
