# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170420072601) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "mobile_user_id", limit: 4
    t.integer  "country_id",     limit: 4
    t.integer  "state_id",       limit: 4
    t.integer  "city_id",        limit: 4
    t.integer  "locality_id",    limit: 4
    t.integer  "society_id",     limit: 4
    t.integer  "wing_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "flat_no",        limit: 255
    t.integer  "area_id",        limit: 4
  end

  add_index "addresses", ["area_id"], name: "index_addresses_on_area_id", using: :btree
  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree
  add_index "addresses", ["locality_id"], name: "index_addresses_on_locality_id", using: :btree
  add_index "addresses", ["mobile_user_id"], name: "index_addresses_on_mobile_user_id", using: :btree
  add_index "addresses", ["society_id"], name: "index_addresses_on_society_id", using: :btree
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id", using: :btree
  add_index "addresses", ["wing_id"], name: "index_addresses_on_wing_id", using: :btree

  create_table "app_versions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "app_versions", ["name"], name: "index_app_versions_on_name", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "city_id",    limit: 4
    t.boolean  "is_active",  limit: 1,   default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "areas", ["city_id"], name: "index_areas_on_city_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.integer  "mobile_user_id", limit: 4
    t.string   "auth_token",     limit: 255
    t.string   "uuid",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "devise_token",   limit: 255
    t.string   "os",             limit: 255
  end

  add_index "authentications", ["mobile_user_id"], name: "index_authentications_on_mobile_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "is_active",  limit: 1,   default: true
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "cms_contents", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "page_id",     limit: 4
    t.integer  "service_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "cms_contents", ["page_id"], name: "index_cms_contents_on_page_id", using: :btree
  add_index "cms_contents", ["service_id"], name: "index_cms_contents_on_service_id", using: :btree

  create_table "cms_pages", force: :cascade do |t|
    t.text     "meta_title",       limit: 65535
    t.text     "meta_description", limit: 65535
    t.text     "meta_keyword",     limit: 65535
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",             limit: 255
    t.string   "profile",          limit: 255
    t.string   "video",            limit: 255
    t.integer  "service_id",       limit: 4
  end

  add_index "cms_pages", ["service_id"], name: "index_cms_pages_on_service_id", using: :btree
  add_index "cms_pages", ["slug"], name: "index_cms_pages_on_slug", using: :btree

  create_table "cms_pictures", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "page_id",    limit: 4
  end

  add_index "cms_pictures", ["page_id"], name: "fk_rails_5a487cc209", using: :btree

  create_table "cms_videos", force: :cascade do |t|
    t.string   "video_link", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "page_id",    limit: 4
  end

  add_index "cms_videos", ["page_id"], name: "fk_rails_622db2c244", using: :btree

  create_table "complaint_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_active",   limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "complaints", force: :cascade do |t|
    t.integer  "mobile_user_id",        limit: 4
    t.integer  "user_id",               limit: 4
    t.integer  "complaint_category_id", limit: 4
    t.text     "text",                  limit: 65535
    t.text     "admin_comment",         limit: 65535
    t.boolean  "is_resolved",           limit: 1,     default: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "image",                 limit: 255
    t.boolean  "is_extra_fruit",        limit: 1,     default: false
    t.date     "date"
    t.date     "delivery_date"
    t.string   "fruit_name",            limit: 255
    t.integer  "order_id",              limit: 4
    t.string   "txt_id",                limit: 255
  end

  add_index "complaints", ["is_extra_fruit", "delivery_date"], name: "index_complaints_on_is_extra_fruit_and_delivery_date", using: :btree
  add_index "complaints", ["is_resolved"], name: "index_complaints_on_is_resolved", using: :btree
  add_index "complaints", ["order_id"], name: "index_complaints_on_order_id", using: :btree

  create_table "configurations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "is_active",  limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "sortname",   limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "is_active",  limit: 1,   default: true
  end

  create_table "custom_notifications", force: :cascade do |t|
    t.string   "message",         limit: 255
    t.string   "status",          limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "is_sms",          limit: 1,   default: false
    t.boolean  "is_notification", limit: 1,   default: false
  end

  create_table "daily_deliverables", force: :cascade do |t|
    t.date     "delivery_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "service_id",    limit: 4
  end

  add_index "daily_deliverables", ["service_id"], name: "fk_rails_54bc8f6685", using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.integer  "mobile_user_id",  limit: 4
    t.integer  "pack_id",         limit: 4
    t.integer  "plan_id",         limit: 4
    t.integer  "country_id",      limit: 4
    t.integer  "state_id",        limit: 4
    t.integer  "city_id",         limit: 4
    t.integer  "area_id",         limit: 4
    t.integer  "locality_id",     limit: 4
    t.integer  "society_id",      limit: 4
    t.integer  "wing_id",         limit: 4
    t.integer  "complaint_id",    limit: 4
    t.string   "flat_no",         limit: 255
    t.date     "date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "subscription_id", limit: 4
    t.integer  "referral_id",     limit: 4
  end

  add_index "deliveries", ["area_id"], name: "index_deliveries_on_area_id", using: :btree
  add_index "deliveries", ["city_id"], name: "index_deliveries_on_city_id", using: :btree
  add_index "deliveries", ["complaint_id"], name: "index_deliveries_on_complaint_id", using: :btree
  add_index "deliveries", ["country_id"], name: "index_deliveries_on_country_id", using: :btree
  add_index "deliveries", ["date"], name: "index_deliveries_on_date", using: :btree
  add_index "deliveries", ["locality_id"], name: "index_deliveries_on_locality_id", using: :btree
  add_index "deliveries", ["mobile_user_id"], name: "index_deliveries_on_mobile_user_id", using: :btree
  add_index "deliveries", ["pack_id"], name: "index_deliveries_on_pack_id", using: :btree
  add_index "deliveries", ["plan_id"], name: "index_deliveries_on_plan_id", using: :btree
  add_index "deliveries", ["referral_id"], name: "index_deliveries_on_referral_id", using: :btree
  add_index "deliveries", ["society_id"], name: "index_deliveries_on_society_id", using: :btree
  add_index "deliveries", ["state_id"], name: "index_deliveries_on_state_id", using: :btree
  add_index "deliveries", ["subscription_id"], name: "index_deliveries_on_subscription_id", using: :btree
  add_index "deliveries", ["wing_id"], name: "index_deliveries_on_wing_id", using: :btree

  create_table "faq_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "service_id",  limit: 4
    t.boolean  "is_active",   limit: 1,     default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "faq_categories", ["service_id"], name: "index_faq_categories_on_service_id", using: :btree

  create_table "faq_questions", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.boolean  "is_active",       limit: 1,     default: false
    t.integer  "faq_category_id", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "faq_questions", ["faq_category_id"], name: "index_faq_questions_on_faq_category_id", using: :btree

  create_table "feedback_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_active",   limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "mobile_user_id",       limit: 4
    t.integer  "user_id",              limit: 4
    t.text     "text",                 limit: 65535
    t.text     "admin_comment",        limit: 65535
    t.boolean  "is_resolved",          limit: 1
    t.integer  "feedback_category_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "feedbacks", ["feedback_category_id"], name: "index_feedbacks_on_feedback_category_id", using: :btree
  add_index "feedbacks", ["mobile_user_id"], name: "index_feedbacks_on_mobile_user_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "fruits", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "link",       limit: 255
    t.boolean  "is_active",  limit: 1
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "service_id", limit: 4
  end

  add_index "fruits", ["service_id"], name: "index_fruits_on_service_id", using: :btree

  create_table "fruits_daily_deliverable", force: :cascade do |t|
    t.integer "fruit_id",             limit: 4
    t.integer "daily_deliverable_id", limit: 4
  end

  add_index "fruits_daily_deliverable", ["daily_deliverable_id"], name: "fk_rails_e0683694b1", using: :btree
  add_index "fruits_daily_deliverable", ["fruit_id"], name: "fk_rails_d6972a20b2", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.string   "mobile_number", limit: 255
    t.integer  "count",         limit: 4,   default: 1, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "invitations", ["mobile_number"], name: "index_invitations_on_mobile_number", using: :btree

  create_table "lead_addresses", force: :cascade do |t|
    t.string   "flat_no",    limit: 255
    t.integer  "lead_id",    limit: 4
    t.integer  "country_id", limit: 4
    t.integer  "state_id",   limit: 4
    t.integer  "city_id",    limit: 4
    t.string   "area",       limit: 255
    t.string   "locality",   limit: 255
    t.string   "society",    limit: 255
    t.string   "wing",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "first_name",    limit: 255
    t.string   "last_name",     limit: 255
    t.string   "uuid",          limit: 255
    t.string   "mobile_number", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "localities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "area_id",    limit: 4
    t.boolean  "is_active",  limit: 1,   default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "localities", ["area_id"], name: "index_localities_on_area_id", using: :btree

  create_table "locality_services", force: :cascade do |t|
    t.integer  "service_id",  limit: 4
    t.integer  "locality_id", limit: 4
    t.boolean  "is_active",   limit: 1, default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "locality_services", ["locality_id"], name: "index_locality_services_on_locality_id", using: :btree
  add_index "locality_services", ["service_id"], name: "index_locality_services_on_service_id", using: :btree

  create_table "measurements", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "unit",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "mobile_users", force: :cascade do |t|
    t.string   "mobile_number",  limit: 255
    t.boolean  "is_verified",    limit: 1,     default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "otp_secret_key", limit: 255
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "type",           limit: 255
    t.string   "exceptions",     limit: 255
    t.text     "notes",          limit: 65535
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.string   "body",            limit: 255
    t.text     "actions",         limit: 65535
    t.integer  "mobile_user_id",  limit: 4
    t.integer  "subscription_id", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "payload",         limit: 65535
    t.boolean  "is_viewed",       limit: 1,     default: false
    t.string   "_type",           limit: 255
    t.boolean  "is_actioned",     limit: 1,     default: false
  end

  add_index "notifications", ["mobile_user_id"], name: "index_notifications_on_mobile_user_id", using: :btree
  add_index "notifications", ["subscription_id"], name: "index_notifications_on_subscription_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "user_name",     limit: 255
    t.integer  "product_id",    limit: 4
    t.integer  "plan_id",       limit: 4
    t.integer  "locality_id",   limit: 4
    t.string   "unit",          limit: 255
    t.string   "price",         limit: 255
    t.string   "address",       limit: 255
    t.string   "order_id",      limit: 255
    t.text     "response",      limit: 65535
    t.string   "status",        limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "txt_id",        limit: 255
    t.string   "mobile_number", limit: 255
    t.string   "discount",      limit: 255
    t.integer  "area_id",       limit: 4
    t.string   "product_name",  limit: 255
    t.string   "plan_unit",     limit: 255
    t.string   "plan_price",    limit: 255
    t.date     "delivery_date"
    t.string   "payment_type",  limit: 255
    t.boolean  "is_paid",       limit: 1,     default: false
    t.integer  "city_id",       limit: 4
  end

  add_index "orders", ["area_id"], name: "index_orders_on_area_id", using: :btree
  add_index "orders", ["locality_id"], name: "index_orders_on_locality_id", using: :btree
  add_index "orders", ["plan_id"], name: "index_orders_on_plan_id", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "address",        limit: 65535
    t.string   "contact_number", limit: 255
    t.string   "contact_email",  limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "plan_id",    limit: 4
    t.date     "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "packages", ["plan_id"], name: "index_packages_on_plan_id", using: :btree

  create_table "packs", force: :cascade do |t|
    t.integer  "service_id",  limit: 4
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_active",   limit: 1,     default: true,  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_visible",  limit: 1,     default: false
  end

  add_index "packs", ["service_id"], name: "index_packs_on_service_id", using: :btree

  create_table "payment_histories", force: :cascade do |t|
    t.integer  "subscription_id",   limit: 4
    t.date     "starts_date"
    t.date     "ends_date"
    t.boolean  "is_active",         limit: 1
    t.string   "subscription_type", limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "is_paid",           limit: 1,     default: false
    t.text     "response",          limit: 65535
    t.string   "mode",              limit: 255
    t.string   "status",            limit: 255
    t.string   "payment_type",      limit: 255
    t.string   "price",             limit: 255
    t.string   "pack_name",         limit: 255
    t.string   "order_id",          limit: 255
  end

  add_index "payment_histories", ["subscription_id"], name: "index_payment_histories_on_subscription_id", using: :btree

  create_table "plan_products", force: :cascade do |t|
    t.integer  "product_id",     limit: 4
    t.integer  "package_id",     limit: 4
    t.integer  "measurement_id", limit: 4
    t.date     "date"
    t.integer  "quantity",       limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "plan_products", ["measurement_id"], name: "index_plan_products_on_measurement_id", using: :btree
  add_index "plan_products", ["package_id"], name: "index_plan_products_on_package_id", using: :btree
  add_index "plan_products", ["product_id"], name: "index_plan_products_on_product_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.integer  "pack_id",     limit: 4
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.decimal  "old_price",                 precision: 10
    t.decimal  "price",                     precision: 10
    t.integer  "days",        limit: 4
    t.boolean  "is_active",   limit: 1,                    default: true,  null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.boolean  "is_visible",  limit: 1,                    default: false
    t.integer  "product_id",  limit: 4
    t.integer  "city_id",     limit: 4
  end

  add_index "plans", ["pack_id"], name: "index_plans_on_pack_id", using: :btree
  add_index "plans", ["product_id"], name: "index_plans_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "service_id",    limit: 4
    t.string   "name",          limit: 255
    t.string   "origin",        limit: 255
    t.text     "description",   limit: 65535
    t.boolean  "is_active",     limit: 1,     default: true, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "banner",        limit: 255
    t.string   "listing",       limit: 255
    t.string   "side",          limit: 255
    t.boolean  "is_discounted", limit: 1,     default: true
  end

  add_index "products", ["service_id"], name: "index_products_on_service_id", using: :btree

  create_table "public_holidays", force: :cascade do |t|
    t.date     "holiday_date"
    t.string   "name",         limit: 255
    t.text     "message",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "mobile_user_id", limit: 4
    t.string   "contact",        limit: 255
    t.boolean  "is_converted",   limit: 1,   default: false, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "referred_id",    limit: 4
  end

  add_index "referrals", ["mobile_user_id"], name: "index_referrals_on_mobile_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "seasonal_domains", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "subdomain",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "seasonal_domains", ["name"], name: "index_seasonal_domains_on_name", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "parent_id",   limit: 4
    t.boolean  "is_active",   limit: 1,     default: true, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "societies", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "locality_id",  limit: 4
    t.string   "latitude",     limit: 255
    t.string   "longlatitude", limit: 255
    t.boolean  "is_active",    limit: 1,   default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "societies", ["locality_id"], name: "index_societies_on_locality_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "is_active",  limit: 1,   default: true
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "subscription_pauses", force: :cascade do |t|
    t.integer  "subscription_id",    limit: 4
    t.integer  "mobile_user_id",     limit: 4
    t.date     "date"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "payment_history_id", limit: 4
    t.boolean  "is_natural",         limit: 1, default: true
  end

  add_index "subscription_pauses", ["mobile_user_id"], name: "index_subscription_pauses_on_mobile_user_id", using: :btree
  add_index "subscription_pauses", ["payment_history_id"], name: "index_subscription_pauses_on_payment_history_id", using: :btree
  add_index "subscription_pauses", ["subscription_id"], name: "index_subscription_pauses_on_subscription_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id",          limit: 4
    t.integer  "mobile_user_id",   limit: 4
    t.date     "start_at"
    t.date     "ends_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "payment_type",     limit: 255
    t.string   "payment_status",   limit: 255
    t.string   "otp_secret_key",   limit: 255
    t.boolean  "is_active",        limit: 1,   default: true
    t.boolean  "is_paused",        limit: 1,   default: false
    t.date     "pause_start_date"
    t.date     "pause_end_date"
  end

  add_index "subscriptions", ["mobile_user_id"], name: "index_subscriptions_on_mobile_user_id", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree

  create_table "user_notifications", force: :cascade do |t|
    t.integer "mobile_user_id",         limit: 4, null: false
    t.integer "custom_notification_id", limit: 4, null: false
  end

  add_index "user_notifications", ["custom_notification_id"], name: "index_user_notifications_on_custom_notification_id", using: :btree
  add_index "user_notifications", ["mobile_user_id"], name: "index_user_notifications_on_mobile_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "week_plans", force: :cascade do |t|
    t.integer  "quantity",   limit: 4
    t.string   "days",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "plan_id",    limit: 4
  end

  add_index "week_plans", ["plan_id"], name: "fk_rails_3b6d58830d", using: :btree

  create_table "wings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "society_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "wings", ["society_id"], name: "index_wings_on_society_id", using: :btree

  add_foreign_key "addresses", "areas"
  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "localities"
  add_foreign_key "addresses", "mobile_users"
  add_foreign_key "addresses", "societies"
  add_foreign_key "addresses", "states"
  add_foreign_key "addresses", "wings"
  add_foreign_key "areas", "cities"
  add_foreign_key "authentications", "mobile_users"
  add_foreign_key "cities", "states"
  add_foreign_key "cms_pages", "services"
  add_foreign_key "cms_pictures", "cms_pages", column: "page_id"
  add_foreign_key "cms_videos", "cms_pages", column: "page_id"
  add_foreign_key "complaints", "orders"
  add_foreign_key "daily_deliverables", "services"
  add_foreign_key "deliveries", "areas"
  add_foreign_key "deliveries", "cities"
  add_foreign_key "deliveries", "complaints"
  add_foreign_key "deliveries", "countries"
  add_foreign_key "deliveries", "localities"
  add_foreign_key "deliveries", "mobile_users"
  add_foreign_key "deliveries", "packs"
  add_foreign_key "deliveries", "plans"
  add_foreign_key "deliveries", "referrals"
  add_foreign_key "deliveries", "societies"
  add_foreign_key "deliveries", "states"
  add_foreign_key "deliveries", "wings"
  add_foreign_key "faq_categories", "services"
  add_foreign_key "faq_questions", "faq_categories"
  add_foreign_key "feedbacks", "feedback_categories"
  add_foreign_key "feedbacks", "mobile_users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "fruits", "services"
  add_foreign_key "fruits_daily_deliverable", "daily_deliverables"
  add_foreign_key "fruits_daily_deliverable", "fruits"
  add_foreign_key "localities", "areas"
  add_foreign_key "locality_services", "localities"
  add_foreign_key "locality_services", "services"
  add_foreign_key "notifications", "mobile_users"
  add_foreign_key "notifications", "subscriptions"
  add_foreign_key "orders", "areas"
  add_foreign_key "orders", "localities"
  add_foreign_key "orders", "plans"
  add_foreign_key "orders", "products"
  add_foreign_key "packages", "plans"
  add_foreign_key "packs", "services"
  add_foreign_key "payment_histories", "subscriptions"
  add_foreign_key "plan_products", "measurements"
  add_foreign_key "plan_products", "packages"
  add_foreign_key "plan_products", "products"
  add_foreign_key "plans", "packs"
  add_foreign_key "plans", "products"
  add_foreign_key "products", "services"
  add_foreign_key "referrals", "mobile_users"
  add_foreign_key "societies", "localities"
  add_foreign_key "states", "countries"
  add_foreign_key "subscription_pauses", "mobile_users"
  add_foreign_key "subscription_pauses", "payment_histories"
  add_foreign_key "subscription_pauses", "subscriptions"
  add_foreign_key "subscriptions", "mobile_users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "week_plans", "plans"
  add_foreign_key "wings", "societies"
end
