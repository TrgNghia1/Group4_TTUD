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
  List<int> indexSumMin = [];
  List<int> indexSumMax = [];
  List<int> index_min = [];
  List<int> index_max = [];
  String _errorMessage = '';

  void findMaxSumListIndices() {
    int maxSum = _sumList[0];
    indexSumMax = [0];

    for (int i = 1; i < _sumList.length; i++) {
      if (_sumList[i] > maxSum) {
        maxSum = _sumList[i];
        indexSumMax = [i];
      } else if (_sumList[i] == maxSum) {
        indexSumMax.add(i);
      }
    }
  }

  void findMinSumListIndices() {
    int minSum = _sumList[0];
    indexSumMin = [0];

    for (int i = 1; i < _sumList.length; i++) {
      if (_sumList[i] < minSum) {
        minSum = _sumList[i];
        indexSumMin = [i];
      } else if (_sumList[i] == minSum) {
        indexSumMin.add(i);
      }
    }
  }

  void findMaxLengthListIndices() {
    int maxLength = _danhSachList[0].length;
    index_max = [0];

    for (int i = 1; i < _danhSachList.length; i++) {
      if (_danhSachList[i].length > maxLength) {
        maxLength = _danhSachList[i].length;
        index_max = [i];
      } else if (_danhSachList[i].length == maxLength) {
        index_max.add(i);
      }
    }
  }

  void findMinLengthListIndices() {
    int minLength = _danhSachList[0].length;
    index_min = [0];

    for (int i = 1; i < _danhSachList.length; i++) {
      if (_danhSachList[i].length < minLength) {
        minLength = _danhSachList[i].length;
        index_min = [i];
      } else if (_danhSachList[i].length == minLength) {
        index_min.add(i);
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

    if (start != end) {
      List<int> subarray = input.sublist(start, end + 1);
      _danhSachList.add(subarray);
    }
  }

  void addSumLists() {
    for (var list in _danhSachList) {
      int sum = 0;
      for (var element in list) {
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
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _input,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nhập dãy số nguyên",
                              errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                            ),
                            keyboardType: TextInputType.number,
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
                                .cast<int>();
                            if (daySo.isEmpty || daySo.length != _input.text.length) {
                              _errorMessage = "Vui lòng chỉ nhập số nguyên.";
                              return;
                            }
                            _errorMessage = '';
                            _danhSachList.clear();
                            _sumList.clear();
                            addDanhSachList(daySo);
                            addSumLists();
                            findMaxLengthListIndices();
                            findMinLengthListIndices();
                            findMaxSumListIndices();
                            findMinSumListIndices();
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
                ],
              ),
            ),
          ),
          //main content
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  //bên trái
                  Container(
                    width: (MediaQuery.of(context).size.width - 20) * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height * 0.85 - 20) * 0.05,
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
                          height: (MediaQuery.of(context).size.height * 0.85 - 20) * 0.95,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < _danhSachList.length; i++)
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 10),
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
                    width: (MediaQuery.of(context).size.width - 20) * 0.35,
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
                              for (var index in index_max)
                                Text(
                                  _danhSachList.isNotEmpty ? _danhSachList[index].toString() : '',
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
                              for (var index in index_min)
                                Text(
                                  _danhSachList.isNotEmpty ? _danhSachList[index].toString() : '',
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
                              for (var index in indexSumMax)
                                Text(
                                  _danhSachList.isNotEmpty ? _danhSachList[index].toString() : '',
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
                              for (var index in indexSumMin)
                                Text(
                                  _danhSachList.isNotEmpty ? _danhSachList[index].toString() : '',
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
