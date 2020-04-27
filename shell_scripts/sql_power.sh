#!/bin/bash

mysql --user=hass --password=CjqCMz78c4 --database=homeassistant --execute="INSERT INTO prepaid_power_usage (used) VALUES ($1)"
