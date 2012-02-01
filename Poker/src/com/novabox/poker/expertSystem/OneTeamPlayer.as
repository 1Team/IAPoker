package com.novabox.poker.expertSystem 
{
	
	import com.novabox.playingCards.Deck;
	import com.novabox.playingCards.Height;
	import com.novabox.playingCards.PlayingCard;
	import com.novabox.playingCards.Suit;
	import com.novabox.poker.PokerPlayer
	import com.novabox.poker.PokerTable
	import com.novabox.poker.PokerAction
	import com.novabox.poker.PokerTools;
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
			//Action();
			
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
		
		public function probabiliteGain() : Number {
			
			var probabilite : Number = 0.0;
			var board:Array, main1:Array, main2:Array;
			var deck:Deck = new Deck();
			var i:int, score1:int, score2:int, cardIndex1:int, cardIndex2:int;
			var gagne:int = 0;
			
			deck.RemoveCard(GetCard(0));
			deck.RemoveCard(GetCard(1));
			
			main1 = new Array();
			main2 = new Array();
			main1[0] = GetCard(0);
			main1[1] = GetCard(1);
			
			
				
			for (i = 0; i < GetNumberCardsBoard(); i++ ) {
				main1[i+2] = pokerTable.GetBoard()[i];
				main2[i+2] = pokerTable.GetBoard()[i];
				deck.RemoveCard(pokerTable.GetBoard()[i]);
			}
			
			deck.Shuffle();
			
			for (i = 0; i < 1000; i++) {
				
				cardIndex1 = Math.random() * (52 - 2 - GetNumberCardsBoard());
				cardIndex2 = Math.random() * (52 - 2 - GetNumberCardsBoard());
				
				if (cardIndex1 != cardIndex2) {
					main2[0] = deck.GetCard(cardIndex1);
					main2[1] = deck.GetCard(cardIndex2);
					
					if (GetNumberCardsBoard() == 4) {
						var river:int = Math.random() * (52 - 2 - GetNumberCardsBoard());
						if (river != cardIndex1 && river != cardIndex2) {
							main1[6] = deck.GetCard(river);
							main2[6] = deck.GetCard(river);
						}
					}
					
					if ((main1.length == 5 || main1.length == 7) && (main2.length == 5 || main2.length == 7)) {
						score1 = PokerTools.GetCardSetValue(main1);
						score2 = PokerTools.GetCardSetValue(main2);
					}
					
					if (score1 < score2 && score1 != 0)
						gagne++;
				}
			}
			probabilite = gagne / 1000;
			return probabilite;
		}
		
		public function Perception():void
		{
			if (GetNumberCardsBoard() == 0) {
				trace("Valeur main preflop : " + GetValuePreflop());
			}
			else {
				trace("Probabilité de gagné : " + probabiliteGain());
				
			}
			
			
		}
		
		public function Analyse():void
		{
			
		}
		
		public function Action(i:int):void
		{
			if (i == check) {
				Check();
			}
			else {
				if (i == call) {
					Call(pokerTable.GetValueToCall());
				}else {
					if(i == raise) {
						Raise(pokerTable.GetBigBlind(), pokerTable.GetValueToCall());
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