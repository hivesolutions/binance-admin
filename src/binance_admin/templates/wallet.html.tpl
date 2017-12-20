{% extends "base.html.tpl" %}
{% block title %}Wallet{% endblock %}
{% block name %}Wallet{% endblock %}
{% block content %}
    <div class="quote">
        Here you can check your wallet.
    </div>
    <ul class="account">
        <p><strong>TOTAL - {{ own.balance.BTC }} BTC</strong></p>
        {% for balance in account.balances %}
            {% if balance.free|float > 0.0 %}
                <p>{{ balance.asset }} - {{ balance.free }} - {{ own.convert(balance.free, balance.asset) }} BTC</p>
            {% endif %}
        {% endfor %}
    </ul>
{% endblock %}
