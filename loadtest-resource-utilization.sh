#! /bin/bash

# current date
current_date=$(date -u +"%d-%m-%y")

# Get the current UTC time
utc_time=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Get the current Dubai time
dubai_time=$(TZ="Asia/Dubai" date +"%Y-%m-%d %H:%M:%S Dubai")

# Pods details
pods_hpa=$(kubectl get hpa -n nodeapp)

# file name
file_name="/tmp/loadtest-resource-utilization-reports/loadtest-resource-utilization-${current_date}.txt"

# Create the text file and store the PODS and Time Maps.
echo "**START**" >> "${file_name}"
echo "--------------------------------------------------------------------" >> "${file_name}"
echo "Current UTC & DUBAI time." >> "${file_name}"
echo -e "UTC Time: $utc_time\nDubai Time: $dubai_time" >> "${file_name}"
echo "--------------------------------------------------------------------" >> "${file_name}"
echo "Pods Resource Utilization." >> "${file_name}"
sudo kubectl get hpa -n nodeapp >> "${file_name}"
echo "--------------------------------------------------------------------" >> "${file_name}"
echo -e "**END**\n" >> "${file_name}"



# file name ==> loadtest-resource-utilization-13-06-23.txt

###################################### Expected Output ################

*START**
--------------------------------------------------------------------
Current UTC & DUBAI time.
UTC Time: 2023-06-13 13:15:02 UTC
Dubai Time: 2023-06-13 17:15:02 Dubai
--------------------------------------------------------------------
Pods Resource Utilization.
NAME                        REFERENCE                           TARGETS            MINPODS   MAXPODS   REPLICAS   AGE
admin-autoscaler            Deployment/admin-service            29%/70%, 6%/70%    2         15        2          18d
auth-autoscaler             Deployment/auth-service             16%/70%, 3%/70%    2         15        2          2y187d
bsp-autoscaler              Deployment/bsp-service              22%/70%, 7%/70%    3         15        3          390d
deeplink-autoscaler         Deployment/deeplink-service         41%/70%, 5%/70%    2         15        2          2y187d
deliverycharge-autoscaler   Deployment/deliverycharge-service   29%/70%, 6%/70%    2         10        2          285d
feedback-autoscaler         Deployment/feedback-service         32%/70%, 4%/70%    2         10        2          253d
location-autoscaler         Deployment/location-service         34%/70%, 8%/70%    3         15        3          2y187d
log-autoscaler              Deployment/log-service              28%/70%, 6%/70%    3         15        3          2y187d
menu-autoscaler             Deployment/menu-service             30%/70%, 8%/70%    3         15        3          2y187d
notification-autoscaler     Deployment/notification-service     19%/70%, 7%/70%    2         15        2          2y187d
order-autoscaler            Deployment/order-service            37%/65%, 15%/70%   6         20        6          2y187d
payment-autoscaler          Deployment/payment-service          27%/70%, 10%/70%   2         15        2          2y187d
promotion-autoscaler        Deployment/promotion-service        44%/70%, 6%/70%    2         15        2          2y187d
sms-autoscaler              Deployment/sms-service              21%/70%, 6%/70%    2         15        2          285d
sync-autoscaler             Deployment/sync-service             45%/70%, 4%/70%    3         15        3          2y187d
upload-autoscaler           Deployment/upload-service           38%/70%, 5%/70%    2         15        1          280d
user-autoscaler             Deployment/user-service             17%/65%, 10%/65%   5         20        5          2y187d
--------------------------------------------------------------------
**END**

