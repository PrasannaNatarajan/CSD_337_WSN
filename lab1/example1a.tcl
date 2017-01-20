#Create a simulator object
set ns1 [new Simulator]

#Open the nam trace file
set nf [open out.nam w]
$ns1 namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns1 nf
        $ns1 flush-trace
	#Close the trace file
        close $nf
	#Execute nam on the trace file
        exec nam out.nam &
        exit 0
}

#Create two nodes
set n0 [$ns1 node]
set n1 [$ns1 node]

#Create a duplex link between the nodes
$ns1 duplex-link $n0 $n1 1Mb 10ms DropTail

#Call the finish procedure after 5 seconds of simulation time
$ns1 at 5.0 "finish"

#Run the simulation
$ns1 run


