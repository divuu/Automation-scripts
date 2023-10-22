# bin/bash/!

# current date
current_date=$(date -u +"%d-%m-%y")
echo "Script Running On Date =>" ${current_date}
echo "*** SCRIPT THRESHOLD LIMIT IS 90% OR ABOVE DISK UTILIZATION. THEN ONLY SCRIPT WILL INITIATE CLEAN UP PROCESS ***"

echo "--------------------------------------------------------------------"
echo "Checking Available Disk Space in VM"
echo "--------------------------------------------------------------------"
cd /
df -h | awk 'FNR == 4 { print "Current Disk Usage Is :", $5; if ($5 > 90) print "## Need To Free Up Space In Jenkins ##"; else print "!! Space Available In Jenkins !!"}'

# remove percentage sign
disk_usage=$(df -h | awk 'FNR == 4 { sub(/%/, "", $5); print $5 }')

# Use the captured value in an if-else statement
if [ "$disk_usage" -gt 90 ]; then
    echo "--------------------------------------------------------------------"
    echo "## Cleaning Up Junks In Jenkins Initiated ##"
    echo "--------------------------------------------------------------------"

    # echo "--------------------------------------------------------------------"
    # echo "Stopping Jenkins-Slave Agent"
    # echo "--------------------------------------------------------------------"
    # slave_id=$(ps -ef | grep '/usr/bin/java -jar remoting.jar' | awk 'FNR == 1 {print $2}')
    # echo "process_id :- ${slave_id}"
    # kill -9 ${slave_id}

    echo "--------------------------------------------------------------------"
    echo "Cleaning Up WorkSpace Dir."
    echo "--------------------------------------------------------------------"
    cd /home/azureuser/PHD-Slave-Workspace/workspace/
    ls -la
    du -shc
    rm -rf *
    echo "  "
    cd /var/lib/jenkins/workspace/
    ls -la
    du -shc
    rm -rf *

    echo "--------------------------------------------------------------------"
    echo "Stopping Docker"
    echo "--------------------------------------------------------------------"
    systemctl stop docker --no-pager
    sleep 1m
    cd /var/lib/
    mv docker docker-${current_date}
    ls -la | grep docker

    echo "--------------------------------------------------------------------"
    echo "Removing Docker Build Images"
    echo "--------------------------------------------------------------------"
    rm -rf docker-${current_date}
    ls -la | grep docker

    echo "--------------------------------------------------------------------"
    echo "Starting Docker"
    echo "--------------------------------------------------------------------"
    systemctl start docker --no-pager
    sleep 1m
    ls -la | grep docker
    echo "   "
    systemctl status docker --no-pager

    echo "--------------------------------------------------------------------"
    echo "** Again Checking Available Disk Space in VM **"
    echo "--------------------------------------------------------------------"
    cd /
    disk_usage=$(df -h | awk 'FNR == 4 { sub(/%/, "", $5); print $5 }')
    # Print the current disk usage
    echo "Current Disk Usage After Freeing Space Is : ${disk_usage}%"
    echo "     "
    df -h

    # echo "--------------------------------------------------------------------"
    # echo "Starting Jenkins-Slave Agent"
    # echo "--------------------------------------------------------------------"
    # sleep 1m
    # nohup /usr/bin/java -jar /opt/remoting.jar -workDir /home/localadmin/PHD-Slave-Workspace -jar-cache /home/localadmin/PHD-Slave-Workspace/remoting/jarCache &>/dev/null

else
    echo "--------------------------------------------------------------------"
    echo "!! NO Action Recommended !! Space Available In Jenkins !!"
    echo "--------------------------------------------------------------------"
    df -h
fi