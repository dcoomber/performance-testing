#!/bin/sh

# command-line overrides specific to this Jmeter test plan
testPlan=jmeter_perf_test.jmx
authKey=secret_key1
protocol=https
host=automationintesting.online
port=443
timeout=60000
threads=10
throughput=10
rampUp=30
loopCount=10

# Paths
appPath=~/Applications/apache-jmeter-5.2.1/bin/jmeter.sh
reportPath=/tmp/jmeter
logFile=jmeter.log
resultFile=results

# Other vars
timestamp=$(date "+%Y.%m.%d-%H.%M.%S")

# Check validity of Jmeter path
if [ -e "$appPath" ]; then
    echo "Jmeter application found."
else
    echo "Jmeter application not found.  Cannot continue."
    exit
fi

# Create report path if it doesn't exist
if [ -d "$reportPath" ]; then
    echo "Report path found."

    # Backup previous Jmeter report
    if [ -d "$reportPath/report" ]; then
        backup=report_$timestamp.gz
        echo "Backing up existing report to '$reportPath/$backup'"
        tar -zcf "$reportPath/$backup" "$reportPath/report" "$reportPath/$logFile" "$reportPath/$resultFile"

        # Delete previous reports
        rm -R "$reportPath/report"
        rm "$reportPath/$logFile"
        rm "$reportPath/$resultFile"
    fi
else
    echo "Report path not found.  Attempting to create '$reportPath'..."
    mkdir -p "$reportPath"
    if [ $? -eq 0 ]; then
        echo "Report path created."
    else
        echo "Could not create report path.  Cannot continue."
        exit
    fi
fi

# Run the test plan
"$appPath" -n -t ./$testPlan -JauthKey=$authKey -Jprotocol=$protocol -Jhost=$host -Jport=$port -Jtimeout=$timeout -Jthreads=$threads -Jthroughput=$throughput -JrampUp=$rampUp -JloopCount=$loopCount -l "$reportPath/$resultFile" -j "$reportPath/$logFile" -e -o "$reportPath/report"

# Run is complete
echo "Complete!"
