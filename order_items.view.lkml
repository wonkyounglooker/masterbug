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

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [created_month, users.gender, total_sale_price]
    link: {
      label: "Table Calc & Total"
      url: "
      {% assign table_calc = '[
      { \"table_calculation\": \"percent_of_total\",
      \"label\": \"Percent of Total\",
      \"expression\": \"${order_items.total_sale_price:row_total} / sum(${order_items.total_sale_price:row_total})\",
      \"value_format\": null,
      \"value_format_name\": \"percent_2\",
      \"_kind_hint\": \"supermeasure\",
      \"_type_hint\": \"number\"
      },
      { \"table_calculation\": \"growth_rate\",
      \"label\": \"Growth Rate\",
      \"expression\": \"${order_items.total_sale_price} / offset(${order_items.total_sale_price},1) - 1\",
      \"value_format\": null,
      \"value_format_name\": \"percent_2\",
      \"_kind_hint\": \"measure\",
      \"_type_hint\": \"number\"
      }]' %}
      {% assign vis_config = '{
      \"type\": \"table\",
      \"show_view_names\": false,
      \"show_row_numbers\": false,
      \"truncate_column_names\": false,
      \"table_theme\": \"gray\",
      \"enable_conditional_formatting\": true,
      \"conditional_formatting\": [
      {
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
      \"name\": \"Custom\",
      \"colors\": [
      \"#FFFFFF\",
      \"#6e00ff\"
      ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
      \"growth_rate\"
      ]},{
      \"type\": \"low to high\",
      \"value\": null,
      \"background_color\": null,
      \"font_color\": null,
      \"palette\": {
      \"name\": \"Custom\",
      \"colors\": [
      \"#FFFFFF\",
      \"#88ff78\"
      ]},
      \"bold\": false,
      \"italic\": false,
      \"strikethrough\": false,
      \"fields\": [
      \"percent_of_total\"
      ]}]}' %}
      {{link}}&total=on&row_total=right&dynamic_fields={{ table_calc | replace: ' ', '' | encode_uri }}&pivots=users.gender&vis_config={{ vis_config | replace: ' ', '' | encode_uri }}"
    }
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

  measure: T_0{
    group_label: "Markout per Million"
    label: "0"
    type: number
    sql: (${Value_T_0})/NULLIF((${total_usd_amount}),0);;
    value_format_name: value_formatting
    # drill_fields: [trade_id, symbol,usd_amount]
  }

  measure: Value_T_0 {
    group_label: "Value per Million"
    label: "Value 0"
    type: sum
    sql: -1 * ( ${usd_amount} * ${mi_maas_usd_0} ) ;;
    value_format_name: value_per_million_formatting
    # drill_fields: [trade_id, symbol,usd_amount]
  }

  measure: total_usd_amount {
    type: sum
    description: "The total amount of selected trades"
    sql: ${usd_amount} ;;
    value_format_name: usd_0
  }

  dimension: mi_maas_usd_0 {
    group_label: "MAAS"
    type: number
    # sql: ${TABLE}."MI_MAAS_USD_0" ;;
    sql: ${TABLE}.sale_price ;;
    value_format: "#,##0;(#,##0)"
    label: "MAAS 0s"
    hidden: yes
  }

  dimension: usd_amount {
    type: number
    # sql: ${TABLE}."USD_AMOUNT" ;;
    sql: ${TABLE}.order_id ;;
    value_format: "#,##0;(#,##0)"
    hidden: yes
  }


}
