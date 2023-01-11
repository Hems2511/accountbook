//{id: 1, acid: 1, date: 11/1/2023,
// amount: 1000, type: debit, reason: nasta}
class Transaction
{
  int id,acid,amount;
  String date,reason,type;

  Transaction(
      this.id, this.acid, this.amount, this.date, this.reason, this.type);

  @override
  String toString() {
    return 'Transaction{id: $id, acid: $acid, amount: $amount, date: $date, reason: $reason, type: $type}';
  }
  static Transaction fromMap(Map m)
  {
    return Transaction(m['id'], m['acid'], m['amount'], m['date'], m['reason'], m['type']);
  }

}