public struct Matrix4 {
    public float[] data;

    public Matrix4 () {
        data = new float[16];
        // Инициализация единичной матрицей по умолчанию
        for (int i = 0; i < 16; i++) {
            data[i] = (i % 5 == 0) ? 1f : 0f; // Диагональные элементы = 1
        }
    }

    public Matrix4.identity () {
        this();
        // Уже инициализировано как единичная матрица
    }

    public Matrix4.perspective (float fov, float aspect, float near, float far) {
        this();
        float tan_half_fov = Math.tanf (fov / 2f);
        data = {
            1f / (aspect * tan_half_fov), 0f, 0f, 0f,
            0f, 1f / tan_half_fov, 0f, 0f,
            0f, 0f, -(far + near) / (far - near), -1f,
            0f, 0f, -(2f * far * near) / (far - near), 0f
        };
    }

    public Vector3 multiply_vector (Vector3 v) {
        return Vector3 (
                        data[0] * v.x + data[4] * v.y + data[8] * v.z + data[12],
                        data[1] * v.x + data[5] * v.y + data[9] * v.z + data[13],
                        data[2] * v.x + data[6] * v.y + data[10] * v.z + data[14]
        );
    }

    // Добавим метод для умножения матриц (пригодится позже)
    public Matrix4 multiply (Matrix4 other) {
        Matrix4 result = Matrix4 ();
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                result.data[i * 4 + j] = 0f;
                for (int k = 0; k < 4; k++) {
                    result.data[i * 4 + j] += data[i * 4 + k] * other.data[k * 4 + j];
                }
            }
        }
        return result;
    }
}
