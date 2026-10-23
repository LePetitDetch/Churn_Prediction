with customers as (

    select * from {{ ref('stg_customers') }}

),

features as (

    select
        customer_id,

        -- Profil
        gender,
        is_senior_citizen,
        has_partner,
        has_dependents,

        -- Contrat
        tenure_months,
        contract_type,
        has_paperless_billing,
        payment_method,

        -- Services
        internet_service,
        has_phone_service,
        has_multiple_lines,
        has_online_security,
        has_online_backup,
        has_device_protection,
        has_tech_support,
        has_streaming_tv,
        has_streaming_movies,

        -- Features calculées
        internet_service <> 'No'                     as has_internet,

        cast(has_phone_service as integer)
          + cast(has_multiple_lines as integer)
          + cast(has_online_security as integer)
          + cast(has_online_backup as integer)
          + cast(has_device_protection as integer)
          + cast(has_tech_support as integer)
          + cast(has_streaming_tv as integer)
          + cast(has_streaming_movies as integer)    as nb_services,

        -- Montants
        monthly_charges,
        coalesce(total_charges, 0)                   as total_charges,

        -- Cible
        is_churned

    from customers

)

select * from features