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

import appier

from .. import base

class Fact(base.BinanceBase):
    """
    The base fact model from which all the facts should inherit
    to be able to be represented in the data warehouse as facts.

    Should expose some of the dimension in a denormalized form.
    """

    year = appier.field(
        type = int,
        index = True
    )

    month = appier.field(
        type = int,
        index = True
    )

    day = appier.field(
        type = int,
        index = True
    )

    hour = appier.field(
        type = int,
        index = True
    )

    minute = appier.field(
        type = int,
        index = True
    )

    @classmethod
    def is_abstract(cls):
        return True
