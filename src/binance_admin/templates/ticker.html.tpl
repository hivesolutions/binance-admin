{% extends "base.html.tpl" %}
{% block title %}Ticker{% endblock %}
{% block name %}Ticker{% endblock %}
{% block content %}
    <div class="quote">
        Here you can check the current prices of the pairs.
    </div>
    <table class="table table-list">
        <thead>
            <tr>
                <th class="left label" width="50%">Symbol</th>
                <th class="right label" width="50%">Value</th>
            </tr>
        </thead>
        <tbody>
            {% for item in ticker %}
                <tr>
                    <td class="left"><strong>{{ item.symbol }}</strong></td>
                    <td class="right">{{ item.price }}</td>
                </tr>
            {% endfor %}
        </tbody>
    </table>
{% endblock %}
