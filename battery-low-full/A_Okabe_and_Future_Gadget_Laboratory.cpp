#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n, s, t, count = 0, cbool = 0;
    //bool c = false;
    cin >> n;
    int arr[n][n];
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            cin >> arr[i][j];
            if (arr[i][j] != 1)
            {
                count++;
            }
        }
    }
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (arr[i][j] != 1)
            {
                for (int i1 = 0; i1 < n; i1++)
                {
                    for (int j1 = 0; j1 < n; j1++)
                        if ( (i1!=i && j1!=j) && ((arr[i][j1] + arr[i1][j]) == arr[i][j]))
                           { cbool++; break;}
                }
            }
        }
    }

    if (cbool-1 == count)
        cout << "Yes\n";
    else
        cout << "No\n";

    //cout<<cbool;

    return 0;
}