# Kafka Authentication Commands
The paths used in the below document are relative to the repository and might require you to change them according to your environment.

## Kerberos Authentication

### Prerequisites
- Kerberos server setup
- Kafka configured to use Kerberos authentication

### Commands

#### Export relevant jaas.conf file for configuring authentication mechanism as well as authencation credentials
```bash
export KAFKA_OPTS="-Djava.security.auth.login.config=./auth/kerberos/jaas.conf"
```

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config auth/kerberos/client.properties
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --producer-props bootstrap.servers=<broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --producer.config auth/kerberos/client.properties
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --comnsumer.config auth/kerberos/client.properties
```

#### kafka-console-producer.sh

```bash
kafka-console-producer.sh --broker-list <broker-address> --topic <topic-name> --producer.config auth/kerberos/client.properties
```

#### kafka-console-consumer.sh

```bash
kafka-console-consumer.sh --bootstrap-server <broker-address> --topic <topic-name> --consumer.config auth/kerberos/client.properties
```

## SCRAM Authentication

### Prerequisites
- SCRAM users configured in Kafka
- Kafka configured to use SCRAM authentication

### Commands

#### Export relevant jaas.conf file for configuring authentication mechanism as well as authencation credentials
```bash
export KAFKA_OPTS="-Djava.security.auth.login.config=./auth/scram/jaas.conf"
```

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config auth/scram/client.properties
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --producer-props bootstrap.servers=<broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --producer.config auth/scram/client.properties
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --consumer.config auth/scram/client.properties
```

#### kafka-console-producer.sh

```bash
kafka-console-producer.sh --broker-list <broker-address> --topic <topic-name> --producer.config auth/scram/client.properties
```

#### kafka-console-consumer.sh

```bash
kafka-console-consumer.sh --bootstrap-server <broker-address> --topic <topic-name> --consumer.config auth/scram/client.properties
```

Make sure to replace placeholders like `<broker-address>`, `<topic-name>`, `<num-partitions>`, `<num-records>`, etc., with appropriate values. 
