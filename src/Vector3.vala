public struct Vector3 {
    public float x;
    public float y;
    public float z;

    public Vector3 (float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public Vector3 add (Vector3 other) {
        return Vector3 (x + other.x, y + other.y, z + other.z);
    }

    public float dot (Vector3 other) {
        return x * other.x + y * other.y + z * other.z;
    }

    // Добавляем преобразование градусов в радианы
    public static float degrees_to_radians (float degrees) {
        return degrees * ((float) Math.PI / 180f);
    }

    public Vector3 subtract (Vector3 other) {
        return Vector3 (x - other.x, y - other.y, z - other.z);
    }

    public Vector3 multiply (float scalar) {
        return Vector3 (x * scalar, y * scalar, z * scalar);
    }
}
