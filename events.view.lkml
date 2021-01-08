view: events {
  sql_table_name: demo_db.events ;;

  dimension: browser {
    view_label: "Visitors"
    sql: ${TABLE}.browser ;;
  }

  measure: unique_visitors {
    type: count_distinct
    description: "Uniqueness determined by IP Address and User Login"
    view_label: "Visitors"
    sql: ${ip} ;;
    drill_fields: [visitors*]
  }

  dimension: ip {
    label: "IP Address"
    view_label: "Visitors"
    sql: ${TABLE}.user_id ;;
  }

  set: visitors {
    fields: [ip, os, browser, user_id, count]
  }

  dimension: os {
    label: "Operating System"
    view_label: "Visitors"
    sql: ${TABLE}.os ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }

  dimension_group: event {
    type: time
#     timeframes: [time, date, hour, time_of_day, hour_of_day, week, day_of_week_index, day_of_week]
    sql: ${TABLE}.created_at ;;
  }


  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    # required_access_grants: [can_see_team_lead_payout]

    drill_fields: [id, users.first_name, users.id, users.last_name]
  }
}
