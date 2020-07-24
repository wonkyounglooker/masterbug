
######################################
########## Web Analytics##############
#######################################
- dashboard: copy_of_redkitdemo
  title: Web Analytics
  layout: newspaper
  query_timezone: user_timezone
  description: 'Gives an overview of web analytics for a Ecommerce clothing store - metrics like views and conversion rates'
  embed_style:
    background_color: 'Shows overview of analytics (things like visit volume and conversion rates) for a given ecommerce store'
    show_title: true
    title_color: "#131414"
    show_filters_bar: true
    tile_text_color: "#070808"
    text_tile_text_color: "#0d0d0c"

  elements:
  - title: Total Visitors
    name: Total Visitors
    model: won_bug
    explore: events
    type: single_value
    fields: [events.unique_visitors, events.event_week]
    filters:
      events.event_date: 2 weeks ago for 2 weeks
    sorts: [events.event_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: change, label: Change, expression: "${events.unique_visitors}-offset(${events.unique_visitors},1)"}]
    query_timezone: America/Los_Angeles
    font_size: medium
    value_format: ''
    text_color: black
    colors: ["#1f78b4", "#a6cee3", "#33a02c", "#b2df8a", "#e31a1c", "#fb9a99", "#ff7f00",
      "#fdbf6f", "#6a3d9a", "#cab2d6", "#b15928", "#edbc0e"]
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: Weekly Change
    single_value_title: Visitors Past Week
    note_state: collapsed
    note_display: below
    note_text: ''
    listen:
      Browser: events.browser
      Traffic Source: users.traffic_source
    row: 0
    col: 0
    width: 6
    height: 3


  - title: Total Converted Visitors
    name: Total Converted Visitors
    model: won_bug
    explore: order_items
    type: single_value
    fields: [users.count]
    sorts: [users.count desc]
    limit: 500
    font_size: medium
    text_color: black
    listen:
      Traffic Source: users.traffic_source
      Date: order_items.created_date
    row: 0
    col: 11
    width: 5
    height: 3

  filters:
  - name: Browser
    title: Browser
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: won_bug
    explore: events
    listens_to_filters: []
    field: events.browser
  - name: Traffic Source
    title: Traffic Source
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    model: won_bug
    explore: events
    listens_to_filters: []
    field: users.traffic_source
  - name: Date
    title: Date
    type: date_filter
    default_value: 2 weeks
    allow_multiple_values: true
    required: false
