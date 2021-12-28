select
    parse_date('%Y', cast(year as string)) as year,
    initcap(candidate) as candidate,
    initcap(party) as party,
    initcap(state) as state,
    state_po,
    coalesce(cast(district as string), '1') as district,
    cast(candidatevotes as integer) as votes_tally,
    totalvotes as votes_total,
    round(cast(candidatevotes as numeric) / cast(totalvotes as numeric), 2) as votes_perc
from
    {{ source('mds4all', 'mit_us_elections_house') }}
where
    writein = 'FALSE'
    and totalvotes != 0
