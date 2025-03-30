public struct Vector3 {
    public float x;
    public float y;
    public float z;

    public Vector3(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public Vector3 add(Vector3 other) {
        return Vector3(x + other.x, y + other.y, z + other.z);
    }

    public float dot(Vector3 other) {
        return x * other.x + y * other.y + z * other.z;
    }

    // Добавляем преобразование градусов в радианы
    public static float degrees_to_radians(float degrees) {
        return degrees * ((float) Math.PI / 180f);
    }

    public Vector3 subtract(Vector3 other) {
        return Vector3(x - other.x, y - other.y, z - other.z);
    }

    public Vector3 multiply(float scalar) {
        return Vector3(x * scalar, y * scalar, z * scalar);
    }
}

public struct Vector2 {
    public float x;
    public float y;

    public Vector2(float x, float y) {
        this.x = x;
        this.y = y;
    }
}

public struct Quaternion {
    public float w;
    public float x;
    public float y;
    public float z;

    public Quaternion(float w, float x, float y, float z) {
        this.w = w;
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public Quaternion multiply(Quaternion other) {
        return Quaternion(
                          w * other.w - x * other.x - y * other.y - z * other.z,
                          w * other.x + x * other.w + y * other.z - z * other.y,
                          w * other.y - x * other.z + y * other.w + z * other.x,
                          w * other.z + x * other.y - y * other.x + z * other.w
        );
    }

    public Vector3 rotate(Vector3 v) {
        Quaternion q_vec = Quaternion(0, v.x, v.y, v.z);
        Quaternion q_conj = Quaternion(w, -x, -y, -z);
        Quaternion q_res = multiply(q_vec).multiply(q_conj);
        return Vector3(q_res.x, q_res.y, q_res.z);
    }

    public static Quaternion from_euler(float roll, float pitch, float yaw) {
        float cy = Math.cosf(yaw * 0.5f);
        float sy = Math.sinf(yaw * 0.5f);
        float cp = Math.cosf(pitch * 0.5f);
        float sp = Math.sinf(pitch * 0.5f);
        float cr = Math.cosf(roll * 0.5f);
        float sr = Math.sinf(roll * 0.5f);

        return Quaternion(
                          cr * cp * cy + sr * sp * sy,
                          sr * cp * cy - cr * sp * sy,
                          cr * sp * cy + sr * cp * sy,
                          cr * cp * sy - sr * sp * cy
        );
    }
}
