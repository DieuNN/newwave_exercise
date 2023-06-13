import 'package:test/test.dart';

void main() {
  group("Valid Parentheses", () {
    test("Test 1", (){
      expect(isValid("()"), true);
    });
    test("Test 2", (){
      expect(isValid("()[]{}"), true);
    });
    test("Test 3", (){
      expect(isValid("(]"), false);
    });
  });
}

bool isValid(String s) {
  Stack<String> stack = Stack();
  for (var i = 0; i < s.length; i++) {
    if (s[i] == "{" || s[i] == "(" || s[i] == "[") {
      stack.push(s[i]);
    } else {
      if (stack.isEmpty) {
        return false;
      }
      var temp = stack.pop();
      if ((temp == "(" && s[i] == ")") ||
          (temp == "{" && s[i] == "}") ||
          (temp == "[" && s[i] == "]")) {
      } else {
        return false;
      }
    }
  }

  if (stack.value.isEmpty) {
    return true;
  }

  return false;
}

// Dart doesn't have Stack like Java or C++
class Stack<E> {
  final List<E> _list = [];
  void push(E value) {
    _list.add(value);
  }

  E pop() {
    return _list.removeLast();
  }

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;

  List<E> get value => _list;
}
