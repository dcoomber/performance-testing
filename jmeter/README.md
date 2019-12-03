# Sample JMeter Load and Performance Test
JMeter test plan designed to test the performance of the Restful Bookings website when under load.
1. `jmeter_perf_test.jmx` is a generic performance test plan with runtime definable parameters

## Description of files used by the test plan
Filename | Purpose
-------- | -------
README.md | This file
jmeter_data.csv | Tab delimited file containing a customer details for use in testing
jmeter_*_test.jmx | JMeter test plans
run_test.sh | Wrapper shell script for executing the JMeter test plan on the commandline
## Running the test
This JMeter test plan has been designed to run locally via terminal, in Docker Swarm and in the JMeter GUI (for debugging).
### Running the test in JMeter
The JMeter test plan supports the following parameter overrides:

Parameter | Default | Description
--------- | ------- | -----------
authKey | secret_key1 | The API authorization key
protocol | https | The HTTP protocol used by the service
host | automationintesting.online | The service host address
port | 443 | The service host port
timeout | 60000 | The request & response timeout in milliseconds
threads | 10 | The number of virtual users that will interact with the service during the test
throughput | 10 | The number of threads that will execute per minute
rampUp | 30 | The number of seconds during which load will gradually increase until full load
loopCount | 1 | The number of times the test will iterate until completed
1. Execute the JMeter test plan via `/path/to/apache-jmeter-5.2.1/bin/jmeter.sh -n -t ./jmeter_perf_test.jmx -JauthKey=secret_key1 -Jprotocol=https -Jhost=automationintesting.online -Jport=443 -Jtimeout=60000 -Jthreads=10 -Jthroughput=10 -JrampUp=30 -JloopCount=10 -l ~/jmeter/results -j ~/jmeter/jmeter.log -e -o ~/jmeter/report`
1. Alternatively, execute the JMeter test plan using the wrapper shell script `./run_test.sh`
## References
### Installing JMeter
1. Download and "install" [JMeter](https://jmeter.apache.org/download_jmeter.cgi)
1. Reference the [user manual](https://jmeter.apache.org/usermanual/index.html) for specifics of how to use JMeter