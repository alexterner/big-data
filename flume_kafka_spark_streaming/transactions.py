#!/usr/bin/python
import time
import datetime
import random


userIds = ["Alex", "Tom", "Alon", "Ram", "Shai", "Barak", "Tal"]

ips = ["123.221.14.56", "16.180.70.237", "10.182.189.79", "218.193.16.244", "198.122.118.164"]

stores = ["www.amazon.com", "www.ebay.com", "www.aliexpress.com", "www.buy.com", "www.target.com"]

otime = datetime.datetime(2013, 10, 10)


with open("transactions.log", "w") as f:

    for i in range(0, 50000000):

        otime += datetime.timedelta(seconds=random.randint(30, 300))

        ip = random.choice(ips)

        userId = random.choice(userIds)

        price = random.randint(0, 500)

        store = random.choice(stores)

        f.write("transaction_id_{iteration}, {ip}, {date}, {userId}, {price}, {store}\n".format(iteration=i, ip=ip,date=otime.strftime('%d/%b/%Y:%H:%M:%S %z'),userId=userId, price=price, store=store))

        if(i % 50 == 0):
            f.flush()

        time.sleep(0.1)