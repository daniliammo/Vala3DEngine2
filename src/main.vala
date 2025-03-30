
public static Linux.winsize GetTerminalSize() {
    Linux.winsize size = Linux.winsize();
    Posix.ioctl(1, Linux.Termios.TIOCGWINSZ, &size);
    return size;
}

// Вершины куба (x, y, z)
void main() {
    // TerminalRenderer renderer = new TerminalRenderer(425, 98);
    TerminalRenderer renderer = new TerminalRenderer(GetTerminalSize().ws_col, GetTerminalSize().ws_row);
    Object3D cube = create_cube(); // Функция, создающая куб (8 вершин)

    cube.position = Vector3(0, 0, -10);

    float angle;

    while (true) {
        renderer.clear();

        // Вращение куба
        angle += 0.01f;
        cube.rotation = Quaternion.from_euler(angle, angle * 0.5f, angle * 0.3f);

        renderer.draw_object(cube);
        renderer.render();

        // Задержка для анимации
        Thread.usleep(6061);
    }
}

Object3D create_cube() {
    Vector3[] vertices = {
        Vector3(-0.625f, -0.625f, -0.625f), // 0
        Vector3(0.625f, -0.625f, -0.625f), // 1
        Vector3(0.625f, 0.625f, -0.625f), // 2
        Vector3(-0.625f, 0.625f, -0.625f), // 3
        Vector3(-0.625f, -0.625f, 0.625f), // 4
        Vector3(0.625f, -0.625f, 0.625f), // 5
        Vector3(0.625f, 0.625f, 0.625f), // 6
        Vector3(-0.625f, 0.625f, 0.625f) // 7
    };

    // Рёбра куба (индексы вершин)
    Edge[] edges = {
        Edge(0, 1), Edge(1, 2), Edge(2, 3), Edge(3, 0), // Нижняя грань
        Edge(4, 5), Edge(5, 6), Edge(6, 7), Edge(7, 4), // Верхняя грань
        Edge(0, 4), Edge(1, 5), Edge(2, 6), Edge(3, 7) // Боковые рёбра
    };

    return new Object3D(vertices, edges);
}
