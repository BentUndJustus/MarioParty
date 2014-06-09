init()
{
	if (!level.gameRunning)
	{
		self thread createlobby();
	}

	else 
	{
		 kick( self getEntityNumber(), "EXE_PLAYERKICKED" );
	}
}

lobby() 
{




}








/////Baufunktionen


CreateWalls(start, end) 
{ 		
		block = [];
		block[] = [];
		block[][] = [];

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
		block[] = [];
		block[][] = [];

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
}









