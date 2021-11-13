-- edwiser site report
-- MySQL

select FROM_UNIXTIME(time) as time
,cpu, memory, storage
from prefix_block_edwiser_site_monitor

ORDER BY time DESC
