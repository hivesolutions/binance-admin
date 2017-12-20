{% extends "base.html.tpl" %}
{% block title %}Ticker{% endblock %}
{% block name %}Ticker{% endblock %}
{% block content %}
    <div class="quote">
        Here you can check the current prices of the pairs.
    </div>
    <ul class="ticker">
        {% for item in ticker %}
            <li>
            	<span class="symbol">{{ item.symbol }}</span>
            	<span class="symbol">{{ item.price }}</span>
            </li>
        {% endfor %}
    </ul>
{% endblock %}
