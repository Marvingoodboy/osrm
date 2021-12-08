#!/bin/bash
FILE=moldova-latest.osm.pbf
if [ -f ./data/$FILE ]; then
echo "File > $FILE exist"
else
echo "File dont exist"
wget -P ./data http://download.geofabrik.de/europe/moldova-latest.osm.pbf
fi

OSRMF=moldova-latest.osrm
if [ -f ./data/$OSRMF ]; then
echo "File > $OSRMF exist"
else
echo "File dont exist"
docker run --rm -t -v "${PWD}/data:/data" osrm/osrm-backend osrm-extract -p /opt/foot.lua /data/$FILE
docker run --rm -t -v "${PWD}/data:/data" osrm/osrm-backend osrm-partition /data/$OSRMF
docker run --rm -t -v "${PWD}/data:/data" osrm/osrm-backend osrm-customize /data/$OSRMF
fi
docker-compose up -d
