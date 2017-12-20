{% extends "base.html.tpl" %}
{% block title %}Repos{% endblock %}
{% block name %}Repos{% endblock %}
{% block content %}
    <div class="quote">
        Here you can check your wallet.
    </div>
    <ul class="account">
    	{{ account }}
    </ul>
{% endblock %}
