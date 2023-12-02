import 'package:budget_tracker/controllers/dbhelper.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:budget_tracker/static.dart' as Static;
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "";
  String type = "Expense";
  DateTime selectedDate = DateTime.now();

  // show date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010, 1),
        lastDate: DateTime(2099, 12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.attach_money,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    try {
                      amount = int.parse(value);
                    } catch (e) {
                      debugPrint("amount can't be null!");
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 24),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.description,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    note = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Note on Transaction",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.moving_sharp,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                      fontSize: 18,
                      color: type == "Income" ? Colors.white : Colors.black),
                ),
                selected: type == "Income" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (value) {
                  if (value) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                      fontSize: 18,
                      color: type == "Expense" ? Colors.white : Colors.black),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (value) {
                  if (value) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              TextButton(
                  onPressed: () {
                    selectDate(context);
                  },
                  child: Text(
                    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (amount != null && note.isNotEmpty) {
                  DbHelper db = DbHelper();
                  await db
                      .addData(amount, selectedDate, note, type)
                      .whenComplete(() => Navigator.of(context).pop());
                } else {
                  debugPrint("Not all values are provided.");
                }
              },
              child: const Text(
                "ADD",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
