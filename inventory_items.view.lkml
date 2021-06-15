view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  dimension_group: turnaround_time_order_to_completed {
    type: duration
    sql_start: ${created_raw} ;;
    sql_end: ${sold_raw} ;;
    intervals: [second, minute,hour,day]
  }

  measure: median_turnaround_time {
    view_label: "Study Metrics"
    description: "Median Turnaround Time in Minutes from Ordered to Completed"
    type: median
    sql: ${seconds_turnaround_time_order_to_completed} ;;
  }

  measure: median_turnaround_time_ddhhmm {
    view_label: "Study Metrics"
    description: "Median Turnaround Time in Minutes from Ordered to Completed"
    type: number
    sql:

    floor(MEDIAN(${seconds_turnaround_time_order_to_completed})/(60*60*24))::VARCHAR || ' day(s) '

    || floor(MOD(MEDIAN(${seconds_turnaround_time_order_to_completed}),(60*60*24))/(60*60))::VARCHAR || ' hour(s) '

    || floor(MOD(MEDIAN(${seconds_turnaround_time_order_to_completed}),(60*60))/(60))::VARCHAR || ' minute(s) and '

    || MOD(MEDIAN(${seconds_turnaround_time_order_to_completed}),(60))::VARCHAR || ' second(s). '
    ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }

  measure: sum {
    type: sum
    sql: ${cost} ;;
  }
}
