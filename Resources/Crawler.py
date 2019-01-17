import DB_Handler

def getDrawNumberByLottery(LotteryID = ''):
    try:
        if LotteryID:
            sql = 'select jh.CP_QS \
                    from platform.tb_lottery_bs_cp_kj as jh \
                    where jh.CP_ID = %s and jh.kjsj < NOW() and jh.KJ_ZT = 1 and jh.ZJHM > "" \
                    order by jh.CPKJ_ID desc limit 1' % (LotteryID)
            res = DB_Handler.dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
            if res:
                return res[0][0]
            else:
                return 0
        else:
            return 1
    except Exception as e:
        return e


def getWinningNumberByLotteryAndDrawNumber(LotteryID = '', DrawNumber = ''):
    try:
        if LotteryID and DrawNumber:
            sql = 'select jh.ZJHM \
                    from platform.tb_lottery_bs_cp_kj as jh \
                    where jh.CP_ID = %s and jh.CP_QS = %s and jh.KJ_ZT = 1 \
                    order by jh.CPKJ_ID desc limit 1' % (LotteryID, DrawNumber)
            res = DB_Handler.dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
            if res:
                return res[0][0]
            else:
                return 0
        else:
            return 1
    except Exception as e:
        return e


def getOrderDetailByOrderID(OrderID = ''):
    try:
        if OrderID:
            sql = 'select jh.TZSL \
                    from platform.tb_lottery_bs_cp_dd as jh \
                    where jh.DDDH = "%s"' % OrderID
            res = DB_Handler.dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
            if res:
                return res[0][0]
            else:
                return 0
        else:
            return 1
    except Exception as e:
        return e


def getBetResult(UserID = '', DrawNumber = ''):
    try:
        if UserID and DrawNumber:
            sql = 'select jh.DDDH, jh.ZJZS \
                    from platform.tb_lottery_bs_cp_dd as jh \
                    where jh.YHID = %s and jh.QH = %s' % (UserID, DrawNumber)
            res = DB_Handler.dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
            if res:
                return res
            else:
                return 0
        else:
            return 1
    except Exception as e:
        return e


def getPlayMethodDetail(MethodID = ''):
    try:
        if MethodID:
            sql = 'select wf.HJJE1, wf.TZ_INC \
                    from platform.tb_lottery_bs_cp_wf as wf \
                    where wf.WF_ID = %s' % MethodID
            res = DB_Handler.dbQuery().ExecuteSQL(sql= sql)    # Send and execute sql request.
            if res:
                return res
            else:
                return 0
        else:
            return 1
    except Exception as e:
        return e

if __name__ == '__main__':
    # print(getDrawNumberByLottery(LotteryID = '67'))
    # print(getWinningNumberByLotteryAndDrawNumber(LotteryID = '96', DrawNumber = str(getDrawNumberByLottery(LotteryID = '96'))))
    # print(getBetOrderByUser(UserID='99533', LotteryID='29', DrawNumber=str(getDrawNumberByLottery(LotteryID='29'))))
    # print(getOrderDetailByOrderID(OrderID='111112613XJ5JCOO'))
    # print(getBetResult(UserID=99533, DrawNumber=201901110624))
    print(getPlayMethodDetail(MethodID=19))