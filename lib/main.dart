import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';
void main(){
  runApp(MaterialApp(
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: "Be yourself; everyone else is already taken", author: "Oscar Wilde"),
     Quote(text: "I have nothing to declare except my genius", author: "Oscar Wilde"),
     Quote(text: "The truth is rarely pure and never simple", author: "Oscar Wilde"),
  ];


  int currentQuoteIndex = 0;
  void delete({required Quote quote, required List<Quote> quotes}){
    setState(() {
      quotes.remove(quote);
      if (currentQuoteIndex == quotes.length){
        currentQuoteIndex = quotes.length - 1;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text( 
          "Awesome Quotes",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2
          ),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (quotes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QuoteCard(
                  quote: quotes[currentQuoteIndex],
                  delete: () => delete(
                    quote: quotes[currentQuoteIndex], 
                    quotes: quotes, 
                    )
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton.icon(
                    onPressed: (){
                      setState(() {
                        currentQuoteIndex = (currentQuoteIndex+1) % quotes.length;
                      });
                    },
                    icon: Icon(Icons.skip_next), 
                    label: Text("Next"),
                    iconAlignment: IconAlignment.end,
                  ),
                ]
              ),
              
              SizedBox(height: 50,),
              Column(
                children: quotes.map((quote)=> QuoteCard(
                  quote: quote,
                  delete: () => delete(
                    quote: quote, 
                    quotes: quotes, 
                )
                  )).toList(),
              )
            ],
        ),
      ),
    );
  }
}

