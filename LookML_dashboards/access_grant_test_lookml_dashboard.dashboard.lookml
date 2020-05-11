- dashboard: access_grant_test_lookml_dashboard
  title: access grant test
  layout: newspaper
  elements:
  - title: New Tile
    name: New Tile
    model: won_bug
    explore: events
    type: single_value
    fields: [events.count]
    limit: 500
    query_timezone: UTC
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile (2)
    model: won_bug
    explore: events
    type: looker_grid
    fields: [events.count]
    limit: 500
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    series_types: {}
    row: 0
    col: 8
    width: 8
    height: 6
