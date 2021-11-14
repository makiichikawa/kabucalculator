import unittest
import sys
import os

sys.path.append('..')

from lib.dbregister import DBRegister  # noqa: E402


class TestDBRegister(unittest.TestCase):
    def setUp(self):
        self.dbregister = DBRegister()
        self.dbregister.host = os.getenv('DB_HOST')
        self.dbregister.port = os.getenv('DB_PORT')
        self.dbregister.username = os.getenv('DB_USERNAME')
        self.dbregister.password = os.getenv('DB_PASSWORD')
        self.dbregister.database = os.getenv('DB_DATABASE')
        self.dbregister.table = os.getenv('DB_TABLE')
        self.dbregister.db_connect()
        self.dbregister.db_init()

    def test_db_insert(self):
        values = [('1234', 100,
                  0.1, 0.01, 0.001, 0.0001,
                  0.00001, 0.000001, 0.0000001, 0.00000001,
                  0.000000001, 0.0000000001, 0.00000000001, 0.000000000001),
                  ('1235', 101,
                  -0.2, 0.02, -0.002, 0.0002,
                  0.00002, 0.000002, 0.0000002, 0.00000002,
                  0.000000002, 0.0000000002, 0.00000000002, 0.000000000002)]
        self.dbregister.db_insert(values)
        table = os.getenv('DB_TABLE')
        columns = 'id, symbol, price, myus, sigmas, myuhats, probs, '\
                  'myum, sigmam, myuhatm, probm, '\
                  'myul, sigmal, myuhatl, probl'
        self.dbregister.cursor.execute(f'SELECT {columns} FROM {table}')
        self.assertEqual(
            [(1, '1234', 100,
             0.1, 0.01, 0.001, 0.0001,
             0.00001, 0.000001, 0.0000001, 0.00000001,
             0.000000001, 0.0000000001, 0.00000000001, 0.000000000001),
             (2, '1235', 101,
             -0.2, 0.02, -0.002, 0.0002,
             0.00002, 0.000002, 0.0000002, 0.00000002,
             0.000000002, 0.0000000002, 0.00000000002, 0.000000000002)],
            self.dbregister.cursor.fetchall()
        )

    def tearDown(self):
        self.dbregister.db_close()
