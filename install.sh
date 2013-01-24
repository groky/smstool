#first check if smstools is installed. If it is not, install it
#locate the appropriate drivers and configure smstools correctly

#copy the ruby sms wrapper to the correct location (smsread.rb - package)
#run 'gem install' for appropriate packages

#check if ruby is installed
#check if rails is installed
#copy sms banking web application

output=`ps aux | grep smsd`
echo $output
set -- $output
pid=$2
echo $pid

echo "now checking if the smsd file is installed..."
files=`which smsd`
echo $files

