#!/bin/bash 

	######################################################################### 
	#	Script Name: hreport.sh                                         # 
	#	Script Author: Vinicius Torino                                  #
	#	Author's email: vinicius.torino@protonmail.com                  #
	#	Date of Creation: Tue Jul  7 14:04:22 -03 2020                  #
	#	Short Dereportion: Generate brief report of host stats.         #
	#	Usage: ./hreport.sh                                             #
	#########################################################################



_hostname()
{
	hostname
}


_date()
{
	date +'%D' 
}

_uptime()
{
	echo $(uptime  | sed 's/ /,/g' | cut -d',' -f5)
}


_kernel_version()
{
	echo $(uname -r)
}


_cpu_total()
{
	nproc
}


_cpu_model()
{
	echo $(lscpu  | grep 'name' | sed 's, ,:,g' | cut -d: -f13- | sed 's,:, ,g')	
}


_ram_total()
{
	echo $(free -h | sed 's, ,,g' | grep Mem | cut -d':' -f2 | cut -d'G' -f1)
}


_partitions()
{
	echo $(blkid | cut -d':' -f1)
}


_main()
{
	bar='______________________________________________________________________________'
	report_hostname=$(_hostname)
	report_date=$(_date)
	report_uptime=$(_uptime)
	report_kernel=$(_kernel_version)
	report_cpu_total=$(_cpu_total)
	report_cpu_model=$(_cpu_model)
	report_ram_total=$(_ram_total)
	report_partitions=$(_partitions)

	space='				'	

	echo "
	$bar
 	 
	 	Hostname: $report_hostname
	 
	 	Date: $report_date
	 
	 	Uptime: $report_uptime
	 
	 	Kernel Version: $report_kernel
	 
	 	Cpus Total: $report_cpu_total
	 
	 	Cpu Model: $report_cpu_model
	 
	        Ram Total: $report_ram_total GB
	 
	  	Partitions Scheme:	
		"
		
			for line in $report_partitions
			do
				echo "$space$line"
			done
	 
	echo 	"
	$bar
	     "

}


_main
