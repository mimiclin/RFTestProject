# -*-coding:utf-8 -*-

import itertools

def find_same_element(l1, l2):
    dist = {}
    result = {}
    for i in l1:
        dist[i] = 1
    for i in l2:
        if dist.get(i) > None:
            result[i] = 1
    return len(result)


# 算不定位膽
def CalcCombination(BetNumber, GetCount):
    result = list(itertools.combinations(BetNumber, GetCount))
    result_list = []
    result_list.append(result)
    return result_list

# Calc bet order then return result.
def SettleBetResultByMethod(MethodID, BetNumber, WinningNumber):
    # BetNumberList = BetNumber.split(',')
    BetNumberList = []
    BetNumberList.append(BetNumber)
    WinningNumberList = WinningNumber.split(',')
    if int(MethodID) == 19:
        try:
            # cnt = 0
            MappingNumberList = []
            for i in range(3):
                MappingNumberList.append(int(WinningNumberList[i]))
            for x in BetNumberList:
                r = []
                x = int(x)
                while x:
                    r.append(x % 10)
                    x = int(x/10)
                # message =  'BetNumber:%s, HitCnt:%i' % (BetNumberList[cnt], find_same_element(r, MappingNumberList))
                # print(message)
                # cnt += 1
            HitCnt = find_same_element(r, MappingNumberList)
        except Exception as e:
            return(e)

        return(HitCnt)


def appendToDict(dictObj, **kwargs):
    # if dictObj:
    cnt = len(dictObj)
    # dictObj[].update(kwargs)
    dictObj[cnt] = kwargs
    return dictObj


def dictLength(dictObj):
    if dictObj:
        return len(dictObj)
    else:
        return 0


if __name__ == '__main__':
    # l1 = [1, 2, '34', 34, 5]
    # l2 = [4, 7, 8, 5]
    # print find_same_element(l1, l2)
    # l1 = '12345'
    # l2 = '8,1,1,3,9'
    # print SettleBetResultByMethod('19', l1, l2)
    # print CalcCombination('012345', 2)
    # print len(CalcCombination('012345', 2))
    # print appendToDict({0: {'OrderID': 'qqeerr', 'BetNumber': 67890}}, BetNumber=67890, OrderID="qqeerr")
    print dictLength({0: {'OrderID': 'qqeerr', 'BetNumber': 67890}, 1: {'OrderID': 'qqeerr', 'BetNumber': 67890}})