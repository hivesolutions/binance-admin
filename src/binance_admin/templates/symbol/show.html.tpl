{% extends "base.html.tpl" %}
{% block title %}Symbols{% endblock %}
{% block name %}<a href="{{ url_for('base.wallet') }}">Symbols</a> / {{ symbol }}{% endblock %}
{% block content %}
    <table class="table table-resume three">
        <tbody>
            <tr>
                <td>
                    <span class="label">Amount</span><br />
                    <span class="value">
                        <a href="https://www.cryptocompare.com/coins/{{ symbol|lower }}/overview/usd" target="_blank">{{ own.round_s(own.balances[symbol].base) }}</a>
                    </span>
                </td>
                <td>
                    <span class="label">BTC</span><br />
                    <span class="value">
                        <a href="https://www.cryptocompare.com/coins/{{ symbol|lower }}/overview/btc" target="_blank">{{ own.round_s(own.balances[symbol].BTC) }}</a>
                    </span>
                </td>
                <td>
                    <span class="label">USD</span><br />
                    <span class="value">
                        <a href="https://www.cryptocompare.com/coins/{{ symbol|lower }}/overview/usd" target="_blank">{{ own.round_s(own.balances[symbol].USD, places = 2) }}</a>
                    </span>
                </td>
            </tr>
        </tbody>
    </table>
    {% for target in ("BTC", "ETH") %}
        {% if not target == symbol %}
            {% set reversed = True if symbol == "BTC" else False %}
            {% set pair = target + symbol if reversed else symbol + target %}
            {% set trades = own.get_api().list_trades(symbol = pair) %}
            <table class="table table-resume">
                <tbody>
                    <tr>
                        <td>
                            <span class="label">Origin</span><br />
                            <span class="value">
                                <a href="https://www.cryptocompare.com/coins/{{ symbol|lower }}/overview/{{ target|lower }}" target="_blank">{{ symbol }}</a>
                            </span>
                        </td>
                        <td>
                            <span class="label">Target</span><br />
                            <span class="value">
                                <a href="https://www.cryptocompare.com/coins/{{ target|lower }}/overview/{{ target|lower }}" target="_blank">{{ target }}</a>
                            </span>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="table table-list">
                <thead>
                    <tr>
                        <th class="left label" width="20%">Date</th>
                        <th class="left label" width="12%">Type</th>
                        <th class="left label" width="26%">Unit Price</th>
                        <th class="left label" width="26%">Amount</th>
                        <th class="right label" width="16%">P/L</th>
                    </tr>
                </thead>
                <tbody>
                    {% for trade in trades %}
                        {% if reversed %}
                            {% set type_s = "Sell" if trade.isBuyer else "Buy" %}
                            {% set trade_total = (trade.qty|float * (1.0 / trade.price|float)) + (trade.commission|float * (1.0 / trade.price|float)) %}
                            {% set current_price = own.convert(1.0, symbol, target = target) %}
                            {% set profit = current_price|float - (1.0 / trade.price|float) %}
                            {% set profit_percent = profit / (1.0 / trade.price|float) * 100.0 %}
                            {% set profit_percent = profit_percent * -1 if type_s == "Sell" else profit_percent %}
                            {% set profit_percent_s = own.round_s(profit_percent, places = 2) %}
                        {% else %}
                            {% set type_s = "Buy" if trade.isBuyer else "Sell" %}
                            {% set trade_total = (trade.qty|float * trade.price|float) + (trade.commission|float * trade.price|float) %}
                            {% set current_price = own.convert(1.0, symbol, target = target) %}
                            {% set profit = current_price|float - trade.price|float %}
                            {% set profit_percent = profit / trade.price|float * 100.0 %}
                            {% set profit_percent = profit_percent * -1 if type_s == "Sell" else profit_percent %}
                            {% set profit_percent_s = own.round_s(profit_percent, places = 2) %}
                        {% endif %}
                        <tr>
                            <td class="left"><strong>{{ date_time((trade.time / 1000)|int) }}</strong></td>
                            {% if type_s == "Buy" %}
                                <td class="left green">{{ type_s }}</td>
                            {% else %}
                                <td class="left red">{{ type_s }}</td>
                            {% endif %}
                            {% if reversed %}
                                <td class="left">{{ own.round_s(1.0 / trade.price|float) }} {{ target }}</td>
                            {% else %}
                                <td class="left">{{ trade.price }} {{ target }}</td>
                            {% endif %}
                            <td class="left">{{ own.round_s(trade_total) }} {{ target }}</td>
                            {% if profit_percent > 0.0 %}
                                <td class="right green">{{ profit_percent_s }} %</td>
                            {% else %}
                                <td class="right red">{{ profit_percent_s }} %</td>
                            {% endif %}
                        </tr>
                    {% endfor %}
                </tbody>
            </table>
        {% endif %}
    {% endfor %}
{% endblock %}
