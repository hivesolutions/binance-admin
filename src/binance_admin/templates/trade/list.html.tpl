{% extends "base.html.tpl" %}
{% block title %}Trades{% endblock %}
{% block name %}<a href="{{ url_for('base.wallet') }}">Trades</a> / {{ origin }}-{{ target }}{% endblock %}
{% block content %}
    <table class="table table-resume">
        <tbody>
            <tr>
                <td>
                    <span class="label">Origin</span><br />
                    <span class="value">
                        <a href="https://www.cryptocompare.com/coins/{{ origin|lower }}/overview/usd" target="_blank">{{ origin }}</a>
                    </span>
                </td>
                <td>
                    <span class="label">Target</span><br />
                    <span class="value">
                        <a href="https://www.cryptocompare.com/coins/{{ target|lower }}/overview/usd" target="_blank">{{ target }}</a>
                    </span>
                </td>
            </tr>
        </tbody>
    </table>
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="20%">Date</th>
                <th class="left label" width="14%">Type</th>
                <th class="left label" width="24%">Unit Price</th>
                <th class="left label" width="24%">Amount</th>
                <th class="right label" width="18%">P/L</th>
            </tr>
        </thead>
        <tbody>
            {% for trade in trades %}
                {% set type_s = "Buy" if trade.isBuyer else "Sell" %}
                {% set trade_total = (trade.qty|float * trade.price|float) + (trade.commission|float * trade.price|float) %}
                {% set current_price = own.convert(1.0, origin, target = target) %}
                {% set profit = current_price|float - trade.price|float %}
                {% set profit_percent = profit / trade.price|float * 100.0 %}
                {% set profit_percent_s = own.round_s(profit_percent, places = 2) %}
                <tr>
                    <td class="left"><strong>{{ date_time((trade.time / 1000)|int) }}</strong></td>
                    {% if type_s == "Buy" %}
                        <td class="left green">{{ type_s }}</td>
                    {% else %}
                        <td class="left red">{{ type_s }}</td>
                    {% endif %}
                    <td class="left">{{ trade.price }} {{ target }}</td>
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
{% endblock %}
