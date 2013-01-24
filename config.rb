#paths
PATH = '/var/spool/sms/incoming/'
PROCESSED_PATH='/var/spool/sms/processed/'
ERRORS_PATH='/var/spool/sms/errors/'


#transaction types
BALANCE_ENQUIRY = "BL"
BALANCE_TRANSFER = "TF"

#REGX's
#validate the entire transfer string - eg
# tf 30 77606653 565476V
#= transfer $30 to 77606653 from account 565476V

TRANSFER_REGX = /^[a-zA-Z]{2}\s+[0-9]{1,3}\s+7{1}[0-9]{7}\s+[0-9]{6}[a-zA-Z]{1}$/
#if the entire string does not evaluate, then test the individual bits for appropriate error recording
TX_TYPE_REGX = /^[a-zA-Z]{2}$/
TX_AMOUNT_REGX = /^[0-9]{1,3}$/
TX_TO_NUM_REGX = /^7[0-9]{7}$/
TX_AUTH_REGX = /^[0-9]{6}[a-zA-Z]{1}$/

#validate the entire balance enquiry string - eg
#BL 565476V
#get Balance for account 565476V
BALANCE_REGX = /^[a-zA-Z]{2}\s+[0-9]{6}[a-zA-Z]{1}$/


#http service params
HOST='localhost'
PORT='3000'
RESOURCE='/msg/'