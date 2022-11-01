#!/bin/sh

 /usr/local/Cellar/apache-spark/3.3.1/bin/spark-submit ./html_tag_count.py \
                                   --num_output_partitions 1 --log_level ERROR \
                                   --output_format csv \
                                   --output_compression None \
                                   ./input/test_warc.txt servernames