Lparameters lxParam1

****************************************************************
****************************************************************
* Standard prefix for all tools for Thor, allowing this tool to tell Thor about itself.
* CN: ����Thor���ߵı�׼ǰ׺��������������� Thor �н�����ȷע�ᡣ

If Pcount() = 1						  ;
		And 'O' = Vartype (lxParam1)  ;
		And 'thorinfo' == Lower (lxParam1.Class)

	With lxParam1

		* Required					CN: �����
		.Prompt	 =  [���� PRGs ���] 
		.Summary =  [���� PRGs ���] 

		* Optional					CN: ��ѡ��
		.Description =  [���� PRGs ���] 

		* These are used to group and sort tools when they are displayed in menus or the Thor form
		* CN: ��������ʾ�ڲ˵���Thor������ʱ���������ڶԹ��߽��з��������
		.Category = 'Settings & Misc.' && allows categorization for tools with the same source				CN: ��������ʾ�ڲ˵���Thor������ʱ���������ڶԹ��߽��з��������
		.Sort	  = 999 && the sort order for all items from the same Source, Category and Sub-Category		CN: ����ͬһ��Դ������������������Ŀ������˳��
		.PlugInClasses = 'clsBeforeComponentInstall, clsAfterComponentInstall'

		* For public tools, such as PEM Editor, etc.
		* CN: ���ڹ������ߣ���PEM�༭����
		.Author        = 'Jim Nelson'
		.CanRunAtStartup = .F.

	Endwith

	Return lxParam1
Endif

If Pcount() = 0
	Do ToolCode
Else
	Do ToolCode With lxParam1
Endif

Return

****************************************************************
****************************************************************
* Normal processing for this tool begins here.                  
* CN: ������ߵ��������������￪ʼ��
Procedure ToolCode
	Lparameters lxParam1

	Local lcFileName
	If Type ('_Screen.cThorDispatcher') = 'C'
		Execscript (_Screen.cThorDispatcher, 'PEMEditor_StartIDETools')
		lcFileName    = Execscript (_Screen.cThorDispatcher, 'Full Path=Thor_Tool_ThorInternalManagePlugIns.SCX')
		Do Form  (lcFileName)
	Else
		Messagebox ( [Thor û�м���˹�����Ҫ Thor ������] , 16,  [Thor û�м���] , 0)
	Endif

Endproc


****************************************************************
****************************************************************

Define Class clsBeforeComponentInstall As Custom

	Source				= 'Thor'
	PlugIn				=  [�����װǰ] 
	Description			=  [�ڼ������ڼ䰲װ���֮ǰ����Thor \ Tools \ Components�����ļ����У����á�] 
	Tools				=  [������] 
	FileNames			= 'Thor_Proc_BeforeComponentInstall.PRG'
	DefaultFileName		= '*Thor_Proc_BeforeComponentInstall.PRG'
	DefaultFileContents	= ''

	Procedure Init
		****************************************************************
		****************************************************************
		Text To This.DefaultFileContents Noshow
Lparameters tcApplicationName, tcInstallationFolder

		Endtext
		****************************************************************
		****************************************************************
	Endproc

Enddefine


****************************************************************
****************************************************************

Define Class clsAfterComponentInstall As Custom

	Source				= 'Thor'
	PlugIn				=  [�����װ��] 
	Description			=  [�ڼ������ڼ䰲װ�������Thor \ Tools \ Components�����ļ����У����á�] 
	Tools				=  [������] 
	FileNames			= 'Thor_Proc_AfterComponentInstall.PRG'
	DefaultFileName		= '*Thor_Proc_AfterComponentInstall.PRG'
	DefaultFileContents	= ''

	Procedure Init
		****************************************************************
		****************************************************************
		Text To This.DefaultFileContents Noshow
Lparameters tcApplicationName, tcInstallationFolder

		Endtext
		****************************************************************
		****************************************************************
	Endproc

Enddefine
