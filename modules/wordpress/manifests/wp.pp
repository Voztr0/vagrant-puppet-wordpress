class wordpress::wp {


    # Copy to /var/www/
    exec { 'copy':
        command => "cp -r /tmp/wordpress/* /var/www/html",
        path => ['/bin'],
    }

    file { '/var/www/html/index.html':
        ensure => absent,
        require => Exec['copy'],
    }

    # Generate the wp-config.php file using the template
    file { '/var/www/html/wp-config.php':
        ensure => present,
        require => File['/var/www/html/index.html'],
        content => template("wordpress/wp-config.php.erb")
    }
}
