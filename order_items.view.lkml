view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, hour, date, week, month, year, hour_of_day, day_of_week, month_num, month_name, raw, week_of_year]


    sql: ${TABLE}.returned_at ;;
    convert_tz: no
  }
  dimension: play_call {
    type: string
    sql: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3" ;;
    html:
          <audio controls preload="metadata" style="width:100%; min-width: 300px;">
            <source src="{{ value }}" type="audio/mp3" />
          </audio> ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
