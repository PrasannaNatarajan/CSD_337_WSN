 BEGIN { 

        Drops = 0;
        gen = 0;

      }      

      {

        event = $1
        time = $2

        node_id = $3

        pkt_size = $8
        level = $4

        if(event == "D"){
            Drops++;
            printf("%f %d\n",time,Drops);
        }
        if(event == "s"){
            gen++;
        }
    }

END {

        printf("gen = %d Drops = %d\n",gen,Drops);

    }

