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

import commons

import appier

class AdapterController(appier.Controller):

    def convert(self, value, origin, target = "BTC", places = 8):
        value = float(value)
        rate = self.conversion_r(origin, target)
        result = value * rate
        return self.round_s(result, places)

    def conversion_r(self, origin, target):
        if origin == target: return 1.0
        symbol = "%s%s" % (origin, target)
        if symbol in self.quotes: return self.quotes[symbol]
        symbol_r = "%s%s" % (target, origin)
        return 1.0 / self.quotes[symbol_r]

    def round_s(self, value, places = 8):
        if places == None: return "%f" % value
        value = commons.Decimal(value)
        value = round(value, places)
        template = "%%.0%df" % places
        return template % value

    @property
    @appier.cached
    def quotes(self):
        api = self.get_api()
        ticket = api.all_ticker()
        return dict(((value["symbol"], float(value["price"])) for value in ticket))

    @property
    @appier.cached
    def account(self):
        api = self.get_api()
        return api.self_account()

    @property
    @appier.cached
    def balance(self):
        balance_m = dict(
            ETH = 0.0,
            BTC = 0.0,
            USD = 0.0,
            EUR = 0.0
        )
        for balance in self.account["balances"]:
            asset = balance["asset"]
            value = float(balance["free"])
            if value <= 0.0: continue
            value_btc = self.convert(value, asset, target = "BTC")
            value_eth = self.convert(value, asset, target = "ETH")
            balance_m["BTC"] += float(value_btc)
            balance_m["ETH"] += float(value_eth)
        value_usd = self.convert(balance_m["BTC"], "BTC", target = "USDT", places = 2)
        balance_m["USD"] += float(value_usd)
        return balance_m
