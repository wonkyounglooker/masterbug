connection: "thelook"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
# datagroup: won_bug_default_datagroup {
#   sql_trigger: SELECT FLOOR(UNIX_TIMESTAMP() / (0.1*60*60))
#     FROM demo_db.users;;
#   max_cache_age: "1 hour"
# }

# explore: users_derived {
#
# }
