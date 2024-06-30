import 'package:flutter/material.dart';
import 'package:nhonn1/Card/Card_i4.dart';

//121352467987216489
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _input = TextEditingController();
  List<List<int>> _danhSachList = [];
  List<int> _sumList = [];

  int indexSumMin = 0;
  int indexSumMax = 0;

  int index_min = 0;
  int index_max = 0;

  void findMaxSumListIndex() {
    int tmp = _sumList[0];

    for (int i = 1; i < _sumList.length; i++) {
      if (_sumList[i] > tmp) {
        tmp = _sumList[i];
        indexSumMax = i;
      }
    }
  }

  void findMinSumListIndex() {
    int tmp = _sumList[0];

    for (int i = 1; i < _sumList.length; i++) {
      if (_sumList[i] < tmp) {
        tmp = _sumList[i];
        indexSumMin = i;
      }
    }
  }

  void findMaxLengthListIndex() {
    int tmp = _danhSachList[0].length;

    for (int i = 1; i < _danhSachList.length; i++) {
      if (_danhSachList[i].length > tmp) {
        tmp = _danhSachList[i].length;
        index_max = i;
      }
    }
  }

  void findMinLengthListIndex() {
    int tmp = _danhSachList[0].length;

    for (int i = 1; i < _danhSachList.length; i++) {
      if (_danhSachList[i].length < tmp) {
        tmp = _danhSachList[i].length;
        index_min = i;
      }
    }
  }

  void addDanhSachList(List<int> input) {
    int start = 0;
    int end = 0;

    for (int i = 1; i < input.length; i++) {
      if (input[i] > input[i - 1]) {
        end = i;
      } else {
        if (start != end) {
          List<int> subarray = input.sublist(start, end + 1);
          _danhSachList.add(subarray);
        }
        start = i;
        end = i;
      }
    }

    // Xử lý nếu 2 số cuối là 1 dãy tăng
    if (start != end) {
      List<int> subarray = input.sublist(start, end + 1);
      _danhSachList.add(subarray);
    }
  }

  void addSumLists() {
    for (var list in _danhSachList) {
      int sum = 0;
      for(var element in list) {
        sum += element;
      }
      _sumList.add(sum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //top
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            //color: Colors.black,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _input,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nhập dãy",
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      setState(() {
                        List<int> daySo = _input.text
                            .split('')
                            .map((e) => int.tryParse(e.trim()))
                            .where((e) => e != null)
                            .toList()
                            .cast<int>();;
                        addDanhSachList(daySo);
                        addSumLists();

                        findMaxLengthListIndex();
                        findMinLengthListIndex();
                        findMaxSumListIndex();
                        findMinSumListIndex();

                      });
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFEFEFF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                        child: Text(
                          "Enter",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //main content
          Container(
            height: MediaQuery.of(context).size.height*0.85,
            //color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  //bên trái
                  Container(
                    width: (MediaQuery.of(context).size.width-20)*0.65,
                    //color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height*0.85 - 20) * 0.05,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              "Danh sách dãy con liên tục",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        //danh sách
                        Container(
                          height: (MediaQuery.of(context).size.height*0.85 - 20) * 0.95,
                          //color: Colors.black,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [

                                for(int i = 0; i < _danhSachList.length; i++)
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0, top: 0, right:10, bottom: 10),
                                      child: Card_i4(list: _danhSachList[i], sum: _sumList[i]),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //bên phải
                  Container(
                    width: (MediaQuery.of(context).size.width-20)*0.35,
                    //color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dãy con liên tiếp dài nhất",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),

                              ),

                              Text(
                                _danhSachList.isNotEmpty
                                    ? _danhSachList[index_max].toString()
                                    : '',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dãy con liên tiếp ngắn nhất",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),

                              ),

                              Text(
                                _danhSachList.isNotEmpty
                                    ? _danhSachList[index_min].toString()
                                    : '',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dãy con liên tiếp có tổng lớn nhất",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),

                              ),

                              Text(
                                _danhSachList.isNotEmpty
                                    ? _danhSachList[indexSumMax].toString()
                                    : '',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dãy con liên tiếp có tổng nhỏ nhất",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),

                              ),

                              Text(
                                _danhSachList.isNotEmpty
                                    ? _danhSachList[indexSumMin].toString()
                                    : '',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
