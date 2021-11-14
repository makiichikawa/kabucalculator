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
        try:
            self.connection = None
            self.connection = mydb.connect(
                host=self.__host,
                port=self.__port,
                user=self.__username,
                password=self.__password,
                database=self.__database
            )
            self.connection.ping(reconnect=True)
        except mydb.Error:
            raise

    def db_init(self):
        try:
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
                `probl` double(15,14) not null,
                `created_at` timestamp not null default current_timestamp,
                `update_at` timestamp not null default current_timestamp \
                on update current_timestamp
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 \
                COLLATE=utf8mb4_general_ci
            """
            self.cursor.execute(drop_sql)
            self.cursor.execute(create_sql)
        except mydb.Error:
            raise

    def db_insert(self, values):
        try:
            sql = f'INSERT INTO {self.__table} '\
                '(symbol, price, myus, sigmas, myuhats, probs, '\
                'myum, sigmam, myuhatm, probm, '\
                'myul, sigmal, myuhatl, probl) VALUES '\
                '(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
            self.cursor.executemany(sql, values)
            self.connection.commit()
        except mydb.Error:
            self.connection.rollback()
            raise

    def db_close(self):
        try:
            self.cursor.close()
        except mydb.Error:
            raise
