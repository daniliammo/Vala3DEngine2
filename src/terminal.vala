public class TerminalRenderer {
    public int width;
    public int height;
    private char[] buffer;
    private uint8[] output; // Будет переиспользоваться
    private const float CHAR_ASPECT = 20f / 9f;

    public TerminalRenderer(int width, int height) {
        this.width = width;
        this.height = height;
        this.buffer = new char[width * height];
        this.output = new uint8[width * height + height]; // Инициализируем один раз
        clear();
    }

    public void clear() {
        for (int i = 0; i < buffer.length; i++) {
            buffer[i] = ' ';
        }
    }

    public Vector2 project(Vector3 v) {
        float scale = 20f;
        return Vector2(
                       (int) (width / 2 + v.x * scale * CHAR_ASPECT),
                       (int) (height / 2 - v.y * scale)
        );
    }

    private void draw_line(Vector2 start, Vector2 end, char symbol) {
        int x0 = (int) start.x;
        int y0 = (int) start.y;
        int x1 = (int) end.x;
        int y1 = (int) end.y;

        int dx = (x1 - x0).abs();
        int dy = -(y1 - y0).abs();
        int sx = x0 < x1 ? 1 : -1;
        int sy = y0 < y1 ? 1 : -1;
        int err = dx + dy;

        while (true) {
            if (x0 >= 0 && x0 < width && y0 >= 0 && y0 < height) {
                buffer[y0 * width + x0] = symbol;
            }

            if (x0 == x1 && y0 == y1)break;

            int e2 = 2 * err;
            if (e2 >= dy) {
                err += dy;
                x0 += sx;
            }
            if (e2 <= dx) {
                err += dx;
                y0 += sy;
            }
        }
    }

    public const char EndOfLine = '\n';
    public const uint8 DefaultFD = 1;

    public void render() {
        int pos = 0;

        for (int y = 0; y < height; y++) {
            Posix.memcpy(output[pos:], buffer[y * width: y * width + width], width);
            pos += width;
            output[pos] = EndOfLine;
            pos++;
        }

        Posix.write(DefaultFD, output, pos);
    }

    public void draw_object(Object3D obj) {
        char vertex_symbol = '@';
        char edge_symbol = '#';

        Vector3[] transformed_vertices = obj.get_transformed_vertices();

        foreach (Edge edge in obj.edges) {
            Vector2 p1 = project(transformed_vertices[edge.v1]);
            Vector2 p2 = project(transformed_vertices[edge.v2]);
            draw_line(p1, p2, edge_symbol);
        }

        foreach (var vertex in transformed_vertices) {
            Vector2 screen_pos = project(vertex);
            int x = (int) screen_pos.x;
            int y = (int) screen_pos.y;
            if (x >= 0 && x < width && y >= 0 && y < height) {
                buffer[y * width + x] = vertex_symbol;
            }
        }
    }
}
