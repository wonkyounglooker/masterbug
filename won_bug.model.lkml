connection: "thelook"

# include all the views
include: "*.view"
include: "/LookML_dashboards/*.dashboard"

explore: csv_dt {}

datagroup: won_bug_default_datagroup {
  sql_trigger: SELECT FLOOR(UNIX_TIMESTAMP() / (0.1*60*60))
  FROM demo_db.users;;
  max_cache_age: "1 hour"
}

access_grant: can_see_team_lead_payout {
  user_attribute: can_see_this
  allowed_values: ["Head"]
}

explore: connection_reg_r3 {}

explore: derived_test_table_3_20190510 {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_extended {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  aggregate_table: sales_monthly {
    materialization: {
      datagroup_trigger: won_bug_default_datagroup
    }
    query: {
      dimensions: [orders.created_month]
      measures: [order_items.paid_subscribers]
    }
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users_bug_primary_key  {
  view_name: users
  join: orders_wrong_primary {
    type: left_outer
    sql_on: ${orders_wrong_primary.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders2 {
  from: orders
  join: dimensions_1st {
    from: orders
    sql_on: ${orders2.id} = ${dimensions_1st.id} ;;
  }
  join: dimensions_2nd {
    from: orders
    sql_on: ${orders2.id} = ${dimensions_2nd.id} ;;
  }
  join: users {
    relationship: many_to_one
    sql_on: ${users.id} = ${orders2.user_id} ;;
    sql_where: 1=1 ;;
  }
}

explore: users {}

explore: users_nn {}

explore: zozo_table_20190507 {}

explore: zozo_table_20190508 {}

explore: zozo_table_null {}
