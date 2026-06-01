#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* =============================================
 * TEST 16 — Graph BFS/DFS + Dijkstra (C)
 * Adjacency matrix graph with BFS, DFS, shortest
 * path (Dijkstra), and connected-component count.
 * ============================================= */

#define MAX_V 50
#define INF 999999

int adj[MAX_V][MAX_V];
int visited[MAX_V];
int dist[MAX_V];
int V;

void initGraph(int vertices) {
    V = vertices;
    for (int i = 0; i < V; i++)
        for (int j = 0; j < V; j++)
            adj[i][j] = 0;
}

void addEdge(int u, int v, int w) {
    adj[u][v] = w;
    adj[v][u] = w;
}

/* ---------- BFS ---------- */
int bfs(int start) {
    int queue[MAX_V], front = 0, rear = 0;
    memset(visited, 0, sizeof(visited));
    visited[start] = 1;
    queue[rear++] = start;
    int count = 0;
    while (front < rear) {
        int curr = queue[front++];
        count++;
        for (int i = 0; i < V; i++) {
            if (adj[curr][i] && !visited[i]) {
                visited[i] = 1;
                queue[rear++] = i;
            }
        }
    }
    return count;
}

/* ---------- DFS ---------- */
void dfsUtil(int v, int* count) {
    visited[v] = 1;
    (*count)++;
    for (int i = 0; i < V; i++) {
        if (adj[v][i] && !visited[i])
            dfsUtil(i, count);
    }
}

int dfs(int start) {
    memset(visited, 0, sizeof(visited));
    int count = 0;
    dfsUtil(start, &count);
    return count;
}

/* ---------- Dijkstra ---------- */
void dijkstra(int src) {
    int processed[MAX_V];
    memset(processed, 0, sizeof(processed));
    for (int i = 0; i < V; i++) dist[i] = INF;
    dist[src] = 0;

    for (int count = 0; count < V; count++) {
        int u = -1, minDist = INF;
        for (int i = 0; i < V; i++) {
            if (!processed[i] && dist[i] < minDist) {
                minDist = dist[i];
                u = i;
            }
        }
        if (u == -1) break;
        processed[u] = 1;
        for (int v = 0; v < V; v++) {
            if (adj[u][v] && !processed[v] && dist[u] + adj[u][v] < dist[v])
                dist[v] = dist[u] + adj[u][v];
        }
    }
}

/* ---------- Connected Components ---------- */
int countComponents() {
    memset(visited, 0, sizeof(visited));
    int components = 0;
    for (int i = 0; i < V; i++) {
        if (!visited[i]) {
            int count = 0;
            dfsUtil(i, &count);
            components++;
        }
    }
    return components;
}

int main() {
    initGraph(40);

    srand(42);
    for (int i = 0; i < 120; i++) {
        int u = rand() % 40;
        int v = rand() % 40;
        if (u != v) addEdge(u, v, rand() % 20 + 1);
    }

    printf("BFS from 0: %d nodes reachable\n", bfs(0));
    printf("DFS from 0: %d nodes reachable\n", dfs(0));

    dijkstra(0);
    printf("Shortest distances from node 0:\n");
    for (int i = 0; i < 10; i++)
        printf("  to %d: %d\n", i, dist[i] == INF ? -1 : dist[i]);

    printf("Connected components: %d\n", countComponents());

    return 0;
}
