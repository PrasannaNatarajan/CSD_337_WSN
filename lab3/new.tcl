#Create a simulator object
set ns [new Simulator]
#Open the nam trace file
set nf [open out.nam w]
#set f1 [open out0.tr w]
$ns namtrace-all $nf
set nf1 [open tracefile.tr w]
#set f1 [open out0.tr w]
$ns namtrace-all $nf
$ns trace-all $nf1
#Define a 'finish' procedure
proc finish {} {
 global ns nf nf1
 $ns flush-trace
 #Close the trace file
 close $nf
 close $nf1

 #Execute nam on the trace
 exec nam out.nam &
 exec xgraph throughput.tr -geometry 600x400 &
 exit 0
}
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
$ns duplex-link $n3 $n4 600Kb 10ms DropTail
$ns queue-limit $n3 $n4 10
$ns duplex-link $n0 $n3 2Mb 5ms DropTail
$ns duplex-link $n1 $n3 2Mb 5ms DropTail
$ns duplex-link $n2 $n3 2Mb 5ms DropTail
$ns duplex-link-op $n0 $n3 orient right-down
$ns duplex-link-op $n1 $n3 orient right
$ns duplex-link-op $n2 $n3 orient right-up
$ns duplex-link-op $n3 $n4 orient right
set file1 [open qm.out w]
set qmon [$ns monitor-queue $n3 $n4 $file1 0.3]
[$ns link $n3 $n4] queue-sample-timeout
set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
$udp0 set class_ 2
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 200
$cbr0 set rate_ 500kb
$cbr0 set interval_ 1
$cbr0 attach-agent $udp0
set udp1 [new Agent/UDP]
$ns attach-agent $n2 $udp1
$udp1 set class_ 3
set traffic [new Application/Traffic/Exponential]
$traffic set packetSize_ 200
$traffic set burst_time_ 2
$traffic set idle_time_ 1
$traffic set rate_ 500kb
$traffic attach-agent $udp1
set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n0 $tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp0 $null 
$ns connect $udp1 $null
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$ns at 1 "$cbr0 start"
$ns at 2.5 "$cbr0 stop"
$ns at 1.5 "$traffic start"
$ns at 4.5 "$traffic stop"
$ns at 0.5 "$ftp start"
$ns at 3.5 "$ftp stop"
$ns at 5.0 "finish"
#Run the simulation
$ns run