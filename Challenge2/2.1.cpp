// C++ program to find the missing number

#include <iostream>
#include <vector>
using namespace std;

int missingNumber(vector<int>& arr) {
    int n = arr.size() + 1;
  
    int sum = 0;
    for (int i = 0; i < n - 1; i++) {
        sum += arr[i];
    }

    int expectedSum = (n * (n + 1)) / 2;

    return expectedSum - sum;
}

int main() {
        vector<int> arr;
    arr.push_back(3);
    arr.push_back(7);
    arr.push_back(1);
    arr.push_back(2);
    arr.push_back(6);
    arr.push_back(4);
    cout << missingNumber(arr);
    return 0;
}
