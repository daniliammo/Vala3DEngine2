vala3dengine_sources = [
  'main.vala',
  'object.vala',
  'terminal.vala',
  'camera.vala',
  'Quaternion.vala',
  'Vector3.vala',
  'Vector2.vala',
]

vala3dengine_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

add_project_arguments(
  [
    '-march=native',
    '-ffast-math',
  ],
  language: 'c',
)

add_project_link_arguments('-lm', language: 'c')
add_project_link_arguments('-Ofast', language: 'c')

executable(
  'vala3dengine',
  vala3dengine_sources,
  vala_args: ['--target-glib=2.58', '--pkg=linux', '--pkg=posix'],
  dependencies: vala3dengine_deps,
  install: true,
)
