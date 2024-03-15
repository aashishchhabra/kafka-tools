# Kafka Authentication Commands

## Kerberos Authentication

### Prerequisites
- Kerberos server setup
- Kafka configured to use Kerberos authentication

### Commands

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config <path-to-kerberos-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config <path-to-kerberos-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config <path-to-kerberos-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config <path-to-kerberos-config-file>
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --command-config <path-to-kerberos-config-file>
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --command-config <path-to-kerberos-config-file>
```

#### kafka-console-producer.sh

```bash
kafka-console-producer.sh --broker-list <broker-address> --topic <topic-name> --producer.config <path-to-producer-properties-file> --command-config <path-to-kerberos-config-file>
```

#### kafka-console-consumer.sh

```bash
kafka-console-consumer.sh --bootstrap-server <broker-address> --topic <topic-name> --consumer.config <path-to-consumer-properties-file> --command-config <path-to-kerberos-config-file>
```

## SCRAM Authentication

### Prerequisites
- SCRAM users configured in Kafka
- Kafka configured to use SCRAM authentication

### Commands

#### kafka-topics.sh

```bash
kafka-topics.sh --bootstrap-server <broker-address> --list --command-config <path-to-scram-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --create --topic <topic-name> --partitions <num-partitions> --replication-factor <replication-factor> --command-config <path-to-scram-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --describe --topic <topic-name> --command-config <path-to-scram-config-file>
kafka-topics.sh --bootstrap-server <broker-address> --delete --topic <topic-name> --command-config <path-to-scram-config-file>
```

#### kafka-producer-perf-test.sh

```bash
kafka-producer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --num-records <num-records> --record-size <record-size> --throughput <throughput> --command-config <path-to-scram-config-file>
```

#### kafka-consumer-perf-test.sh

```bash
kafka-consumer-perf-test.sh --broker-list <broker-list> --topic <topic-name> --messages <num-messages> --threads <num-threads> --command-config <path-to-scram-config-file>
```

#### kafka-console-producer.sh

```bash
kafka-console-producer.sh --broker-list <broker-address> --topic <topic-name> --producer.config <path-to-producer-properties-file> --command-config <path-to-scram-config-file>
```

#### kafka-console-consumer.sh

```bash
kafka-console-consumer.sh --bootstrap-server <broker-address> --topic <topic-name> --consumer.config <path-to-consumer-properties-file> --command-config <path-to-scram-config-file>
```

Make sure to replace placeholders like `<broker-address>`, `<topic-name>`, `<num-partitions>`, `<num-records>`, etc., with appropriate values. Also, replace `<path-to-kerberos-config-file>` and `<path-to-scram-config-file>` with the actual paths to your Kerberos and SCRAM configuration files respectively.
