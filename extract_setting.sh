#!/bin/bash 
#
#extract the settings from xml file.

output="output"
settingfile=$output"/setting.txt"
settingname=$output"/settingname.txt"
Blade=$output"/Blade.txt"
IteBlade=$output"/IteBlade.txt"
HignDense=$output"/HignDense.txt"
HighVolume=$output"/HighVolume.txt"
EntryLevel=$output"/EntryLevel.txt"
tempfile=$output"/temp.txt"

read -p "please input the xml file name : " filename
echo $filename

if [ -f $filename ]
then
	echo "open file successfully！"
else
	echo "operation fail,"$filename" does not exist"
	exit
fi

if [ -d $output ]
then
	echo "directory already exists,delete it."
	rm $output -rf
	mkdir $output
else
	echo "directory does not exist,create it."
	mkdir $output
fi

sed -n  '/setting ID/w '$settingfile'' $filename
cat $settingfile | cut -d '"' -f 2  > $settingname

sed -n '/_TMPL_BLADEPROT/w '$tempfile'' $settingfile
cat $tempfile | cut -d '"' -f 2  > $Blade

sed -n '/_TMPL_ITEBLADEPROT/w '$tempfile'' $settingfile
cat $tempfile | cut -d '"' -f 2  > $IteBlade

sed -n '/_TMPL_HIGNDENSEPROT/w '$tempfile'' $settingfile
cat $tempfile | cut -d '"' -f 2  > $HignDense

sed -n '/_TMPL_HIGHVOLPROT/w '$tempfile'' $settingfile
cat $tempfile | cut -d '"' -f 2  > $HighVolume

sed -n '/_TMPL_ENTRYLVLPROT/w '$tempfile'' $settingfile
cat $tempfile | cut -d '"' -f 2  > $EntryLevel

rm $tempfile

if [ $? -eq 0 ]
then
	echo "End of the operation,bye！"
else
	echo "operation fail"
fi
