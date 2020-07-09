#!/bin/bash

director_name='micro-bosh'

bosh -e ${director_name} update-runtime-config ./remove-all-addons.yml
