# Kafka Operations Script

This script facilitates various Kafka operations based on user input. It supports setting up authentication, listing topics, describing topics, listing ACLs, creating topics, producing to topics, running producer performance tests, and running consumer performance tests.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Required Inputs](#required-inputs)
- [Operations](#operations)
- [Examples](#examples)

## Prerequisites

Before using this script, ensure you have the following prerequisites:

- Kafka installed on your system
- `kafka-topics.sh` and `kafka-acls.sh` commands available in your system PATH or provide the Kafka installation path when prompted.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/aashishchhabra/kafka-tools.git
   cd kafka-tools
2. Ensure execute permissions for the script:

   ```bash
   chmod +x kafka_operations.sh
   ```

## Required Inputs
**Bootstrap Server:** The Kafka bootstrap server to connect to. It can be an IPv4 address or a valid fully qualified domain name (FQDN).
**Bootstrap Port:** The port number for the Kafka bootstrap server.
**Authentication Type:** 'kerberos' or 'scram' for Kerberos or SCRAM authentication.

## Operations
This script supports the following operations:

1. List Topics
2. Describe Topics
3. List ACLs
4. Create Topic
5. Produce to Topic
6. Producer Perf Test
7. Consumer Perf Test

## Examples
### Example 1: List Topics

   ```bash
   ./kafka_operations.sh
   ```
Follow the prompts and select the operation "list topics" by entering 1 to see a list of all topics on the Kafka cluster.

### Example 2: Describe Topic

   ```bash
   ./kafka_operations.sh
   ```
Follow the prompts, select the operation "describe topics," by entering 2 and provide the topic name when prompted to describe a specific topic.




