BEGIN {



packetDrops = 0;
f=0;
t=0.5;
recv4 = 0;


}

{

action = $1;

time = $2;

from = $3;

to = $4;

type = $5;

pktsize = $6;

flow_id = $8;

src = $9;

dst = $10;

seq_no = $11;

packet_id = $12;

if(action == "d"){
packetDrops++;
/*printf("num drops = %d\n",packetDrops);*/ /*Uncomment to get the packet loss*/
}
if(action == "r" && dst == 4.0){
	recv4++;
	if(time>=t+0.5){
		t=time;
		printf("%f %d\n",time,((recv4)/t));
	}
}


}

END {



}