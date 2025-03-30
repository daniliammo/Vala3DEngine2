public class Camera {
    public Vector3 position { get; set; }
    public float fov { get; set; }

    public Camera (Vector3 position, float fov = 45f) {
        this.position = position;
        this.fov = fov;
    }

    public Vector3 world_to_view (Vector3 point) {
        return point.subtract (position);
    }
}
