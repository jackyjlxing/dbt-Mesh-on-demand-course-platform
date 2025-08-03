{% set old_relation = adapter.get_relation(
      database = "ANALYTICS",
      schema = "DBT_NTHINK_70471840968324",
      identifier = "FCT_ORDERS"
) %}

{% set dbt_relation = ref('fct_orders') %}


{#  {{ audit_helper.compare_relations(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key = "order_id"
) }}
#}