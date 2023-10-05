{% macro create_contract(model) %}
    {% set cols=adapter.get_columns_in_relation(model) %}
models:
  - name: {{ model }}
    config:
      contract:
        enforced: true
    columns:
    {%- for col in cols %}
      - name: {{ col.name | lower }}
        data_type: {{ col.dtype | lower }}
    {%- endfor %}
    
{% endmacro %}