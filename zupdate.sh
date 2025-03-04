#!/bin/bash

su - zimbra -c "zmcontrol status" > "/log/zimbra/zimbra_status_$(date +'%d-%m-%y-%H-%M-%S').txt"
