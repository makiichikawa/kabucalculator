import unittest
import sys
import os
import mysql.connector as mydb

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
        self.values = [('1234', 100,
                        0.1, 0.01, 0.001,
                        0.0001, 0.00001, 0.000001,
                        0.0000001, 0.00000001, 0.000000001),
                       ('1235', 101,
                        -0.2, 0.02, -0.002,
                        0.0002, 0.00002, 0.000002,
                        0.0000002, 0.00000002, 0.000000002)]

    def test_db_insert(self):
        self.dbregister.db_insert(self.values)
        table = os.getenv('DB_TABLE')
        columns = 'symbol, price, myuhat_short, '\
                  'sigmahat_short, probability_short, '\
                  'myuhat_medium, sigmahat_medium, probability_medium, '\
                  'myuhat_long, sigmahat_long, probability_long'
        self.dbregister.cursor.execute(f'SELECT {columns} FROM {table}')
        self.assertEqual(
            self.values,
            self.dbregister.cursor.fetchall()
        )

    def test_db_insert_exception(self):
        error_values = [('1234', 101)]
        with self.assertRaises(mydb.Error):
            self.dbregister.db_insert(error_values)

    def tearDown(self):
        self.dbregister.db_close()
