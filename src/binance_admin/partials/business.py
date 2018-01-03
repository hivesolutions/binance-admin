#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Binance Admin
# Copyright (c) 2008-2017 Hive Solutions Lda.
#
# This file is part of Hive Binance Admin.
#
# Hive Binance Admin is free software: you can redistribute it and/or modify
# it under the terms of the Apache License as published by the Apache
# Foundation, either version 2.0 of the License, or (at your option) any
# later version.
#
# Hive Binance Admin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# Apache License for more details.
#
# You should have received a copy of the Apache License along with
# Hive Binance Admin. If not, see <http://www.apache.org/licenses/>.

__author__ = "João Magalhães <joamag@hive.pt>"
""" The author(s) of the module """

__version__ = "1.0.0"
""" The version of the module """

__revision__ = "$LastChangedRevision$"
""" The revision number of the module """

__date__ = "$LastChangedDate$"
""" The last change date of the module """

__copyright__ = "Copyright (c) 2008-2017 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "Apache License, Version 2.0"
""" The license for the module """

import binance
import commons

import appier

class Business(object):

    @classmethod
    def convert_g(cls, value, origin, target = "BTC", places = 8):
        value = float(value)
        rate = cls.conversion_g(origin, target)
        result = value * rate
        return cls.round_g(result, places = places)

    @classmethod
    def conversion_g(cls, origin, target):
        if origin == target: return 1.0
        quotes = cls.get_quotes_g()
        symbol = "%s%s" % (origin, target)
        if symbol in quotes: return quotes[symbol]
        symbol_r = "%s%s" % (target, origin)
        return 1.0 / quotes[symbol_r]

    @classmethod
    def round_g(cls, value, places = 8):
        if places == None: return "%f" % value
        value = commons.Decimal(value)
        value = round(value, places)
        template = "%%.0%df" % places
        return template % value

    @classmethod
    @appier.cached
    def get_api(cls):
        api = cls._get_api()
        return api

    @classmethod
    @appier.cached
    def get_quotes_g(cls):
        api = cls.get_api()
        ticket = api.all_ticker()
        return dict(((value["symbol"], float(value["price"])) for value in ticket))

    @classmethod
    @appier.cached
    def get_account_g(cls):
        api = cls.get_api()
        return api.self_account()

    @classmethod
    @appier.cached
    def get_balance_g(cls):
        balance_m = dict(
            ETH = 0.0,
            BTC = 0.0,
            USD = 0.0,
            EUR = 0.0
        )
        for balance in cls.get_account_g()["balances"]:
            value = 0.0
            asset = balance["asset"]
            value += float(balance["free"])
            value += float(balance["locked"])
            if value <= 0.0: continue
            value_btc = cls.convert_g(value, asset, target = "BTC")
            value_eth = cls.convert_g(value, asset, target = "ETH")
            balance_m["BTC"] += float(value_btc)
            balance_m["ETH"] += float(value_eth)
        value_usd = cls.convert_g(balance_m["BTC"], "BTC", target = "USDT", places = 2)
        balance_m["USD"] += float(value_usd)
        return balance_m

    @classmethod
    @appier.cached
    def get_balances_g(cls):
        balances_m = appier.OrderedDict()
        global_m = cls.get_balance_g()
        for balance in cls.get_account_g()["balances"]:
            value = 0.0
            asset = balance["asset"]
            value += float(balance["free"])
            value += float(balance["locked"])
            if value <= 0.0: continue
            balance_m = dict()
            value_btc = cls.convert_g(value, asset, target = "BTC")
            value_eth = cls.convert_g(value, asset, target = "ETH")
            value_usd = cls.convert_g(value_btc, "BTC", target = "USDT")
            balance_m["base"] = value
            balance_m["BTC"] = float(value_btc)
            balance_m["ETH"] = float(value_eth)
            balance_m["USD"] = float(value_usd)
            balance_m["percent"] = float(value_usd) / global_m["USD"] * 100.0
            balances_m[asset] = balance_m
        balances_m.sort(key = lambda v: v[1]["USD"], reverse = True)
        return balances_m

    @classmethod
    def _get_api(cls):
        return binance.API()

    def convert(self, value, origin, target = "BTC", places = 8):
        return self.__class__.convert_g(
            value,
            origin,
            target = target,
            places = places
        )

    def conversion_r(self, origin, target):
        return self.__class__.conversion_g(origin, target)

    def round_s(self, value, places = 8):
        return self.__class__.round_g(value, places)

    @property
    def quotes(self):
        return self.__class__.get_quotes_g()

    @property
    def account(self):
        return self.__class__.get_account_g()

    @property
    def balance(self):
        return self.__class__.get_balance_g()

    @property
    def balances(self):
        return self.__class__.get_balances_g()
