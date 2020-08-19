#!/bin/bash -xe

yum install -y python37
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
git clone https://github.com/eloyvega/bootcamp-devops.git
cd ~/bootcamp-devops/backend/
pip install -r requirements.txt
nohup gunicorn -w 3 -b 0.0.0.0:8000 app:app &