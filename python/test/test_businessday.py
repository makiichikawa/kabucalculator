import unittest
import sys
import datetime

sys.path.append('..')

from lib.businessday import BusinessDay  # noqa: E402


class TestBusinessDay(unittest.TestCase):
    def setUp(self):
        self.businessday = BusinessDay()

    def test_from_date_case_to_date_is_weekday(self):
        self.businessday.to_date = datetime.datetime(2021, 11, 16)
        self.assertEqual(
            datetime.datetime(2021, 11, 2),
            self.businessday.from_date(10)
        )

    def test_from_date_case_to_date_is_saturday(self):
        self.businessday.to_date = datetime.datetime(2021, 12, 4)
        self.assertEqual(
            datetime.datetime(2021, 12, 1),
            self.businessday.from_date(3)
        )

    def test_from_date_case_to_date_is_sunday(self):
        self.businessday.to_date = datetime.datetime(2021, 12, 5)
        self.assertEqual(
            datetime.datetime(2021, 12, 1),
            self.businessday.from_date(3)
        )
