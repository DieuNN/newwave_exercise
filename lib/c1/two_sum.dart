import 'package:test/test.dart';

void main() {
  group("Valid Parentheses", () {
    test("Test 1", () {
      expect(twoSum([2, 7, 11, 15], 9), [0, 1]);
    });
    test("Test 2", () {
      expect(twoSum([3,2,4], 6), [1, 2]);
    });
    test("Test 3", () {
      expect(twoSum([3,3], 6), [0, 1]);
    });
  });
}


List<int> twoSum(List<int> nums, int target) {
  // Using map for O(n) time complexity or 2 for loops with O(n^2) time complexity
  Map<int, int> map = {};
  for (int i = 0; i < nums.length; i++) {
    int temp = target - nums[i];
    if (map.containsKey(temp)) {
      return [map[temp] as int, i];
    }
    map[nums[i]] = i;
  }
  return [];
}
