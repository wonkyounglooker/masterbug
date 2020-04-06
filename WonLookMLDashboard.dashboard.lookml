- dashboard: convert
  title: Convert
  layout: newspaper
  elements:
  - title: New Tile
    name: New Tile
    model: won_bug
    explore: order_items
    type: table
    fields: [order_items.inventory_item_id, order_items.returned_date]
    sorts: [order_items.returned_date desc]
    limit: 500
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    row: 0
    col: 8
    width: 8
    height: 6
