#!/usr/bin/env python

import os
import base64
import json
import random

patient_range = range(1000000001,1000000135)

records = []

directory = '/path/to/GRASCCO'
for filename in os.listdir(directory):
    if filename.endswith('.txt'):
        with open(os.path.join(directory, filename)) as f:
            document = f.read().encode("utf-8")

            records.append({
              "resource": {
                "resourceType": "DocumentReference",
                "id": filename[:-4],
                "status": "current",
                "subject": {
                  "reference": f"Patient/{random.choice(patient_range)}"
                },
                "content": [
                  {
                    "attachment": {
                      "data": base64.b64encode(document).decode("ascii")
                    }
                  }
                ]
              }
            })
            

bundle = {
  "resourceType": "Bundle",
  "id": "demo",
  "type": "collection",
  "entry": records
}


# Serializing json
json_object = json.dumps(bundle, indent=2)

# Writing to sample.json
with open("sample.json", "w") as outfile:
    outfile.write(json_object)
