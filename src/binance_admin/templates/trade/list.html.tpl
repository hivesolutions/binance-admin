{% extends "base.html.tpl" %}
{% block title %}Trades{% endblock %}
{% block name %}Trades :: {{ symbol }}{% endblock %}
{% block content %}
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="20%">Date</th>
                <th class="left label" width="20%">Price</th>
                <th class="right label" width="20%">Fee</th>
                <th class="right label" width="20%">Total</th>
                <th class="right label" width="20%">P/L</th>
            </tr>
        </thead>
        <tbody>
            {% for trade in trades %}
                {% set trade_total = (trade.qty|float * trade.price|float) + (trade.commission|float * trade.price|float) %}
                {% set current_price = own.convert(1.0, origin, target = target) %}
                {% set profit = current_price|float - trade.price|float %}
                {% set profit_percent = "%.02f" % (profit / trade.price|float * 100.0) %}
                <tr>
                    <td class="left"><strong>{{ date_time((trade.time / 1000)|int) }}</strong></td>
                    <td class="left">{{ trade.price }}</td>
                    <td class="right">{{ trade.commission }}</td>
                    <td class="right">{{ "%.08f" % trade_total }}</td>
                    {% if profit_percent > 0.0 %}
                        <td class="right green">{{ profit_percent }} %</td>
                    {% else %}
                        <td class="right red">{{ profit_percent }} %</td>
                    {% endif %}
                </tr>
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
