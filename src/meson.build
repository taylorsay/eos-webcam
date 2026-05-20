gphoto2_dep  = dependency('libgphoto2',   required : true)
turbojpeg_dep = dependency('libturbojpeg', required : true)

executable('eos-webcam',
  'main.cpp',
  dependencies : [gphoto2_dep, turbojpeg_dep],
  install : true,
  install_dir : get_option('prefix') / 'bin')
