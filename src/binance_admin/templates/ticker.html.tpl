{% extends "base.html.tpl" %}
{% block title %}Repos{% endblock %}
{% block name %}Repos{% endblock %}
{% block content %}
    <div class="quote">
        We're showing both your private and public GitHub repositories below.<br/>
        Enable your projects below by flicking the switch.
    </div>
    <ul class="repos">
        {% for item in ticker %}
            <li>
                <a href="{{ repo.html_url }}">{{ repo.full_name }}</a>

            </li>
        {% endfor %}
    </ul>
{% endblock %}
