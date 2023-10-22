# bin/bash/!

# Prompt the user for input
echo "Enter your choice:"
echo "1. Upscale Resource Capacity Same As Prod."
echo "2. Downscale Resource Capacity To Base."
read choice 

declare -A basic_svc_map

basic_svc_map["admin-service"]="300m,500Mi"
basic_svc_map["auth-service"]="300m,500Mi"
basic_svc_map["bsp-service"]="300m,500Mi"
basic_svc_map["chat-service"]="300m,500Mi"
basic_svc_map["deeplink-service"]="300m,500Mi"
basic_svc_map["delivery-service"]="300m,500Mi"
basic_svc_map["location-service"]="300m,800Mi"
basic_svc_map["log-service"]="500m,800Mi"
basic_svc_map["menu-service"]="500m,700Mi"
basic_svc_map["notification-service"]="300m,500Mi"
basic_svc_map["order-service"]="800m,1400"
basic_svc_map["payment-service"]="300m,500Mi"
basic_svc_map["promotion-service"]="300m,500Mi"
basic_svc_map["sync-service"]="300m,500Mi"
basic_svc_map["upload-service"]="300m,500Mi"
basic_svc_map["user-service"]="800m,1200Mi"

declare -A prod_svc_map

prod_svc_map["admin-service"]="800m,1200Mi"
prod_svc_map["auth-service"]="500m,500Mi"
prod_svc_map["bsp-service"]="700m,700Mi"
basic_svc_map["chat-service"]="500m,500Mi"
prod_svc_map["deeplink-service"]="200m,250Mi"
prod_svc_map["delivery-service"]="250m,500Mi"
prod_svc_map["location-service"]="500m,500Mi"
prod_svc_map["log-service"]="500m,500Mi"
prod_svc_map["menu-service"]="700m,700Mi"
prod_svc_map["notification-service"]="1200m,1500Mi"
prod_svc_map["order-service"]="2000m,3000"
prod_svc_map["payment-service"]="500m,500Mi"
prod_svc_map["promotion-service"]="1000m,1500Mi"
prod_svc_map["sync-service"]="500m,500Mi"
prod_svc_map["upload-service"]="200m,250Mi"
prod_svc_map["user-service"]="1500m,1700Mi"

#pwd

display_rc(){
    type=$1
    local -n svc_map=$2
	
    echo "--------------------------------------------------------------------"
    echo "CPU and Memory of Services ${type} Applying Resource Capacity"
    echo "--------------------------------------------------------------------"

    for svc in "${!svc_map[@]}"; do
    echo "--------------------------------------------------------------------"
    #echo "${svc}"
    print_service_details "$svc"
    echo "--------------------------------------------------------------------"
done
}

applying_rc(){
    local -n svc_map=$1

    echo "--------------------------------------------------------------------"
    echo "Applying Production Resource Capacity"
    echo "--------------------------------------------------------------------"

    for svc in "${!svc_map[@]}"; do
        echo "--------------------------------------------------------------------"
        value="${svc_map[$svc]}"
        IFS=',' read -ra values <<< "$value"
        cpu="${values[0]}"
        memory="${values[1]}"
        sudo kubectl set resources deployment/${svc} -n nodeappuat --limits=cpu=$cpu,memory=$memory --requests=cpu=$cpu,memory=$memory
        echo "--------------------------------------------------------------------"
    done
}

print_service_details(){
    svc_name=$1
    command_output=$(sudo kubectl describe deployment/${svc_name} -n nodeappuat | grep -E 'Name|Limits|Requests|cpu|memory')
    echo "$command_output"
}

# Check the value using if-else
if [ "$choice" -eq 1 ]; then
    echo "You selected to Upscale Resource Capacity."
        display_rc "Before" "prod_svc_map"
        applying_rc "prod_svc_map"
        display_rc "After" "prod_svc_map"
elif [ "$choice" -eq 2 ]; then
    echo "You selected to Downscale Resource Capacity."
        display_rc "Before" "basic_svc_map"
        applying_rc "basic_svc_map"
        display_rc "After" "basic_svc_map"
else
    echo "Invalid choice"
fi
