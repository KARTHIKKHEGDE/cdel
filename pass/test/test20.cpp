#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <cstdlib>

using namespace std;

/* =============================================
 * TEST 20 — C++ Graph with BFS/DFS + Dijkstra
 * Adjacency-list graph, path-finding, cycle detection,
 * topological sort (on DAG subset).
 * ============================================= */

class Graph {
    int V;
    vector<vector<pair<int,int>>> adj; // neighbor, weight

public:
    Graph(int v) : V(v), adj(v) {}

    void addEdge(int u, int v, int w) {
        adj[u].push_back({v, w});
        adj[v].push_back({u, w});
    }

    void addDirected(int u, int v, int w) {
        adj[u].push_back({v, w});
    }

    vector<int> bfs(int src) {
        vector<int> order;
        vector<bool> vis(V, false);
        vector<int> q;
        q.push_back(src);
        vis[src] = true;
        int front = 0;
        while (front < (int)q.size()) {
            int u = q[front++];
            order.push_back(u);
            for (auto& [v, w] : adj[u]) {
                if (!vis[v]) { vis[v] = true; q.push_back(v); }
            }
        }
        return order;
    }

    void dfsUtil(int u, vector<bool>& vis, vector<int>& order) {
        vis[u] = true;
        order.push_back(u);
        for (auto& [v, w] : adj[u]) {
            if (!vis[v]) dfsUtil(v, vis, order);
        }
    }

    vector<int> dfs(int src) {
        vector<int> order;
        vector<bool> vis(V, false);
        dfsUtil(src, vis, order);
        return order;
    }

    vector<int> dijkstra(int src) {
        vector<int> dist(V, 1e9);
        vector<bool> done(V, false);
        dist[src] = 0;
        for (int i = 0; i < V; i++) {
            int u = -1;
            for (int j = 0; j < V; j++)
                if (!done[j] && (u == -1 || dist[j] < dist[u])) u = j;
            if (u == -1 || dist[u] == 1e9) break;
            done[u] = true;
            for (auto& [v, w] : adj[u])
                if (dist[u] + w < dist[v]) dist[v] = dist[u] + w;
        }
        return dist;
    }

    bool hasCycleUtil(int u, vector<bool>& vis, vector<bool>& stack) {
        vis[u] = stack[u] = true;
        for (auto& [v, w] : adj[u]) {
            if (!vis[v] && hasCycleUtil(v, vis, stack)) return true;
            if (stack[v]) return true;
        }
        stack[u] = false;
        return false;
    }

    bool hasCycle() {
        vector<bool> vis(V, false), stack(V, false);
        for (int i = 0; i < V; i++)
            if (!vis[i] && hasCycleUtil(i, vis, stack)) return true;
        return false;
    }

    int countComponents() {
        vector<bool> vis(V, false);
        int comp = 0;
        for (int i = 0; i < V; i++) {
            if (!vis[i]) {
                vector<int> unused;
                dfsUtil(i, vis, unused);
                comp++;
            }
        }
        return comp;
    }
};

int main() {
    Graph g(30);
    srand(123);
    for (int i = 0; i < 80; i++) {
        int u = rand() % 30, v = rand() % 30;
        if (u != v) g.addEdge(u, v, rand() % 50 + 1);
    }

    auto bfsOrder = g.bfs(0);
    auto dfsOrder = g.dfs(0);
    auto dist = g.dijkstra(0);

    cout << "BFS from 0 reached " << bfsOrder.size() << " nodes" << endl;
    cout << "DFS from 0 reached " << dfsOrder.size() << " nodes" << endl;
    cout << "Components: " << g.countComponents() << endl;

    cout << "Dijkstra distances from 0:" << endl;
    for (int i = 0; i < 10; i++)
        cout << "  to " << i << ": " << (dist[i] >= 1e9 ? -1 : dist[i]) << endl;

    // Directed graph for cycle detection
    Graph dg(10);
    dg.addDirected(0,1,1); dg.addDirected(1,2,1);
    dg.addDirected(2,3,1); dg.addDirected(3,1,1); // cycle
    cout << "Directed graph has cycle: " << (dg.hasCycle() ? "YES" : "NO") << endl;

    return 0;
}
