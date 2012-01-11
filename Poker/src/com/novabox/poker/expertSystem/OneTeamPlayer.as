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
		private var pokerTable:PokerTable;

		private var check : int = 0;
		private var call : int = 1 ;
		private var raise : int = 2 ;
		private var fold : int = 3 ;

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
		
		public function OneTeamPlayer(_name:String, _stackValue:Number) 
		{
			super(_name, _stackValue);
		}
		
		override public function Play(_pokerTable:PokerTable) : Boolean
		{
			pokerTable = _pokerTable;
			
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
		
		public function GetNumberCardsBoard():int
		{
			return pokerTable.GetBoard().length;
		}
		
		public function GetValuePreflop() : int {
			return preFlop[GetCard(0).GetHeight()][GetCard(1).GetHeight()];
		}
		
		
		
		public function Perception():int
		{
			if (GetNumberCardsBoard() == 0) {
				trace("Valeur main preflop : " + GetValuePreflop());
				return GetValuePreflop();
			}
			else {
				
				return 0;
				
			}
			
			
		}
		
		public function Analyse():void
		{
			
		}
		
		public function Action(i:int):void
		{
			if (i == check) {
				//checker
			}
			else {
				if (i == call) {
					//suivre la mise
				}else {
					if(i == raise) {
						//relancer
					}else {
						if (i == fold) {
								//se coucher
								
								
						}
					}
				}
			}
		}
	}

}