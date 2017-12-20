{% extends "base.html.tpl" %}
{% block title %}Trades{% endblock %}
{% block name %}Trades{% endblock %}
{% block content %}
	{{ trades }}
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="20%">Symbol</th>
                <th class="right label" width="20%">Value</th>
                <th class="right label" width="20%">BTC</th>
                <th class="right label" width="20%">USD</th>
                <th class="right label" width="20%">Percent</th>
            </tr>
        </thead>
        <tbody>
            {% for balance in account.balances %}
                {% if balance.free|float > 0.0 %}
                    {% set value_btc = own.convert(balance.free, balance.asset) %}
                    {% set value_usd = own.convert(value_btc, "BTC", target = "USDT", places = 2) %}
                    {% set value_percent = "%.2f" % (value_btc|float / own.balance.BTC|float * 100.0,) %}
                    <tr>
                        <td class="left"><strong>{{ balance.asset }}</strong></td>
                        <td class="right">{{ balance.free }}</td>
                        <td class="right">{{ value_btc }}</td>
                        <td class="right">{{ value_usd }}</td>
                        <td class="right">{{ value_percent }}</td>
                    </tr>
                {% endif %}
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
