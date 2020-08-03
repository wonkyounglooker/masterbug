- dashboard: convert
  title: Convert
  layout: newspaper
  elements:
  - name: This is my text tile
    type: text
    title_text: This is my text tile
    body_text: Blah blah blah
    row: 0
    col: 0
    width: 24
    height: 1

  - title: Something vs. Other
    name: Table Next Test 2
    model: 212711_project_import_a
    explore: order_items
    type: looker_grid
    fields: [users.id, order_items.sum_price, orders.status]
    pivots: [users.id]
    sorts: [order_items.sum_price desc 0, users.id]
    limit: 500
    column_limit: 70
    dynamic_fields: [{table_calculation: statement_value, label: Statement Value,
        expression: "${order_items.sum_price}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: UTC
    pinned_columns:
      orders.status: left
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [order_items.sum_price]
    y_axes: []
    listen:
      Sale Price: order_items.sale_price
      Age: users.age
    row: 2
    col: 0
    width: 24
    height: 7

#   - title: New Tile
#     name: New Tile
#     model: won_bug
#     explore: order_items
#     type: table
#     fields: [order_items.inventory_item_id, order_items.returned_date]
#     sorts: [order_items.returned_date desc]
#     limit: 500
#     query_timezone: UTC
#     show_view_names: false
#     show_row_numbers: true
#     truncate_column_names: false
#     hide_totals: false
#     hide_row_totals: false
#     table_theme: editable
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     defaults_version: 1
#     row: 0
#     col: 8
#     width: 8
#     height: 6
