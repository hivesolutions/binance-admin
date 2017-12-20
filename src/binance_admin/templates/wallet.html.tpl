{% extends "base.html.tpl" %}
{% block title %}Wallet{% endblock %}
{% block name %}Wallet{% endblock %}
{% block content %}
    <div class="quote">
        Here you can check your wallet.
    </div>
    <ul class="account">
        {% for balance in account.balances %}
            {% if balance.free|float > 0.0 %}
                <p>{{ balance.asset }} - {{ balance.free }} - {{ own.quotes }}</p>
            {% endif %}
        {% endfor %}
    </ul>
{% endblock %}
