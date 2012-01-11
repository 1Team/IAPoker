package com.novabox.poker.expertSystem 
{
	
	import com.novabox.poker.PokerPlayer
	import com.novabox.poker.PokerTable
	import com.novabox.poker.PokerAction
	/**
	 * ...
	 * @author Alex, Brian, Ikram, Maxime, Clément
	 */
	public class OneTeamPlayer extends PokerPlayer
	{
		
<<<<<<< HEAD
		private var check : int = 0;
		private var call : int = 1 ;
		private var raise : int = 2 ;
		private var fold : int = 3 ;
=======
		private var preFlop:Array = [	[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
										[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
										[0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1],
										[0, 0, 1, 2, 1, 1, 0, 0, 0, 0, 0, 1, 1],
										[0, 0, 0, 1, 2, 1, 1, 1, 0, 0, 0, 1, 2],
										[0, 0, 0, 1, 1, 3, 1, 1, 1, 1, 0, 1, 2],
										[0, 0, 0, 0, 1, 1, 3, 2, 2, 2, 2, 1, 2],
										[0, 0, 0, 0, 1, 1, 2, 3, 3, 3, 2, 2, 2],
										[0, 0, 0, 0, 0, 1, 2, 3, 3, 3, 3, 3, 3],
										[0, 0, 0, 0, 0, 1, 2, 3, 3, 3, 3, 3, 3],
										[0, 0, 0, 0, 0, 0, 2, 2, 3, 3, 3, 3, 3],
										[1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 3, 3, 3],
										[1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3]];
>>>>>>> 6e6ae39406bf861d0d1668659e1a07135a4517af
		
		public function OneTeamPlayer(_name:String, _stackValue:Number) 
		{
			super(_name, _stackValue);
		}
		
		override public function Play(_pokerTable:PokerTable) : Boolean
		{	
			Perception();
			Analyse();
			Action();
			
			if (CanCheck(_pokerTable))
			{
				Check();
			}
			else 
			{
				if ((GetCard(0) && GetCard(0).GetHeight() > 8) || (GetCard(1) && GetCard(1).GetHeight() > 8) || (_pokerTable.GetValueToCall() < 5 && GetStackValue() >= _pokerTable.GetValueToCall()))
				{
					Call(_pokerTable.GetValueToCall());
				}
				else
				{
					Fold();
				}
			}
			return (lastAction != PokerAction.NONE);
		}
		
		public function Perception():void
		{
			
			
			
			
		}
		
		public function Analyse():void
		{
			
		}
		
		public function Action(i:int, _pokerTable:PokerTable):void
		{
			if (i == check) {
				Check();
			}
			else {
				if (i == call) {
					Call(_pokerTable.GetValueToCall());
				}else {
					if(i == raise) {
						Raise(_pokerTable.GetBigBlind(), _pokerTable.GetValueToCall());
					}else {
						if (i == fold) {
								Fold();

						}
					}
				}
			}
		}
		
	}

}