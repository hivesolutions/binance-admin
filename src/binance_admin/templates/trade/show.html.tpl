{% extends "base.html.tpl" %}
{% block title %}Trades{% endblock %}
{% block name %}Trades{% endblock %}
{% block content %}
    {{ trades }}
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="20%">Symbol</th>
                <th class="right label" width="20%">Date</th>
                <th class="right label" width="20%">Value</th>
                <th class="right label" width="20%">Result</th>
            </tr>
        </thead>
        <tbody>
            <td class="left"><strong>{{ balance.asset }}</strong></td>
            <td class="right">{{ balance.free }}</td>
            <td class="right">{{ value_btc }}</td>
            <td class="right">{{ value_usd }}</td>
            <td class="right">{{ value_percent }}</td>
        </tbody>
    </table>
{% endblock %}
