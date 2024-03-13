#!/bin/bash

ROOT_DIR=$(pwd)

# Function to display help documentation
function display_help() {
    echo "Usage: $0"
    echo "  - Prompts for bootstrap server, port, authentication type, and operation."
    echo ""
    echo "Description:"
    echo "  This script sets up Kafka authentication based on the provided parameters and executes"
    echo "  various operations against the specified Kafka bootstrap server."
    echo ""
    echo "Required Inputs:"
    echo "  - Bootstrap Server: The Kafka bootstrap server to connect to. It can be an IPv4 address"
    echo "                      or a valid fully qualified domain name (FQDN)."
    echo "  - Bootstrap Port:   The port number for the Kafka bootstrap server."
    echo "  - Authentication Type: 'kerberos' or 'scram' for Kerberos or SCRAM authentication."
    echo ""
    echo "Available Operations:"
    echo "  1. List Topics"
    echo "  2. Describe Topics"
    echo "  3. List ACLs"
    echo "  4. Create Topic"
    echo "  5. Produce to Topic"
    echo "  6. Producer Perf Test"
    echo "  7. Consumer Perf Test"
    echo ""
    echo "Examples:"
    echo "  $0"
    echo "    - Prompts for bootstrap server, port, authentication type, and operation."
    echo ""
    echo "  $0"
    echo "    - Bootstrap Server: kafka.example.com"
    echo "    - Bootstrap Port:   9092"
    echo "    - Authentication Type: kerberos"
    echo "    - Operation: 1"
    echo "    - Sets up Kerberos authentication and lists all topics on the Kafka cluster."
    exit 1
}

# Function to validate IPv4 address or FQDN
function validate_bootstrap_server() {
    local input=$1

    # Check if the input is an IPv4 address
    if [[ $input =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0
    fi

    # Check if the input is a valid FQDN
    if [[ $input =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    fi

    return 1
}

# Function to check if a command is available
function is_command_available() {
    command -v "$1" > /dev/null 2>&1
}

# Function to setup authentication
function setup_authentication() {
    local auth_type=$1

    case "$auth_type" in
        "kerberos")
            echo "Setting up Kerberos authentication..."

            # Assuming these files are located in the same directory as the script
            export jaas_file="$ROOT_DIR/auth/kerberos/jaas.conf"
            export client_properties_file="$ROOT_DIR/auth/kerberos/client.properties"
            export keytab_file="$ROOT_DIR/auth/kerberos/kafka.keytab"
            export KAFKA_OPTS="-Djava.security.auth.login.config=$jaas_file"

            # Add your Kerberos setup commands here
            # For example:
            # kinit -kt "$keytab_file" "$kerberos_principal"

            ;;
        "scram")
            echo "Setting up SCRAM authentication..."

            # Assuming these files are located in the same directory as the script
            export jaas_file="$ROOT_DIR/auth/scram/jaas.conf"
            export client_properties_file="$ROOT_DIR/auth/scram/client.properties"
            export KAFKA_OPTS="-Djava.security.auth.login.config=$jaas_file"

            # Add your SCRAM setup commands here

            ;;
        *)
            echo "Invalid authentication type."
            exit 1
            ;;
    esac
}

# Function to create ACLs for producer and consumer
function create_acls() {
    local topic_name=$1
    local scram_user_name=$2

    # Adding ACL for producer
    "$KAFKA_ACLS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" \
        --add --allow-principal "User:$scram_user_name" --operation Write --topic "$topic_name" \
        --command-config "$client_properties_file"

    # Adding ACL for consumer
    "$KAFKA_ACLS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" \
        --add --allow-principal "User:$scram_user_name" --operation Read --topic "$topic_name" \
        --command-config "$client_properties_file"
}

# Check if the script is being run with arguments
if [ "$#" -ne 0 ]; then
    display_help
fi

# Check if kafka-topics.sh command is available
if is_command_available "kafka-topics"; then
    KAFKA_TOPICS_CMD="kafka-topics"
else
    # Prompt for the Kafka installation path
    read -p "Enter Kafka Installation Path (if not in system PATH): " kafka_installation_path
    if [ -z "$kafka_installation_path" ]; then
        echo "Error: Kafka installation path cannot be empty."
        exit 1
    elif [ ! -x "$kafka_installation_path/bin/kafka-topics.sh" ]; then
        echo "Error: Unable to find kafka-topics.sh in the specified Kafka installation path."
        exit 1
    fi
    KAFKA_TOPICS_CMD="$kafka_installation_path/bin/kafka-topics.sh"
fi

# Check if kafka-acls.sh command is available
if is_command_available "kafka-acls"; then
    KAFKA_ACLS_CMD="kafka-acls"
else
    # Prompt for the Kafka installation path
    read -p "Enter Kafka Installation Path (if not in system PATH): " kafka_installation_path
    if [ -z "$kafka_installation_path" ]; then
        echo "Error: Kafka installation path cannot be empty."
        exit 1
    elif [ ! -x "$kafka_installation_path/bin/kafka-acls.sh" ]; then
        echo "Error: Unable to find kafka-acls.sh in the specified Kafka installation path."
        exit 1
    fi
    KAFKA_ACLS_CMD="$kafka_installation_path/bin/kafka-acls.sh"
fi

# Prompt for bootstrap server and validate
read -p "Enter Bootstrap Server: " bootstrap_server
if [ -z "$bootstrap_server" ]; then
    echo "Error: Bootstrap server cannot be empty."
    exit 1
elif ! validate_bootstrap_server "$bootstrap_server"; then
    echo "Error: Invalid bootstrap server. Please provide either a valid IPv4 address or a valid fully qualified domain name (FQDN)."
    exit 1
fi

# Prompt for bootstrap port and validate
read -p "Enter Bootstrap Port: " bootstrap_port
if [ -z "$bootstrap_port" ] || ! [[ "$bootstrap_port" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid or empty bootstrap port. Please provide a valid numeric port."
    exit 1
fi

# Prompt for authentication type
read -p "Enter Authentication Type (kerberos/scram): " auth_type

# Validate authentication type
if [ "$auth_type" != "kerberos" ] && [ "$auth_type" != "scram" ]; then
    echo "Error: Invalid authentication type. Please use 'kerberos' or 'scram'."
    exit 1
fi

# Setup authentication
setup_authentication "$auth_type"

# Display available operations
echo "Available Operations:"
echo "  1. List Topics"
echo "  2. Describe Topics"
echo "  3. List ACLs"
echo "  4. Create Topic"
echo "  5. Produce to Topic"
echo "  6. Producer Perf Test"
echo "  7. Consumer Perf Test"
echo "  8. Create ACLs for Producer and Consumer"
echo ""

# Prompt for operation
read -p "Enter Operation (1-8): " operation

# Execute the requested operation
case "$operation" in
    1)
        "$KAFKA_TOPICS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" --list --command-config "$client_properties_file"
        ;;
    2)
        read -p "Enter Topic Name: " topic_name
        "$KAFKA_TOPICS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" --describe --topic "$topic_name" --command-config "$client_properties_file"
        ;;
    3)
        "$KAFKA_ACLS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" --list --command-config "$client_properties_file"
        ;;
    4)
        read -p "Enter Topic Name: " new_topic_name
        "$KAFKA_TOPICS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" --create --topic "$new_topic_name" --partitions 3 --replication-factor 3 --command-config "$client_properties_file"
        ;;
    5)
        read -p "Enter Topic Name: " producer_topic_name
        "$KAFKA_TOPICS_CMD" --bootstrap-server "$bootstrap_server:$bootstrap_port" --describe --topic "$producer_topic_name" --command-config "$client_properties_file"
        # Launch console producer
        kafka-console-producer.sh --broker-list "$bootstrap_server:$bootstrap_port" --topic "$producer_topic_name" --producer.config "$client_properties_file"
        ;;
    6)
        read -p "Enter Topic Name: " perf_test_topic_name
        read -p "Enter Number of Records: " num_records
        read -p "Enter Record Size (bytes): " record_size
        read -p "Enter Throughput (records per second): " throughput
        kafka-producer-perf-test.sh --topic "$perf_test_topic_name" --num-records "$num_records" --record-size "$record_size" --throughput "$throughput" --producer.config "$client_properties_file" --producer-props acks=all
        ;;
    7)
        read -p "Enter Topic Name: " consumer_perf_test_topic_name
        kafka-consumer-perf-test.sh --topic "$consumer_perf_test_topic_name" --messages "$num_records" --show-detailed-stats --consumer.config "$client_properties_file"
        ;;
    8)
        read -p "Enter Topic Name: " acl_topic_name
        read -p "Enter SCRAM User Name: " acl_user_name

        # Setup authentication for the user
        setup_authentication "scram"

        # Create ACLs for producer and consumer
        create_acls "$acl_topic_name" "$acl_user_name"
        ;;
    *)
        echo "Error: Invalid operation. Please use numbers 1-8."
        exit 1
        ;;
esac
