{% extends "base.html.tpl" %}
{% block title %}Wallet{% endblock %}
{% block name %}Wallet{% endblock %}
{% block content %}
    <table class="table table-resume three">
        <tbody>
            <tr>
                <td>
                    <span class="label">BTC</span><br />
                    <span class="value">{{ own.round_s(own.balance.BTC) }}</span>
                </td>
                <td>
                    <span class="label">ETH</span><br />
                    <span class="value">{{ own.round_s(own.balance.ETH) }}</span>
                </td>
                <td>
                    <span class="label">USD</span><br />
                    <span class="value">{{ own.round_s(own.balance.USD, places = 2) }}</span>
                </td>
            </tr>
        </tbody>
    </table>
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="20%">Symbol</th>
                <th class="left label" width="20%">Value</th>
                <th class="left label" width="20%">BTC</th>
                <th class="right label" width="20%">USD</th>
                <th class="right label" width="20%">Percent</th>
            </tr>
        </thead>
        <tbody>
            {% for balance in account.balances %}
                {% if balance.free|float > 0.0 %}
                    {% set value_btc = own.convert(balance.free, balance.asset) %}
                    {% set value_usd = own.convert(value_btc, "BTC", target = "USDT", places = 2) %}
                    {% set value_percent = own.round_s(value_btc|float / own.balance.BTC|float * 100.0, places = 2) %}
                    <tr>
                        <td class="left">
                            <strong>
                                <a href="{{ url_for('symbol.show', symbol = balance.asset) }}">{{ balance.asset }}</a>
                            </strong>
                        </td>
                        <td class="left">{{ balance.free }}</td>
                        <td class="left">{{ value_btc }}</td>
                        <td class="right">{{ value_usd }}</td>
                        <td class="right">{{ value_percent }} %</td>
                    </tr>
                {% endif %}
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
