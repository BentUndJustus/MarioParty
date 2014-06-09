#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


init()
{
	
		level thread createlobby();
	
}

createlobby() 
{	

	level.walla = [];
	level.walla[1] = [];
	level.walla[1][1] = [];

	level.wallb = [];
	level.wallb[1] = [];
	level.wallb[1][1] = [];

	level.wallc = [];
	level.wallc[1] = [];
	level.wallc[1][1] = [];

	level.walld = [];
	level.walld[1] = [];
	level.walld[1][1] = [];

	level.floor = [];
	level.floor[1] = [];
	level.floor[1][1] = [];

	level.walla = CreateWalls((5000,5000,5000),(5000,5050,5200));
	level.wallb = CreateWalls((5000,5000,5200),(5200,5050,5200));
	level.wallc = CreateWalls((5200,5000,5200),(5200,5050,5000));
	level.walld = CreateWalls((5200,5000,5000),(5000,5050,5000));
	level.floor = CreateGrids((5000,5000,5000),(5200,5050,5000),(0,0,0));

	
	

}

initaliseLobby()
{	
	self endon("disconnect");
	self thread deleteLobby();
	self takeAllWeapons();
	self SetOrigin( (5050,5050,5050) );
	self clearPerks();

	self.lobbyRect = createRectangle("BOTTOMRIGHT", "BOTTOMRIGHT", 0, 0, 240, 60, (0.40, 0.40, 0.40), "white",0 ,0.5);
	self.lobbyText = self createFontString("default", 1.5);
    self.lobbyText setPoint("BOTTOMRIGHT", "BOTTOMRIGHT", -5, -30);	
    self.lobbyText setText("Lobby: Wait till the Host starts the game");
    
    // if (self.name=="Ju57u5")
    // {
    	self notifyOnPlayerCommand("n", "+actionslot 1");
    	self waittill("n");
    	self iprintln("testtestesttest");
    	level notify("gamestart");
    // }


}

deleteLobby() 
{
	level waittill("gamestart");
	self iprintln("hallo?");
	/*
	for(counter=0;counter<level.walla.length;counter++) {
		level.walla[counter] delete();
		// level.walla[counter] destroy();			
	}
	for(counter=0;counter<level.walla[1].length;counter++) {
		level.walla[1][counter] delete();
		// level.walla[1][counter] destroy();
	}
	for(counter=0;counter<level.walla[1][1].length;counter++) {
		level.walla[1][1][counter] delete();
		// level.walla[1][1][counter] destroy();
	}
//////////////////////////////////////////////////////////////////////////////////////
	for(counter=0;counter<level.wallb.length;counter++) {
		level.wallb[counter] delete();
		// level.wallb[counter] destroy();			
	}
	for(counter=0;counter<level.wallb[1].length;counter++) {
		level.wallb[1][counter] delete();
		// level.wallb[1][counter] destroy();
	}
	for(counter=0;counter<level.wallb[1][1].length;counter++) {
		level.wallb[1][1][counter] delete();
		// level.wallb[1][1][counter] destroy();
	}
//////////////////////////////////////////////////////////////////////////////////////
	for(counter=0;counter<level.wallc.length;counter++) {
		level.wallc[counter] delete();
		// level.wallc[counter] destroy();			
	}
	for(counter=0;counter<level.wallc[1].length;counter++) {
		level.wallc[1][counter] delete();
		// level.wallc[1][counter] destroy();
	}
	for(counter=0;counter<level.wallc[1][1].length;counter++) {
		level.wallc[1][1][counter] delete();
		// level.wallc[1][1][counter] destroy();
	}
//////////////////////////////////////////////////////////////////////////////////////
	for(counter=0;counter<level.floor.length;counter++) {
		level.floor[counter] delete();
		// level.floor[counter] destroy();			
	}
	for(counter=0;counter<level.floor[1].length;counter++) {
		level.floor[1][counter] delete();
		// level.floor[1][counter] destroy();
	}
	for(counter=0;counter<level.floor[1][1].length;counter++) {
		level.floor[1][1][counter] delete();
		// level.floor[1][1][counter] destroy();
	}
	*/
	self.lobbyText delete();
	self.lobbyText destroy();
   
	self SetOrigin( (1000,1000,1000) );
	level.gameRunning=true;
	self thread dogame();
}

dogame()
{
	self spielbrett::init();
	while (level.gameRunning)
	{
		self spielbrett::create();
		self wuerfeln();
		self minigames\spleef::init();

		self spielbrett::create();
		self wuerfeln();
		self minigames\dm::init();
		
		self spielbrett::create();
		self wuerfeln();
		self minigames\rennen::init();
		
		self spielbrett::create();
		self wuerfeln();
		self minigames\gungame::init();
		wait 0.1;
	}
}

wuerfeln()
{	
	self.wuerfel=true;
	self thread wurf();
	// self.wuerfelhud = createRectangle("CENTER", "MIDDLE", 0, 0, 100, 50, (0.40, 0.40, 0.40), "white",0 ,0.5);
	// self.wuefeltext = self createFontString( "default", 1.5, self );
	// self.wuefeltext.X = 300;
	// self.wuefeltext.Y = 100;
	self.zahl = 1;
	self thread maps\mp\gametypes\_hud_message::hintMessage("Roll the Dice");
	wait 1;

	while(self.wuerfel) 
	{	
		if(self.zahl>5) {self.zahl=1;}
		else {self.zahl++;}
		// self.wuefeltext setText(self.zahl);
		self iprintlnBold(self.zahl);
		
		wait 0.1;
	}
	self.currentfeld=self.zahl+self.currentfeld;
	self spielbrett::move(self.currentfeld);
	if (self.currentfeld>=50)
	{
		self thread win();
	}
}	

wurf()
{	
	self notifyOnPlayerCommand("n", "+actionslot 1");
	self waittill("n");
	self.wuerfel=false;
}

win()
{
	self iprintlnBold("^2WINNER!!!");
}


/////Baufunktionen-------------------------------------


CreateWalls(start, end) 
{ 		
		block = [];
		block[1] = [];
		block[1][1] = [];

        D = Distance((start[0], start[1], 0), (end[0], end[1], 0)); 
        H = Distance((0, 0, start[2]), (0, 0, end[2])); 
        blocks = roundUp(D/55); 
        height = roundUp(H/30); 
        CX = end[0] - start[0]; 
        CY = end[1] - start[1]; 
        CZ = end[2] - start[2]; 
        XA = (CX/blocks); 
        YA = (CY/blocks); 
        ZA = (CZ/height); 
        TXA = (XA/4); 
        TYA = (YA/4); 
        Temp = VectorToAngles(end - start); 
        Angle = (0, Temp[1], 90); 
        for(h = 0; h < height; h++){ 
                block[1][h] = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h))); 
                block[1][h] setModel("com_plasticcase_friendly"); 
                block[1][h].angles = Angle; 
                block[1][h] Solid(); 
                block[1][h] CloneBrushmodelToScriptmodel( level.airDropCrateCollision ); 
                wait 0.001; 
                for(i = 1; i < blocks; i++){ 
                        block[1][h][i] = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h))); 
                        block[1][h][i] setModel("com_plasticcase_friendly"); 
                        block[1][h][i].angles = Angle; 
                        block[1][h][i] Solid(); 
                        block[1][h][i] CloneBrushmodelToScriptmodel( level.airDropCrateCollision ); 
                        wait 0.001; 
                } 
                block[2][h] = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h))); 
                block[2][h] setModel("com_plasticcase_friendly"); 
                block[2][h].angles = Angle; 
                block[2][h] Solid(); 
                block[2][h] CloneBrushmodelToScriptmodel( level.airDropCrateCollision ); 
                wait 0.001; 
        }
        return block; 
} 
 
roundUp( floatVal ) 
{ 
        if ( int( floatVal ) != floatVal ) 
                return int( floatVal+1 ); 
        else 
                return int( floatVal ); 
}

CreateGrids(corner1, corner2, angle) 
{
		block = [];
		block[1] = [];
		block[1][1] = [];

        W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0)); 
        L = Distance((0, corner1[1], 0), (0, corner2[1], 0)); 
        H = Distance((0, 0, corner1[2]), (0, 0, corner2[2])); 
        CX = corner2[0] - corner1[0]; 
        CY = corner2[1] - corner1[1]; 
        CZ = corner2[2] - corner1[2]; 
        ROWS = roundUp(W/55); 
        COLUMNS = roundUp(L/30); 
        HEIGHT = roundUp(H/20); 
        XA = CX/ROWS; 
        YA = CY/COLUMNS; 
        ZA = CZ/HEIGHT; 
        center = spawn("script_model", corner1); 
        for(r = 0; r <= ROWS; r++){ 
                for(c = 0; c <= COLUMNS; c++){ 
                        for(h = 0; h <= HEIGHT; h++){ 
                                block[r][c][h] = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h))); 
                                block[r][c][h] setModel("com_plasticcase_friendly"); 
                                block[r][c][h].angles = (0, 0, 0); 
                                block[r][c][h] Solid(); 
                                block[r][c][h] LinkTo(center); 
                                block[r][c][h] CloneBrushmodelToScriptmodel( level.airDropCrateCollision ); 
                                wait 0.01; 
                        } 
                } 
        } 
        center.angles = angle; 
        return block;
}

//Hud Funktionen --------------------------------

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.width = width;
    boxElem.height = height;
    boxElem.align = align;
    boxElem.relative = relative;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem.shader = shader;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}







