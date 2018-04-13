Local laFiles[1], lcToolFolder, lcUpdateFolder, llAutoRun, lnFileCount, lnI, lnReturn


#Define UpdaterURL 'http://vfpxrepository.com/dl/thorupdate/Updater_PRGs/Updates.zip'

WritetoCFULog( [��ʼ CFU - ]  + Transform(Datetime()))

If Not Execscript (_Screen.cThorDispatcher, 'Thor_Proc_CheckInternetConnection')
	Messagebox ( [û���ҵ����������ӣ�] , 16,  [û�л���������] , 0)
	Return .F.
Endif

WritetoCFULog( [��� Thor ����] , .T.)

If Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndInstallUpdates', .T.) >= 0

	lcToolFolder   = Execscript (_Screen.cThorDispatcher, 'Tool Folder=')
	WritetoCFULog( [����ɾ�� FXP �ļ�...] )
	EraseFXPFiles (lcToolFolder)
	WritetoCFULog( [���ڴ� Thor Procs �ļ���ɾ�� Thor FXP �ļ�...] )
	EraseFXPFiles (lcToolFolder + 'Procs')
	WritetoCFULog( [���ڴ� Thor MyTools �ļ���ɾ�� Thor FXP �ļ�...] )
	EraseFXPFiles (lcToolFolder + 'My Tools')

	lcUpdateFolder = Addbs (lcToolFolder) + 'Updates\'
	lnFileCount	   = Adir (laFiles, lcUpdateFolder + '*.PRG')
	WritetoCFULog( [���ڴ��� (]  + transform(lnFileCount) +  [) Thor ���³���...] )

	For lnI = 1 To lnFileCount
		If Not Upper (laFiles[lnI, 1]) == Upper ('Thor_Update_Thor.PRG')
			Erase (lcUpdateFolder + laFiles[lnI, 1])
		Endif
	Endfor
	*** Download the zip of Updaters, and install them
	lnReturn = Execscript (_Screen.cThorDispatcher	;
		  , 'Thor_Proc_DownloadAndExtractToPath'	;
		  , UpdaterURL + '?=' + Sys(2015)			;
		  , lcToolFolder							;
		  , .T.										;
		  , 'Updates')

	*** Check if called from RunThor, meaning it is from AutoRun
	llAutoRun = .F.
	For lnI = 1 To Program (-1)
		llAutoRun = llAutoRun Or 'RUNTHOR' $ Upper (Sys(16, lnI))
	Endfor

	WritetoCFULog( [����������� APPs ����] , .T.)
	
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_DownloadAndInstallUpdates', .F., llAutoRun)

	Execscript (_Screen.cThorDispatcher, 'Run')

Endif

Execscript (_Screen.cThorDispatcher, 'Thor_Tool_ThorInternalThorNews',  [������] )

Wait Clear

Return


Procedure EraseFXPFiles (tcFolder)
	Local lcFolder, lnCount, lnI, loException
	lcFolder = Addbs (tcFolder)
	lnCount	 = Adir (laFiles, lcFolder + '*.FXP')
	For lnI = 1 To lnCount
		Try
			Erase (lcFolder + laFiles[lnI, 1])
		Catch To loException

		Endtry
	Endfor
Endproc


Procedure WritetoCFULog(tcText, tlDivider)
	Execscript (_Screen.cThorDispatcher, 'Thor_Proc_WritetoCFULog(', tcText, tlDivider)
EndProc 