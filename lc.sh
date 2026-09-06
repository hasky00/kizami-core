#!/usr/bin/env bash
python3 -c "import json;d=json.load(open('_build/default/hardware.pnr'))['utilization'];[print(k,v['used'],'/',v['available']) for k,v in d.items() if v['used']]"
