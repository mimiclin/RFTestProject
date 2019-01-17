def decode(code):
    test = code.encode('utf-8')
    return test.decode('utf-8')


if __name__ == '__main__':
    print(decode('test'))