import mysql.connector as mydb


class DBRegister:

    @property
    def host(self):
        pass

    @property
    def port(self):
        pass

    @property
    def username(self):
        pass

    @property
    def password(self):
        pass

    @property
    def database(self):
        pass

    @property
    def table(self):
        pass

    @host.setter
    def host(self, host):
        self.__host = host

    @port.setter
    def port(self, port):
        self.__port = port

    @username.setter
    def username(self, username):
        self.__username = username

    @password.setter
    def password(self, password):
        self.__password = password

    @database.setter
    def database(self, database):
        self.__database = database

    @table.setter
    def table(self, table):
        self.__table = table

    def db_connect(self):
        self.connection = None
        self.connection = mydb.connect(
                host=self.__host,
                port=self.__port,
                user=self.__username,
                password=self.__password,
                database=self.__database
        )
        self.connection.ping(reconnect=True)

    def db_init(self):
        self.cursor = self.connection.cursor()
        drop_sql = f'DROP TABLE IF EXISTS {self.__table};'
        create_sql = """
            CREATE TABLE IF NOT EXISTS indicators (
            `id` int auto_increment primary key,
            `symbol` varchar(4) not null,
            `price` int(11) not null,
            `myus` double(15,14) not null,
            `sigmas` double(15,14) not null,
            `myuhats` double(15,14) not null,
            `probs` double(15,14) not null,
            `myum` double(15,14) not null,
            `sigmam` double(15,14) not null,
            `myuhatm` double(15,14) not null,
            `probm` double(15,14) not null,
            `myul` double(15,14) not null,
            `sigmal` double(15,14) not null,
            `myuhatl` double(15,14) not null,
            `probl` double(15,14) not null
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """
        self.cursor.execute(drop_sql)
        self.cursor.execute(create_sql)

    def db_insert(self, values):
        sql = f'INSERT INTO {self.__table} VALUES '\
               '(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        self.cursor.executemany(sql, values)
        self.connection.commit()

    def db_close(self):
        self.cursor.close()
