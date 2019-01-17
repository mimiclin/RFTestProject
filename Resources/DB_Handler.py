import os
import configparser
import MySQLdb


class dbQuery:
    def __init__(self):
            WorkingPath = os.path.dirname(__file__)
            cf = configparser.ConfigParser()
            cf.read(WorkingPath + '\Config\Config.ini')
            enVariable = int(cf.get('Connection', 'Environment'))

            # Setup mariaDB connection string.
            if enVariable == 1:
                cf_DBOption = 'DBConnectionDev'
            elif enVariable == 3:
                cf_DBOption = 'DBConnectionProd'
            else:
                cf_DBOption = 'DBConnectionUAT'

            # Combine db connection string.
            db_host = cf.get(cf_DBOption, 'host')
            db_port = cf.get(cf_DBOption, 'port')
            db_user = cf.get(cf_DBOption, 'user')
            db_pwd = cf.get(cf_DBOption, 'pwd')
            db_name = 'platform'
            self.db_content = dict(host = db_host, port = int(db_port), user = db_user, passwd = db_pwd, db = db_name)
            
            

            # def CreateSQLConnection(self, db_host = '', db_port = '', db_user = '', db_pwd = '', db_name = ''): 
    def CreateSQLConnection(self, **kwargs): 
        try:
            # self.dbc = MySQLdb.connect(host = db_host, port = int(db_port), user = db_user, passwd = db_pwd, db = db_name)
            self.dbc = MySQLdb.connect(**kwargs)
            self.dbc.autocommit(True)
            return self.dbc.cursor()
        except Exception as e:
            print(str(e))

    def ExecuteSQL(self, sql = ''):
        self.cursor = dbQuery().CreateSQLConnection(**self.db_content)   # Create MySQL connection.
        if self.cursor:
            self.cursor.execute(sql)
            res = []
            for items in self.cursor.fetchall():     # Convert sql result from tuple to list.
                res.append(items)
            self.cursor.close()
            return res


    def GetTableSchema(self, cursor, table_name):
        cursor.execute("SHOW columns from " + table_name)
        return [column[0] for column in cursor.fetchall()]


    def CloseSQLConnection(self):
        self.cursor.close()

# class getCrawlerNumber:
#     def byLotteryAndQH(self, LotteryID = '', QH = ''):
#         sql = 'select jh.ZJHM from platform.tb_lottery_bs_cp_kj as jh where jh.CP_ID = %s and jh.CP_QS = %s and jh.kjsj < NOW() order by jh.CPKJ_ID desc limit 1' % (LotteryID, QH)
#         res = dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
#         # dbQuery().CloseSQLConnection()   # Close MySQL connection.
#         return res[0]

# if __name__ == '__main__':
#     print(getCrawlerNumber().byLotteryAndQH(LotteryID = '96', QH = '201810231321'))