#!/bin/bash
LOGIN_USER="ubuntu"
SSHKEY=""
RECIPES=""
SALTSERVER=""
IP=""
HOSTNAME=""
KNIFERB=""

RETCODE_ERR_WRONG_ARGS=2
RETCODE_ERR_FILE_NOT_FOUND=3
RETCODE_ERR_ARG_NOT_SET=4

function print_help {
   echo " -l       node user login, default: ubuntu"
   echo " -n       node ip address"
   echo " -N       node hostname"
   echo " -s       salt server ip address"
   echo " -i       ssh key for node"
   echo " -r       additional runlist for node, optional.  ib-salt::minion always included"
}

while [ "$#" -gt 0 ]; do
   case "$1" in
      '-l')
         shift
         LOGIN_USER="$1"
         ;;
      '-c')
         shift
         KNIFERB="$1"
         ;;
      '-n')
         shift
         IP="$1"
         ;;
      '-N')
         shift
         HOSTNAME="$1"
         ;;
      '-s')
         shift
         SALTSERVER="$1"
         ;;
      '-i')
         shift
         SSHKEY="$1"
         ;;
      '-r')
         shift
         RECIPES="$1"
         ;;
      '-h')
         print_help
         exit 0
         ;;
      *)
         echo Unknown argument "$1"
         exit ${RETCODE_ERR_WRONG_ARGS}
         ;;
   esac
   shift
done

if [ -z "$IP" ]; then
   echo ERROR: IP address of node to connect to salt and chef is required 1>&2
   exit $IP
fi

if [ -z "$HOSTNAME" ]; then
echo ERROR: Hostname of node to connect to salt and chef is required 1>&2
exit $HOSTNAME
fi

if [ ! -f "$SSHKEY" ]; then
   echo ERROR: the given ssh key was not found 1>&2
   exit $RETCODE_ERR_FILE_NOT_FOUND
fi

if [ -z "$SALTSERVER" ]; then
   echo ERROR: Salt server IP required 1>&2
   exit $RETCODE_ERR_ARG_NOT_SET
fi

function join_salt_chef() {
   IP=$1
   LOGIN_USER=$2
   SSHKEY=$3
   SALTSERVER=$4
   #RECIPES="recipe[ib-salt::minion]"
   RECIPES="$5"
   #if [ -n "$5" ]; then
   #   RECIPES="$RECIPES,$5"
   #fi
   if [ -z "$KNIFERB" ]; then
      knife bootstrap "${IP}" -N "${HOSTNAME}" -x "${LOGIN_USER}" -i $SSHKEY --sudo --node-ssl-verify-mode none -r "$RECIPES" --json-attributes '{"salt": { "minion": { "master": "'$SALTSERVER'"}}}'
   else
      knife bootstrap "${IP}" -N "${HOSTNAME}" -x "${LOGIN_USER}" -i $SSHKEY --sudo --node-ssl-verify-mode none -c "$KNIFERB" -r "$RECIPES" --json-attributes '{"salt": { "minion": { "master": "'$SALTSERVER'"}}}'
   fi
}

join_salt_chef "$IP" "$LOGIN_USER" "$SSHKEY" "$SALTSERVER" "$RECIPES" "HOSTNAME"
echo "$IP"
echo "$LOGIN_USER"
echo "$SSHKEY"
echo "$SALTSERVER"
echo "$RECIPES"
echo "$HOSTNAME"

