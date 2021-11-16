import unittest
import sys
import datetime

sys.path.append('..')

from lib.businessday import BusinessDay  # noqa: E402


class TestBusinessDay(unittest.TestCase):
    def setUp(self):
        self.businessday = BusinessDay()
        self.businessday.enddate = datetime.datetime(2021, 11, 16)

    def test_startdate(self):
        self.assertEqual(
            datetime.datetime(2021, 11, 2),
            self.businessday.startdate(10)
        )
