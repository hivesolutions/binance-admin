#!/usr/bin/python
# -*- coding: utf-8 -*-

# Hive Binance Admin
# Copyright (c) 2008-2019 Hive Solutions Lda.
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

__copyright__ = "Copyright (c) 2008-2019 Hive Solutions Lda."
""" The copyright for the module """

__license__ = "Apache License, Version 2.0"
""" The license for the module """

import appier

from . import adapter

class BaseController(adapter.AdapterController):

    @appier.route("/", "GET")
    def index(self):
        return self.redirect(
            self.url_for("base.ticker")
        )

    @appier.route("/ticker", "GET")
    def ticker(self):
        api = self.get_api()
        ticker = api.all_ticker()
        return self.template(
            "ticker.html.tpl",
            link = "ticker",
            ticker = ticker
        )

    @appier.route("/wallet", "GET")
    @appier.ensure(token = "admin")
    def wallet(self):
        api = self.get_api()
        account = api.self_account()
        return self.template(
            "wallet.html.tpl",
            link = "wallet",
            account = account
        )
