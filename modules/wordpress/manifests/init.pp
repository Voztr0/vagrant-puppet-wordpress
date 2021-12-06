class wordpress {
    # Load all variables
    class { 'wordpress::conf': }

    # Install Apache and PHP
    class { 'wordpress::web': }

    # Install MySQL
    class { 'wordpress::db': }

    # Run Wordpress installation only after Apache is installed
    class { 'wordpress::wp': 
        require => Notify['Apache Installation Complete']
    }

    # Display this message after MySQL installation is complete
    notify { 'MySQL Installation Complete':
        require => Class['wordpress::db']
    }

    # Display this message after Apache installation is complete
    notify { 'Apache Installation Complete':
        require => Class['wordpress::web']
    }

    # Display this message after Wordpress installation is complete
    notify { 'Wordpress Installation Complete':
        require => Class['wordpress::wp']
    }
}