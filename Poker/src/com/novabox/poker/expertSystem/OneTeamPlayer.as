package com.novabox.poker.expertSystem 
{
	
	import com.novabox.playingCards.Deck;
	import com.novabox.playingCards.Height;
	import com.novabox.playingCards.PlayingCard;
	import com.novabox.playingCards.Suit;
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
		
		public static const FactPreFlop:Fact = new Fact("PreFlop");
		public static const FactFlop:Fact = new Fact("Flop");
		public static const FactTurn:Fact = new Fact("Turn");
		public static const FactRiver:Fact = new Fact("River");
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
		public static const FactRelancer:Fact = new Fact("Relancer");
		public static const FactSuivre:Fact = new Fact("Suivre");
		public static const FactSeCoucher:Fact = new Fact("Se Coucher");
		public static const FactChecker:Fact = new Fact("Checker");

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
			//PreFlop rules
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactPreFlop, FactJeuTresBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuTresBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuTresBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuTresBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactPreFlop, FactJeuBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuMoyen, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactPreFlop, FactJeuMoyen, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactPreFlop, FactJeuMoyen, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactPreFlop, FactJeuMoyen, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuFaible, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuFaible, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactPreFlop, FactJeuFaible, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactPreFlop, FactJeuFaible, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuNul, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuNul, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactPreFlop, FactJeuNul, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactPreFlop, FactJeuNul, FactPeutChecker)));
			//Flop rules
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactFlop, FactJeuTresBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactFlop, FactJeuTresBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactFlop, FactJeuTresBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactFlop, FactJeuTresBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactFlop, FactJeuBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactFlop, FactJeuBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactFlop, FactJeuBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactFlop, FactJeuBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuMoyen, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactFlop, FactJeuMoyen, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactFlop, FactJeuMoyen, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactFlop, FactJeuMoyen, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuFaible, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuFaible, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuFaible, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactFlop, FactJeuFaible, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuNul, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuNul, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactFlop, FactJeuNul, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactFlop, FactJeuNul, FactPeutChecker)));
			//turn rules
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuTresBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuTresBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuTresBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactTurn, FactJeuTresBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactTurn, FactJeuBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuMoyen, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuMoyen, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactTurn, FactJeuMoyen, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactTurn, FactJeuMoyen, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuFaible, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuFaible, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuFaible, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactTurn, FactJeuFaible, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuNul, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuNul, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactTurn, FactJeuNul, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactTurn, FactJeuNul, FactPeutChecker)));
			//River rules
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactRiver, FactJeuTresBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactRiver, FactJeuTresBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactRiver, FactJeuTresBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactRiver, FactJeuTresBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactRiver, FactJeuBon, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactRiver, FactJeuBon, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactRiver, FactJeuBon, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactRelancer , new Array(FactRiver, FactJeuBon, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuMoyen, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuMoyen, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSuivre , new Array(FactRiver, FactJeuMoyen, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactRiver, FactJeuMoyen, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuFaible, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuFaible, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuFaible, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactRiver, FactJeuFaible, FactPeutChecker)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuNul, FactMiseImportante)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuNul, FactMiseMoyenne)));
			expertSystem.AddRule(new Rule(FactSeCoucher , new Array(FactRiver, FactJeuNul, FactMiseFaible)));
			expertSystem.AddRule(new Rule(FactChecker , new Array(FactRiver, FactJeuNul, FactPeutChecker)));
		}
		

		
		protected function lancerChainage() : void
		{
			expertSystem.ResetFacts();
			//chainage avant
			expertSystem.InferForward();
			
			var inferedFacts:Array = expertSystem.GetInferedFacts();
			trace("Infered Facts:");
			
			for each(var inferedFact:Fact in inferedFacts)
			{
				trace(inferedFact.GetLabel());
			}
	
			//reinit systeme
			
			
			//chainage arrière 
			/*expertSystem.InferBackward();
			var factsToAsk:Array = expertSystem.GetFactsToAsk();
			trace("Facts to ask :");
			for each(var factToAsk:Fact in factsToAsk)
			{
				trace(factToAsk.GetLabel());
			}*/

		}
		
		override public function Play(_pokerTable:PokerTable) : Boolean
		{
			pokerTable = _pokerTable;
			
			/*Perception();
			Analyse();
			Action();*/
			
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
		
		public function GetIndexNextPlayer() : int {
			
		}
		
		public function probabiliteGain() : Number {
			
			var probabilite : Number = 0.0;
			var card1:PlayingCard;
			var card2:PlayingCard;
			var board:Array;
			var deck : Deck;
			var i:int;
			
			
			for (i = 0; i < 1000; i++) {
				
				deck = new Deck();
				board = new Array();
				
				deck.RemoveCard(GetCard(0));
				deck.RemoveCard(GetCard(1));
				
				for (i = 0; i < GetNumberCardsBoard(); i++ ) {
					board.push(pokerTable.GetBoard()[i]);
					deck.RemoveCard(board[i]);
				}	
				
				deck.Shuffle();
				
				card1 = deck.GetTopCard();
				card2 = deck.GetTopCard();
				
				for (i = 0; i < 5 - GetNumberCardsBoard(); i++) {
					board.push(deck.GetTopCard());
				}
				
			}			
		}
		
		public function Perception():void
		{
			if (GetNumberCardsBoard() == 0) {
				trace("Valeur main preflop : " + GetValuePreflop());
				
			}
			else {
				
				
				
				
				
				
			}
			return 0;
			
		}
		
		public function Analyse():void
		{
			
		}
		
		public function Action(i:int):void
		{
			if (i == check)
			{
				Check();
			}
			else if (i == call) 
			{
				Call(pokerTable.GetValueToCall());
			}
			else if (i == raise)
			{
				Raise(pokerTable.GetBigBlind(), pokerTable.GetValueToCall());
			}
			else if (i == fold) 
			{
				Fold();
			}
		}
		
	}

}