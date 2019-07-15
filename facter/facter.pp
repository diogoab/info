notify {'kernel':
  message => "O sistema operacional eh ${::kernel} versao ${::kernelversion}."
}

notify {'distro':
  message => "A distribuicao GNU/Linux eh ${::operatingsystem}
    versão ${::operatingsystemrelease}."
}

if $::mountpoints['/home'] {
  $free_space = $::mountpoints['/home']['available_bytes']
}

elsif $::mountpoints['/'] {
  $free_space = $::mountpoints['/']['available_bytes']
}

$space_required = 2000000

if $free_space > $space_required {
  notify{ 'info_free_space':
    message => "[OK] Ha espaco livre suficiente em /home. Espaco requerido: \
      ${space_required} bytes, espaco livre: ${free_space} bytes",
    }
}
else {
  notify{ 'info_free_space':
    message => "[ERRO] Espaco insuficiente em /home. Espaco requerido: \
      ${space_required} bytes, espaco livre: ${free_space} bytes"
    }
}