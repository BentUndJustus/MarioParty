init() 
{
	level.gameRunning=false;
	level thread onPlayerConnect();
	thread gamelogic::init();
}


onPlayerConnect() 
{
	level endon("disconnect");

	for(;;) {
		level waittill( "connected", player );

		if (level.gameRunning) 
		{
			kick( player getEntityNumber(), "EXE_PLAYERKICKED" );
		}
		player thread onPlayerSpawned();
	}
}


onPlayerSpawned() 
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");
		self thread gamelogic::initaliseLobby();		

	}
}