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
        ) AS pos
    from
        {{ ref('stg_us_elections_president') }}
),

final as (
    select
        year,
        party,
        count(*) as popular_votes
    from
        rnk
    where
        pos = 1
    group by
        year,
        party
)

select * from final
