#!/bin/sh

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --output="logs/%j-client.out"
#SBATCH --error="logs/%j-client.err"
#SBATCH --time=00:20:00
#SBATCH --job-name=spark-client

#./get_data.sh
SPARK_HOME="../spark-on-euler/spark_home/spark-3.2.2-bin-hadoop3.2"

master_file=$(ls -t ../spark-on-euler/logs/spark-%j/ | head -1)

url_master=$(cat ../spark-on-euler/logs/spark-%j/$master_file)

mkdir -p tmp

$SPARK_HOME/bin/spark-submit doc_link.py \
           --conf "spark.local.dir=tmp" \
           --master $url_master \
           --driver-memory 20g \
           --executor-memory 20g \
           --num_output_partitions 3 \
           --log_level ERROR \
           --output_format csv \
           --output_compression None \
           ./input/test_warc.txt docs
