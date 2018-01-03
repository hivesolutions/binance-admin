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
            {% for symbol, balance in own.balances %}
                {% if balance.base > 0.0 %}
                    {% set value_base = own.round_s(balance.base) %}
                    {% set value_btc = own.round_s(balance.BTC) %}
                    {% set value_usd = own.round_s(balance.USD, places = 2) %}
                    {% set value_percent = own.round_s(balance.percent, places = 2) %}
                    <tr>
                        <td class="left">
                            <strong>
                                <a href="{{ url_for('symbol.show', symbol = symbol) }}">{{ symbol }}</a>
                            </strong>
                        </td>
                        <td class="left">{{ value_base }}</td>
                        <td class="left">{{ value_btc }}</td>
                        <td class="right">{{ value_usd }}</td>
                        <td class="right">{{ value_percent }} %</td>
                    </tr>
                {% endif %}
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
