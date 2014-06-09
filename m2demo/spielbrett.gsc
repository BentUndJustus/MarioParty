
init()
{	
	
self.currentfeld=0;
}

create()
{	
	feld = [];
	for(counter=0;counter<50;counter++)
	{
		feld[counter]= spawn("script_model", ((1000,1000,1000) + ((50*counter),(10*counter), (10*counter)) )) ; 
        feld[counter] setModel("com_plasticcase_friendly"); 
        feld[counter].angles = (0,0,0); 
        feld[counter] Solid(); 
        feld[counter] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        wait 0.0001; 
	}
}

move(zahl)
{
	self SetOrigin((1000,1000,1000) + ((50*zahl),(10*zahl), (10*zahl)));
}
