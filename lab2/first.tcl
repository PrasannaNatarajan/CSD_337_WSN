# 
#
#
#
#

#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure

proc finish {} {
        global ns nf tracefile
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        close $tracefile
        #Execute NAM on the trace file
        exec nam out.nam &
        exit 0
}

#Create ten nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n3 5Mb 10ms DropTail
$ns duplex-link $n1 $n3 5Mb 10ms DropTail
$ns duplex-link $n2 $n3 5Mb 10ms DropTail

$ns duplex-link $n3 $n4 1.5Mb 20ms DropTail
$ns duplex-link $n4 $n5 5Mb 10ms DropTail
$ns duplex-link $n4 $n7 5Mb 10ms DropTail

$ns duplex-link $n5 $n6 5Mb 10ms DropTail
$ns duplex-link $n7 $n8 5Mb 10ms DropTail
$ns duplex-link $n7 $n9 5Mb 10ms DropTail

#Set Queue Size of link (n3-n4) to 10
$ns queue-limit $n3 $n4 10

#Give node position (for NAM)
$ns duplex-link-op $n3 $n0 orient left-up
$ns duplex-link-op $n3 $n2 orient left-down
$ns duplex-link-op $n3 $n1 orient left

$ns duplex-link-op $n4 $n3 orient left

$ns duplex-link-op $n4 $n5 orient right-up
$ns duplex-link-op $n4 $n7 orient right-down

$ns duplex-link-op $n5 $n6 orient right-up

$ns duplex-link-op $n7 $n8 orient right-up
$ns duplex-link-op $n7 $n9 orient right-down

#Monitor the queue for link (n3-n4). (for NAM)
$ns duplex-link-op $n3 $n4 queuePos 0.5

#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n9 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink
$tcp set fid_ 2

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP


#Setup a UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n6 $udp
set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null
$udp set fid_ 3

set udp1 [new Agent/UDP]
$ns attach-agent $n8 $udp1
set null1 [new Agent/Null]
$ns attach-agent $n0 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 1
 
#Setup a CBR over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp 
$cbr0 set type_ CBR
$cbr0 set packet_size_ 1000
$cbr0 set rate_ 1mb
$cbr0 set random_ false

#Setup a CBR over UDP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packet_size_ 2000
$cbr1 set rate_ 3mb
$cbr1 set random_ false

## Queue monitor
# set qf_size [open queue.size w]
# set qmon_size [$ns monitor-queue $n4 $n3 $qf_size 0.05]
# [$ns link $n4 $n3] queue-sample-timeout
## Queue Trace
set tracefile [open out.trace w]
$ns trace-queue $n4 $n3 $tracefile


#Schedule events for the CBR and FTP agents
$ns at 0.5 "$cbr0 start"
$ns at 1 "$cbr1 start"
$ns at 0.5 "$ftp start"

$ns at 5 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 4.0 "$ftp stop"

#Detach tcp and sink agents (not really necessary)
#$ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.5 "finish"

#Print CBR packet size and interval
#puts "CBR packet size = [$cbr set packet_size_]"
#puts "CBR interval = [$cbr set interval_]"

#Run the simulation
$ns run
