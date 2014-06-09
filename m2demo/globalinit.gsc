init() 
{

	level thread onPlayerConnect();

}


onPlayerConnect() 
{
	level endon("disconnect");

	for(;;) {
		level waittill( "connected", player );


		player thread onPlayerSpawned();
	}
}


onPlayerSpawned() 
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");
		self thread gamelogic::init();		

	}
}