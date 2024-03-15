# Kafka Authentication Commands

## Kerberos Authentication

### Prerequisites
- Kerberos server setup
- Kafka configured to use Kerberos authentication

### Commands

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config auth/kerberos/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config auth/kerberos/client.properties
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --command-config auth/kerberos/client.properties
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --command-config auth/kerberos/client.properties
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

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config auth/scram/client.properties
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config auth/scram/client.properties
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --command-config auth/scram/client.properties
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --command-config auth/scram/client.properties
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
