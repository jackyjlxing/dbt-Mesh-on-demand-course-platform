{% macro clean_stale_models(database=target.database, schema=target.schema, days=3, dry_run=True) %}

    {{ log('---before schema is ' ~ schema, info=True) }}

    {% set dbt_schema = env_var('DBT_SCHEMA', none) %}  

    {% if dbt_schema %}
        {% set schema = dbt_schema %}
        {{ log('---after schema is ' ~ schema, info=True) }}
    {% endif %}

    {% set get_drop_commands_query %}
        select schema_name, 
        'DROP SCHEMA ' || schema_name || ';' 
        from {{ target.database }}.information_schema.schemata 
        where schema_name like '{{ schema | upper }}_%' 
        and last_altered <= current_date - {{ days}}

    {% endset %}
    {{ log('---database is ' ~ database, info=True) }}
    {{ log('---schema is ' ~ schema, info=True) }}
    {{ log('---generating clean up queries ', info=True) }}

    {% set drop_queries=run_query(get_drop_commands_query).columns[1].values() %}

    {% for query in drop_queries %}
        {% if dry_run %}
            {{ log('--- :' ~query, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=True) }}
            {% do run_query(query) %}
        {% endif %}
        
    {% endfor %}

{% endmacro %}