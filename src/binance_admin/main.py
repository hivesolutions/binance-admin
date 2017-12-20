#!/usr/bin/python
# -*- coding: utf-8 -*-

import appier
import appier_extras

class BinanceAdminApp(appier.WebApp):

    def __init__(self, *args, **kwargs):
        appier.WebApp.__init__(
            self,
            name = "binance_admin",
            parts = (
                appier_extras.AdminPart,
            ),
            *args, **kwargs
        )

if __name__ == "__main__":
    app = BinanceAdminApp()
    app.serve()
else:
    __path__ = []
