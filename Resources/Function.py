import time
import os
from Crypto.Cipher import DES3
import base64

class Log:
    def __init__(self, Path = '', Name = ''):
        self.LogName = Name
        self.LogPath = Path
        new_time = time.strftime("%Y%m%d%H%M%S", time.localtime())
        #Write test result to log file.
        # self.TestResult = open(self.LogPath + '\\Logs\\' + self.LogName + '_' + new_time + '.txt', 'w', encoding = 'UTF-8')
        self.TestResult = open(self.LogPath + '\\Logs\\' + self.LogName + '_' + new_time + '.txt', 'w')

    def write(self, String = ''):
        self.LogString = String
        self.TestResult.write(self.LogString + '\n')
        print(self.LogString)

    def close(self):
        self.TestResult.close()

class pwdEncrypt:
    def __init__(self, pwd = '', key = ''):
        self.pwd = pwd
        self.key = key

    def md5(self):
        import hashlib
        m = hashlib.md5()   
        m.update(self.pwd.encode(encoding='utf-8'))
        return m.hexdigest()

    def Encrypt(self):
        cipher = DES3.new(self.key, DES3.MODE_ECB)
        # md5 encrypt. (no idea why need '\x08'*8) ('\x08' means backspace.)
        encryptedString = str(self.md5()) + '\x08'*8
        # DES3 encrypt.
        encryptedString = cipher.encrypt(encryptedString)
        # base64 encrypt.
        encryptedString = base64.b64encode(encryptedString)
        return encryptedString.decode(encoding='utf-8')