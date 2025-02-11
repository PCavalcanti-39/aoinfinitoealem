{% macro filter_by_date(reference_date) %}
    CAST('{{ reference_date }}' as DATE)
{% endmacro %}
