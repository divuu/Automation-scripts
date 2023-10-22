#!/bin/bash

# Prompt the user for input
echo "Enter your choice:"
echo "1. Upscale HPA same as prod."
echo "2. Downscale HPA to base."
read choice 

# Check the user's choice and execute corresponding commands
case $choice in
    1)
        echo "--------------------------------------------------------------------"
        echo "You selected to Upscale HPA."
        echo "--------------------------------------------------------------------"
        # Run commands fommr Option 1
        sh /var/lib/jenkins/az_uat_login.sh
        echo "--------------------------------------------------------------------"
        echo "PODS HPA Before upscaling HPA"
        echo  "--------------------------------------------------------------------"
        kubectl get hpa -n nodeapp
        kubectl apply -f /home/azureuser/prep-loadtest/hpa-upscaling-equal-prod.yaml -n nodeapp
        echo "--------------------------------------------------------------------"
        echo "PODS HPA After upscaling HPA"
        echo "--------------------------------------------------------------------"
        kubectl get hpa -n nodeapp
        echo "--------------------------------------------------------------------"
        echo  "Enabling Loadtest Cron for Recording CPU & Memory Utilization"
        echo "--------------------------------------------------------------------"
        cd /tmp/loadtest-resource-utilization-reports/
        ls -la | grep -e "loadtest*"
        #rm -rf loadtest-resource-utilization.txt
	    echo "--------------------------------------------------------------------"
	    echo "checking for 7 days Old Loadtest files."
	    echo "--------------------------------------------------------------------"
	    ./remove-file-old-7day.sh
	    echo "--------------------------------------------------------------------"
	    echo "Check completed !"
	    echo "--------------------------------------------------------------------"
	    #find -name "*.txt" -type f -mtime +7 -exec rm -rf {} \;
        cd /home/azureuser/prep-loadtest
        crontab cron-enable
        echo "--------------------------------------------------------------------"
        echo "Crontab file look for confirmation !!"
        echo "--------------------------------------------------------------------"
        crontab -l
        echo "--------------------------------------------------------------------"
        echo  "Loadtest Cron Enabled !!"
        echo "--------------------------------------------------------------------"
        ;;
    2)
        echo "--------------------------------------------------------------------"
        echo "You selected to Downscale HPA."
        echo "--------------------------------------------------------------------"
        # Run commands for Option 2
        sh /var/lib/jenkins/az_uat_login.sh
        echo "--------------------------------------------------------------------"
        echo "PODS HPA Before Downscaling HPA"
        echo "--------------------------------------------------------------------"
        kubectl get hpa -n nodeapp
        kubectl apply -f /home/azureuser/prep-loadtest/hpa-downscaling-equal-uat.yaml -n nodeapp
        echo "--------------------------------------------------------------------"
        echo "PODS HPA After Downscaling HPA"
        echo "--------------------------------------------------------------------"
        kubectl get hpa -n nodeapp
        echo "--------------------------------------------------------------------"
        echo  "Disabling Loadtest Cron"
        echo "--------------------------------------------------------------------"
        cd /tmp/loadtest-resource-utilization-reports/
        ls -la | grep -e "loadtest*"
        cd /home/azureuser/prep-loadtest
        crontab cron-disable
        echo "--------------------------------------------------------------------"
        echo "Crontab file look for confirmation !!"
        echo "--------------------------------------------------------------------"
        crontab -l
        echo "--------------------------------------------------------------------"
        echo  "Loadtest Cron Disabled !!"
        echo "--------------------------------------------------------------------"
        ;;
    *)
        echo "Invalid choice."
        ;;
esac

