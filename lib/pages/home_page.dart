import 'package:budget_tracker/controllers/dbhelper.dart';
import 'package:budget_tracker/pages/add_transaction.dart';
// ignore: library_prefixes
import 'package:budget_tracker/static.dart' as Static;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper db = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Image.asset(
            "assets/emoji.png",
          ),
        ),
        title: const Text("Welcome Chanshu!"),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.settings,
                size: 36,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: db.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong."));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No values found."));
              }
              getTotalBalance(snapshot.data!);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dashboardCard(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Recent Expenses",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) {
                            Map dataAtIndex = snapshot.data![index];
                            return Card(
                              color: Static.PrimaryColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              child: incomeExpenseTile(
                                dataAtIndex['type'],
                                dataAtIndex['amount'].toString(),
                                dataAtIndex['note'],
                                dataAtIndex['date'],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const AddTransaction()))
              .whenComplete(() {
            setState(() {});
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget incomeExpenseTile(
      String type, String amount, String note, DateTime date) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: type == "Income"
            ? const Icon(
                Icons.arrow_upward,
                size: 28,
                color: Colors.green,
              )
            : const Icon(
                Icons.arrow_downward,
                size: 28,
                color: Colors.red,
              ),
      ),
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                note,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                Text(
                  "${date.day}/${date.month}/${date.year}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Rs. $amount",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            ]),
      ),
    ]);
  }

  Widget dashboardCard() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(14.0),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [Static.PrimaryColor, Colors.pink]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Rs. $totalBalance",
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              incomeExpense("Income", totalIncome.toString()),
              incomeExpense("Expense", totalExpense.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget incomeExpense(String type, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: type == "Income"
              ? const Icon(
                  Icons.arrow_upward,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.arrow_downward,
                  color: Colors.red,
                ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              "Rs. $price",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
