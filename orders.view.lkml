view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: shipment_cateory_picker {
    label: "{% if     shipment_cateory_parameter._parameter_value == \"'STD4'\"   %} Standard Transit Days 4+ Tier
    {% elsif  shipment_cateory_parameter._parameter_value == \"'STD7'\"   %} Standard Transit Days 7+ Tier
    {% elsif  shipment_cateory_parameter._parameter_value == \"'AMC'\"    %} Absolute Minimum Charge (AMC)
    {% elsif  shipment_cateory_parameter._parameter_value == \"'ELS'\"    %} Extended Length Shipment (ELS)
    {% elsif  shipment_cateory_parameter._parameter_value == \"'FAK'\"    %} Freight All Kinds (FAK)
    {% elsif  shipment_cateory_parameter._parameter_value == \"'XLF'\"    %} Accessorial Lineal Foot (XLF)
    {% elsif  shipment_cateory_parameter._parameter_value == \"'XSS'\"    %} Accessorial Dynamic Pricing (XSS)
    {% endif %}"
    description: "Shipment Category Picker"
    type:  string
    sql:  {% if     shipment_cateory_parameter._parameter_value == "'STD4'" %}  ${transit_day_tier}
          {% elsif  shipment_cateory_parameter._parameter_value == "'STD7'" %}  ${transit_day_seven_tier}
          {% elsif  shipment_cateory_parameter._parameter_value == "'AMC'"  %}  CASE WHEN ${is_shpmt_amc}  THEN 'Yes' ELSE 'No' END
          {% elsif  shipment_cateory_parameter._parameter_value == "'ELS'"  %}  CASE WHEN ${is_accsrl_els} THEN 'Yes' ELSE 'No' END
          {% elsif  shipment_cateory_parameter._parameter_value == "'FAK'"  %}  CASE WHEN ${is_shpmt_fak}  THEN 'Yes' ELSE 'No' END
          {% elsif  shipment_cateory_parameter._parameter_value == "'XLF'"  %}  CASE WHEN ${is_accsrl_xlf} THEN 'Yes' ELSE 'No' END
          {% elsif  shipment_cateory_parameter._parameter_value == "'XSS'"  %}  CASE WHEN ${is_accsrl_xss} THEN 'Yes' ELSE 'No' END
          {% endif %} ;;
  }

  parameter: shipment_cateory_parameter {
    type: string
    label: "Shipment Category Parameter"
    description: "A shipment category selection for the charts/tables."
    allowed_value: { label: "AMC"           value: "AMC"    }
    allowed_value: { label: "ELS"           value: "ELS"    }
    allowed_value: { label: "FAK"           value: "FAK"    }
    allowed_value: { label: "XLF"           value: "XLF"    }
    allowed_value: { label: "XSS"           value: "XSS"    }
    allowed_value: { label: "Std. Transit Days 4+"       value: "STD4"   }
    allowed_value: { label: "Std. Transit Days 7+"       value: "STD7"   }
  }


  dimension: transit_day_seven_tier {
    label: "Standard Transit Day 7+ Tier"
    description: "The number of business days it should take to move a shipment broken out by tiers"
    group_label: "Transit"
    type: string
    case: {
      when: {
        # sql: ${TABLE}.STANDARD_TRANSIT_DAYS <= 1 ;;
        sql: ${TABLE}.id < 1000 ;;
        label: "1 Next Day"
      }
      when: {
        # sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 2 ;;
        sql: ${TABLE}.id >= 1000 AND ${TABLE}.id < 2000 ;;
        label: "2 Day"
      }
      when: {
        # sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 3 ;;
        sql: ${TABLE}.id >= 2000 AND ${TABLE}.id < 3000 ;;
        label: "3 Day"
      }
      when: {
        # sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 4 ;;
        sql: ${TABLE}.id >= 3000 AND ${TABLE}.id < 4000 ;;
        label: "4 Day"
      }
      when: {
        # sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 5 ;;
        sql: ${TABLE}.id >= 4000 AND ${TABLE}.id < 5000 ;;
        label: "5 Day"
      }
      when: {
        # sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 6 ;;
        sql: ${TABLE}.id >= 5000 AND ${TABLE}.id < 6000 ;;
        label: "6 Day"
      }
      else:"7+ Day"
    }
  }

  dimension: transit_day_tier {
    label: "Standard Transit Day Tier"
    description: "The number of business days it should take to move a shipment broken out by tiers"
    group_label: "Transit"
    type: string
    case: {
      when: {
        sql: ${TABLE}.STANDARD_TRANSIT_DAYS <= 1 ;;
        label: "1 Next Day"
      }
      when: {
        sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 2 ;;
        label: "2 Day"
      }
      when: {
        sql:  ${TABLE}.STANDARD_TRANSIT_DAYS = 3 ;;
        label: "3 Day"
      }
      else:"4+ Day"
    }
  }

  dimension: is_shpmt_amc {
    label: "AMC Indicator"
    group_label: "Shipment Codes, Qualifiers, and Indicators"
    group_item_label: "AMC Indicator"
    description: "Absolute Minimum Charge (AMC) Indicator set to 'Yes' if a shipment was
    rated at the absolute minimum charge per the pricing agreement."
    type: yesno
    # sql: ${TABLE}.IS_SHPMT_AMC = true ;;
    sql: ${TABLE}.status = "cancelled" ;;
  }


  dimension: is_accsrl_els {
    label: "Accessorial Extended Length Shipment (ELS) Indicator"
    group_label: "Accessorial Indicator"
    group_item_label: "Extended Length Shipment (ELS)"
    description: "Accessorial Extended Length Shipment (ELS) Indicator is set to 'Yes' if the shipment has an ELS accessorial code.
    Does not mean that shipments more than 8 feet in length have this accessorial code. Reference the Shipment Long Indicator."
    type: yesno
    # sql: ${TABLE}.IS_ACCSRL_ELS = true ;;
    sql: ${TABLE}.status = "complete" ;;
  }

  dimension: is_accsrl_xlf {
    label: "Accessorial Lineal Foot (XLF) Indicator"
    group_label: "Accessorial Indicator"
    group_item_label: "Lineal Foot (XLF)"
    description: "Accessorial Lineal Foot (XLF) Indicator is set to 'Yes' if the shipment has an XLF accessorial code."
    type: yesno
    # sql: ${TABLE}.IS_ACCSRL_XLF = true ;;
    sql: ${TABLE}.status = "pending" ;;
  }

  dimension: is_shpmt_fak {
    label: "Shipment Commodity FAK Indicator"
    group_label: "Shipment Codes, Qualifiers, and Indicators"
    group_item_label: "Commodity FAK Indicator"
    description: "Shipment Commodity Freight All Kinds (FAK) Indicator is set to 'Yes' when there is at least one
    commodity in the shipment with a rated class different than its actual class."
    type: yesno
    # sql: ${TABLE}.IS_SHPMT_FAK = true ;;
    sql: ${TABLE}.status = "cancelled" ;;
  }

  dimension: is_accsrl_xss {
    label: "Accessorial Dynamic Pricing (XSS) Indicator"
    group_label: "Accessorial Indicator"
    description: "Accessorial Dynamic Pricing (XSS) Indicator is set to 'Yes' if the shipment has an XSS accessorial code."
    type: yesno
    # sql: ${TABLE}.IS_ACCSRL_XSS = true ;;
    sql: ${TABLE}.status = "pending" ;;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_complete {
    type: yesno
    sql: ${status}="complete" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
  }
}
