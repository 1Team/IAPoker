package com.novabox.poker 
{
	/**
	 * ...
	 * @author Alex
	 */
	public class OneTeamPlayer extends PokerPlayer
	{
		
		public function OneTeamPlayer(_name:String, _stackValue:Number) 
		{
			super(_name, _stackValue);
		}
		
		override public function Play(_pokerTable:PokerTable) : Boolean
		{
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
	}

}