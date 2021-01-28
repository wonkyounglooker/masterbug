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


  parameter: measure_1 {
    type: unquoted
    view_label: "(0) Dashboard Parameters"
    allowed_value: {label: "BV cases" value: "bv_cases"}
    # allowed_value: {label: "New Patients" value: "new_patients"}
    # allowed_value: {label: "Existing Patients" value: "existing_patients"}
    # allowed_value: {label: "LYO" value: "lyo"}
    # allowed_value: {label: "PFS" value: "pfs"}
    # allowed_value: {label: "Reverifications" value: "reverifications"}
    allowed_value: {label: "Fax" value: "fax"}
    allowed_value: {label: "Portal" value: "portal"}
    # allowed_value: {label: "PA Required" value: "pa_required"}
    # allowed_value: {label: "PA Denied" value: "pa_denied"}
    # allowed_value: {label: "PA Approved" value: "pa_approved"}
    # allowed_value: {label: "PA Support" value: "pa_support"}
    # allowed_value: {label: "CD" value: "cd"}
    # allowed_value: {label: "RA" value: "ra"}
    # allowed_value: {label: "AS" value: "as"}
    # allowed_value: {label: "Ps" value: "ps"}
    # allowed_value: {label: "nr-axSpA" value: "nr_axspa"}
    # allowed_value: {label: "Patient Consent (Y)" value: "patient_consent_y"}
    # allowed_value: {label: "Patient Consent (N)" value: "patient_consent_n"}
    default_value: "fax"
  }
  parameter: measure_2 {
    type: unquoted
    view_label: "(0) Dashboard Parameters"
    allowed_value: {label: "BV cases" value: "bv_cases"}
    # allowed_value: {label: "New Patients" value: "new_patients"}
    # allowed_value: {label: "Existing Patients" value: "existing_patients"}
    # allowed_value: {label: "LYO" value: "lyo"}
    # allowed_value: {label: "PFS" value: "pfs"}
    # allowed_value: {label: "Reverifications" value: "reverifications"}
    allowed_value: {label: "Fax" value: "fax"}
    allowed_value: {label: "Portal" value: "portal"}
    # allowed_value: {label: "PA Required" value: "pa_required"}
    # allowed_value: {label: "PA Denied" value: "pa_denied"}
    # allowed_value: {label: "PA Approved" value: "pa_approved"}
    # allowed_value: {label: "PA Support" value: "pa_support"}
    # allowed_value: {label: "CD" value: "cd"}
    # allowed_value: {label: "RA" value: "ra"}
    # allowed_value: {label: "AS" value: "as"}
    # allowed_value: {label: "Ps" value: "ps"}
    # allowed_value: {label: "nr-axSpA" value: "nr_axspa"}
    # allowed_value: {label: "Patient Consent (Y)" value: "patient_consent_y"}
    # allowed_value: {label: "Patient Consent (N)" value: "patient_consent_n"}
    default_value: "portal"
  }

  measure: dynamic_measure_1 {
    view_label: "(0) Dashboard Parameters"
    type: number
    label_from_parameter: measure_1
    sql: {% if measure_1._parameter_value == 'bv_cases' %} ${trial_subscribers}
          {% elsif measure_1._parameter_value == 'fax' %} ${paid_subscribers}
          {% elsif measure_1._parameter_value == 'portal' %} ${total_subscribers}
          {% endif %};;
  }
  measure: dynamic_measure_2 {
    view_label: "(0) Dashboard Parameters"
    type: number
    label_from_parameter: measure_2
    sql: {% if measure_2._parameter_value == 'bv_cases' %} ${trial_subscribers}
    {% elsif measure_2._parameter_value == 'fax' %} ${paid_subscribers}
    {% elsif measure_2._parameter_value == 'portal' %} ${total_subscribers}
    {% endif %};;
  }

  measure: trial_subscribers {
    type: sum
    sql: ${products.retail_price}  ;;
  }

  measure: paid_subscribers {
    type: sum
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_subscribers {
    label: "Daily Total Subscribers"
    type: number
    sql: ${trial_subscribers} + ${paid_subscribers} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
