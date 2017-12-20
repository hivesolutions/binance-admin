{% extends "base.html.tpl" %}
{% block title %}Wallet{% endblock %}
{% block name %}Wallet{% endblock %}
{% block content %}
    <table class="table table-resume three">
        <tbody>
            <tr>
                <td>
                    <span class="label">Total BTC</span><br />
                    <span class="value">{{ own.balance.BTC }}</span>
                </td>
                <td>
                    <span class="label">Total ETH</span><br />
                    <span class="value">{{ own.balance.ETH }}</span>
                </td>
                <td>
                    <span class="label">Total USD</span><br />
                    <span class="value">{{ own.balance.USD }}</span>
                </td>
            </tr>
        </tbody>
    </table>
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
                    {% set value_percent = own.round_s(value_btc|float / own.balance.BTC|float * 100.0, 2) %}
                    <tr>
                        <td class="left">
                            <strong>
                                <a href="{{ url_for('trade.list', symbol = balance.asset + 'BTC') }}">{{ balance.asset }}</a>
                            </strong>
                        </td>
                        <td class="right">{{ balance.free }}</td>
                        <td class="right">{{ value_btc }}</td>
                        <td class="right">{{ value_usd }}</td>
                        <td class="right">{{ value_percent }} %</td>
                    </tr>
                {% endif %}
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
