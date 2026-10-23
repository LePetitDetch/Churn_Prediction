with source as (

    select * from {{ source('raw', 'customers') }}

),

renamed as (

    select
        customerID                                   as customer_id,

        -- Profil
        gender,
        SeniorCitizen = '1'                          as is_senior_citizen,
        Partner = 'Yes'                              as has_partner,
        Dependents = 'Yes'                           as has_dependents,

        -- Contrat
        cast(tenure as integer)                      as tenure_months,
        Contract                                     as contract_type,
        PaperlessBilling = 'Yes'                     as has_paperless_billing,
        PaymentMethod                                as payment_method,

        -- Services
        PhoneService = 'Yes'                         as has_phone_service,
        MultipleLines = 'Yes'                        as has_multiple_lines,
        InternetService                              as internet_service,
        OnlineSecurity = 'Yes'                       as has_online_security,
        OnlineBackup = 'Yes'                         as has_online_backup,
        DeviceProtection = 'Yes'                     as has_device_protection,
        TechSupport = 'Yes'                          as has_tech_support,
        StreamingTV = 'Yes'                          as has_streaming_tv,
        StreamingMovies = 'Yes'                      as has_streaming_movies,

        -- Montants
        cast(MonthlyCharges as decimal(10, 2))       as monthly_charges,
        cast(nullif(trim(TotalCharges), '') as decimal(10, 2)) as total_charges,

        -- Cible
        Churn = 'Yes'                                as is_churned

    from source

)

select * from renamed