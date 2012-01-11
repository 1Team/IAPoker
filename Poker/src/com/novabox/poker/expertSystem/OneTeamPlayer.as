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
		
		private var expertSystem:ExpertSystem;
		
		public static const FactPeutChecker:Fact = new Fact("Peut Checker");
		public static const FactMiseFaible:Fact = new Fact("Mise Faible");
		public static const FactMiseMoyenne:Fact = new Fact("Mise Moyenne");
		public static const FactMiseImportante:Fact = new Fact("Mise Importante");
		public static const FactJeuNul:Fact = new Fact("Jeu Nul");
		public static const FactJeuFaible:Fact = new Fact("Jeu Faible");
		public static const FactJeuMoyen:Fact = new Fact("Jeu Moyen");
		public static const FactJeuBon:Fact = new Fact("Jeu Bon");
		public static const FactJeuTresBon:Fact = new Fact("Jeu Tres Bon");
		public static const FactPeutRelancer:Fact = new Fact("Peut Relancer");

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
			
			expertSystem = new ExpertSystem();
			
			prepareRules();
		}
		
		protected function prepareRules() : void
		{
			/* to do base régle
			expertSystem.AddRule(new Rule(FactC, new Array(FactA, FactB)));
			expertSystem.AddRule(new Rule(FactF, new Array(FactD, FactE)));
			expertSystem.AddRule(new Rule(FactE, new Array(FactG)));*/
		}
		

		
		protected function lancerChainage() : void
		{

			//chainage avant
			expertSystem.InferForward();
			
			var inferedFacts:Array = expertSystem.GetInferedFacts();
			trace("Infered Facts:");
			
			for each(var inferedFact:Fact in inferedFacts)
			{
				trace(inferedFact.GetLabel());
			}
	
			//reinit systeme
			expertSystem.ResetFacts();
			
			//chainage arrière 
			expertSystem.InferBackward();
			var factsToAsk:Array = expertSystem.GetFactsToAsk();
			trace("Facts to ask :");
			for each(var factToAsk:Fact in factsToAsk)
			{
				trace(factToAsk.GetLabel());
			}

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
		
		public function Perception():void
		{
			if (GetNumberCardsBoard() == 0) {
				trace(this.GetCard(0).GetHeight());
				trace(this.GetCard(1).GetHeight());
				
				trace(preFlop[GetCard(0).GetHeight()][this.GetCard(1).GetHeight()]);
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
		
		public function check() {
			
		}
		
		public function call() {
			
		}
		public function raise() {
			
		}
		public function fold() {
			
		}
	}

}