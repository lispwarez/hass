#!/bin/bash

mysql --user=hass --password=CjqCMz78c4 --database=homeassistant --execute="DELETE states.*,events.* FROM states INNER JOIN events USING(event_id) WHERE entity_id in ('sensor.stats_power_output','sensor.stats_power_solar','sensor.stats_power_output_hourly','sensor.stats_power_solar_hourly','sensor.stats_poolpump_duration') AND state='unknown';"
mysql --user=hass --password=CjqCMz78c4 --database=homeassistant --execute="DELETE events.* FROM events LEFT JOIN states USING(event_id) WHERE isnull(states.event_id) AND time_fired<date_sub(utc_timestamp(), interval 7 day);"
mysql --user=hass --password=CjqCMz78c4 --database=homeassistant --execute="DELETE states.*,events.* FROM states INNER JOIN events USING(event_id) WHERE last_updated<date_sub(utc_timestamp(), interval 7 day) AND entity_id NOT IN ('sensor.stats_power_solar','sensor.stats_power_output','sensor.stats_power_output_hourly','sensor.stats_power_solar_hourly','sensor.stats_poolpump_duration');"
mysql --user=hass --password=CjqCMz78c4 --database=homeassistant --execute="DELETE states.*,events.* FROM states INNER JOIN events USING(event_id) WHERE last_updated<date_sub(utc_timestamp(), interval 2 day) AND (entity_id like '%sensor.axpert_%' OR entity_id like 'sensor.ups_%' OR entity_id IN ('sensor.load_1m','sensor.memory_use','proximity.lisp_home','weather.openweathermap'));"