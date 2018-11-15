#!/bin/bash
sudo apt-get update
sudo apt-get install tmux

pip install kaggle --upgrade
pip install requests==2.17.3
conda install -y -c haasad eidl7zip

sudo /opt/anaconda3/bin/conda install -c fastai fastai

#You need to upload your Kaggle credentials on your instance. Login to kaggle and click on your profile picture on the top left corner, then 'My account'. 
#Scroll down until you find a button named 'Create New API Token' and click on it. This will trigger the download of a file named 'kaggle.json'.
#Upload this file to the directory this notebook is running in, by clicking "Upload" on your main Jupyter page.

mkdir -p ~/.kaggle/
mv kaggle.json ~/.kaggle/

mkdir data
cd data/

data_path=`pwd`

kaggle competitions download -c planet-understanding-the-amazon-from-space -f train-jpg.tar.7z -p "$data_path"
kaggle competitions download -c planet-understanding-the-amazon-from-space -f train_v2.csv -p "$data_path"
kaggle competitions download -c planet-understanding-the-amazon-from-space -f test-jpg.tar.7z -p "$data_path"
kaggle competitions download -c planet-understanding-the-amazon-from-space -f test-jpg-additional.tar.7z -p "$data_path"

7za -bd -y -so x "$data_path"/train-jpg.tar.7z | tar xf - -C "$data_path"
7za -bd -y -so x "$data_path"/test-jpg.tar.7z | tar xf - -C "$data_path"
7za -bd -y -so x "$data_path"/test-jpg-additional.tar.7z | tar xf - -C "$data_path"
unzip -q -n "$data_path"/train_v2.csv.zip -d {$data_path}

rsync -aP "$data_path"/test-jpg-additional/ "$data_path"/test-jpg/