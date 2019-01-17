# -*-coding:utf-8 -*-

# import yaml
#
# f = open("C:\\Project_RF\\Test\\Resources\\Config\\PlayMethod.yaml")
# y = yaml.load(f)

x = 3
y = 3

if 1 < x == y:
    print(1)
else:
    print(2)

if 1 < x & x == y:
    print(1)
else:
    print(2)

sst = u'\u8bf7\u91cd\u65b0\u6295\u6ce8!\u5f53\u524d\u4f7f\u7528\u5956\u91d11800\u8d85\u51fa\u7cfb\u7edf\u8bbe\u7f6e'
print(repr(sst).decode('unicode-escape'))
# print(y['PlayMethod'][19])
# print(repr(y['PlayMethod'][19]).decode('unicode-escape'))
# print "BasicWinningPrice = ", y['PlayMethod'][19]['BasicWinningPrice']
# print('Increasement = ', y['PlayMethod'][19]['Increasement'])