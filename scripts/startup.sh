#!/bin/bash
# Arachni REST API Bootstrap

credits() {

echo -e "

      Arachni Web Application Security Scanner Framwork
              http://www.arachni-scanner.com/
                       Thanks Tasos
\e[31m 
                             tt
                       rtttwwRRwwtttr
                 rtwsSWTRRssssssssSWTRRswtr
              twRRRswtr     rrrr    rrtwsRRRwt
         r rwRRswr  rtwwsSWTRSWTRRRswwtr  rwRRRwr r
         sRRRwr  twSWTRSWTRSWTRSWTRSWTRRRwt  rwRRRs
       rsRRw  rwSWTRSWTRSWTRSWTRSWTRSWTRSWTRwr rwRRsr
      tRRsr rsSWTRSWTRSWTRSWTRSWTRSWTRSWTRSWTRsr rsRRt
     wRRt  wSWTRRssssssssssssssssssssssssssssRRRw  tRRw
    wRRr rsSWTRt                             SWTRsr rRRw
   tRRt rSWTRRs                              SWTRRsr tRRt
  rRRw  sSWTRRs    rSWTRSWTRSWTRSWTRSWTRSWTRSWTRRRRs  wRRr
  wRR  tSWTRRRs    tRsrrrrrrrrrrrrrrrrrrrrrrwSWTRRRRt rRRw
  sRs  sSWTRRRs    tRs                       SWTRRRRs  sRs
rtRRw  SWTRRRRs    tRRwwwwwwwwwwwwwwwwwwr    SWTRSWTR  wRRtr
rtRRw  SWTRRRRs    rttttttttttttttttttRRt    SWTRSWTR  wRRtr
  sRs  sSWTRRRR                       sRt    SWTRRRRs  sRs
  wRRr tSWTRRRRstrrrrrrrrrrrrrrrrrrrrrsRt    SWTRRRRt rRRw
  rRRw  sSWTRRRsssssssssssssssssssssssssr    SWTRRRs  wRRr
   tRRt rsSWTRs                              SWTRRs  tRRt
    wRRt rsSWTR                             wSWTRsr tRRw
     wRRt  wSWTRSWTRSWTRSWTRSWTRSWTRSWTRSWTRSWTRw  wRRw
      tRRsr rsSWTRSWTRSWTRSWTRSWTRSWTRSWTRSWTRwr rsRRt
       rwRRwr rwSWTRSWTRSWTRSWTRSWTRSWTRSWTRwr rwRRwr
         sRRRst  twsSWTRSWTRSWTRSWTRSWTRswt  tsRRRs
         r rwRRRwt   rtwssSWTRSWTRsswtr   twRRRwr r
              rwsRRswtrr            rttwsRRswr
                 rtwsSWTRRssssssssSWTRRswtr
                       rrtttwRRwtttrr
                             tt
\e[0m 
                Docker image by: Shearwater
                   www.shearwater.com.au
             Creating a safer connected world
             
             "

}

genpass() {
    cat /dev/urandom | tr -cd 'A-Za-z0-9' | fold -w 20 | head -1
}

setpass() {
    if [ $ARACHNI_REST_PASS == "secret" ];
    then
        echo "Changing the default password..."
        pass=$(genpass)
        export ARACHNI_REST_PASS="$pass"
        
    fi
    echo "Your credentials are as follows..."
    echo
    echo -e "\e[32m[*] Username: $ARACHNI_REST_USER \e[0m"
    echo -e "\e[32m[*] Password: $ARACHNI_REST_PASS \e[0m"
}

database() {
    arachni_web_task db:version 2>&1 | grep 'Did you run the migration'
    
    if [ $? -eq 0 ];
    then
        echo "Setting up database..."
        arachni_web_task db:setup
    fi
}

startup() {
    echo
    echo "Booting REST API server...."
    echo
    arachni_rest_server --address 0.0.0.0 --authentication-username "$ARACHNI_REST_USER" --authentication-password "$ARACHNI_REST_PASS"
}

database
credits
setpass
startup