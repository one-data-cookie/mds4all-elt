with
rnk as (
    select
        *,
        rank() over (
            partition by
                year,
                state,
                district
            order by
                votes_tally desc
        ) as pos
    from
        {{ ref('stg_us_elections_house') }}
),

final as (
    select
        year,
        party,
        count(*) as seats
    from
        rnk
    where
        pos = 1
    group by
        year,
        party
)

select * from final
