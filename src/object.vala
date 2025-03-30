public class Object3D {
    public Vector3 position { get; set; }
    public Quaternion rotation { get; set; }
    public Vector3[] vertices { get; set; }
    public Edge[] edges { get; set; } // Массив рёбер: [[индекс_вершины_1, индекс_вершины_2], ...]

    public Object3D(Vector3[] vertices, Edge[] edges) {
        this.vertices = vertices;
        this.edges = edges;
        this.position = Vector3(0, 0, 0);
        this.rotation = Quaternion(1, 0, 0, 0); // Единичный кватернион (нет поворота)
    }

    // Возвращает вершины с учётом позиции и поворота
    public Vector3[] get_transformed_vertices() {
        Vector3[] transformed = new Vector3[vertices.length];
        for (int i = 0; i < vertices.length; i++) {
            transformed[i] = rotation.rotate(vertices[i]).add(position);
        }
        return transformed;
    }
}

public struct Edge {
    public int v1; // Индекс первой вершины
    public int v2; // Индекс второй вершины

    public Edge(int v1, int v2) {
        this.v1 = v1;
        this.v2 = v2;
    }
}
