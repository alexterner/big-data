# To start interacting with Kafka, open a new terminal window and issue the following command
docker run --rm -it --net=host landoop/fast-data-dev bash
 
# ----------------------------------------------------
# Create a new topic
# ----------------------------------------------------
kafka-topics \
--zookeeper 127.0.0.1:2181 \
--create --topic first_topic \
--partitions 3 \
--replication-factor 1
 
kafka-topics \
--zookeeper 127.0.0.1:2181 \
--create --topic second_topic \
--partitions 3 \
--replication-factor 1
 
# ----------------------------------------------------
# Verify its been created 
# ----------------------------------------------------
# Use the UI
# Alternatively use the following command
kafka-topics --zookeeper 127.0.0.1:2181 --list
 
# ----------------------------------------------------
# Delete a topic
# ----------------------------------------------------
kafka-topics --zookeeper 127.0.0.1:2181 --topic second_topic --delete 
 
# More on how to delete a topic in Kafka :
# https://stackoverflow.com/questions/24287900/delete-topic-in-kafka-0-8-1-1
 
# ----------------------------------------------------
# Describe a topic
# ----------------------------------------------------
kafka-topics --zookeeper 127.0.0.1:2181 \
--describe \
--topic first_topic
 
 
# ----------------------------------------------------
# kafka-console-producer 
# ----------------------------------------------------
# Enter values and check the output against the UI
 
# request-required-acks : 1   - producer will wait for leader acknowledgement 
#                       : 0   - producer won’t wait for acknowledgement 
#                       : all - producer will wait for leader + replicas acknowledgement
 
 
# Basic producer 
kafka-console-producer \
--broker-list 127.0.0.1:9092 \
--topic first_topic \
--request-required-acks 0
 

# ----------------------------------------------------
# kafka-console-consumer
# ---------------------------------------------------- 
 
kafka-console-consumer \
--bootstrap-server 127.0.0.1:9092 \
--topic first_topic \
--from-beginning 
