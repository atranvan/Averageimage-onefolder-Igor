#pragma rtGlobals=1		// Use modern global access method.
#include <All IP Procedures>


Function aveimdir(prefix)
	string prefix
	string/g imslist
	imslist=wavelist(prefix+"*",";","DIMS:2")
	print imslist
	variable toadd=itemsinlist(imslist)
	if (itemsinlist(imslist)==0)
		doAlert 0,"no image with this prefix"
		return 0
	endif
	
	variable i
	Make/o/n=(dimsize($(stringfromlist(0,imslist)),0),dimsize($(stringfromlist(0,imslist)),1)) average
	for (i=0;i<toadd;i+=1)
		Duplicate/o $(stringfromlist(i,imslist)) tempwave
		average=average+tempwave
		Killwaves tempwave
	endfor
	average=average/toadd
	
	Setscale/p x,0,dimdelta($(stringfromlist(0,imslist)),0),"" average
	Setscale/p y,0,dimdelta($(stringfromlist(0,imslist)),1),"" average	
	
	Display;appendimage average
	setaxis/a/r left

end
