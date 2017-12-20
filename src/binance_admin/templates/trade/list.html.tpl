{% extends "base.html.tpl" %}
{% block title %}Trades{% endblock %}
{% block name %}Trades :: {{ symbol }}{% endblock %}
{% block content %}
    {{ trades }}
    <table class="table table-list">
        <thead>
            <tr>
            	<th class="left label" width="20%">Date</th>
                <th class="center label" width="20%">Pair</th>
                <th class="right label" width="20%">Price</th>
                <th class="right label" width="20%">Fee</th>
                <th class="right label" width="20%">Total</th>
            </tr>
        </thead>
        <tbody>
        	{% for trade in trades %}
        		<tr>
		            <td class="left"><strong>{{ date_time((trade.time / 1000)|int) }}</strong></td>
		            <td class="right">{{ symbol }}</td>
		            <td class="right">{{ trade.price }}</td>
		            <td class="right">{{ trade.commission }}</td>
		            <td class="right">N/A</td>
        		</tr>
	        {% endfor %}
        </tbody>
    </table>
{% endblock %}
