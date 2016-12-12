class lamp {

        Package {ensure => "installed", allowcdrom => "true"}
                package { "apache2":}
                package { "libapache2-mod-php":}
                package { "php":}
                package { "gedit":}

	file { "/var/www/html/index.php":
		content => template ("lamp/index.php"),
		ensure => "directory",
	}

        file { "/etc/skel/public_html":
                ensure => "directory",

        }

        file { "/etc/skel/public_html/index.php":
                content => template ("lamp/index.php"),

        }

        file { "/etc/apache2/mods-enabled/userdir.conf":
                ensure => "link",
                target => "../mods-available/userdir.conf",
                notify => Service ["apache2"],

        }

        file { "/etc/apache2/mods-enabled/userdir.load":
                ensure => "link",
                target => "../mods-available/userdir.load",
                notify => Service ["apache2"],

        }

        file { "/etc/apache2/mods-available/php7.0.conf":
                content => template ("lamp/php7.0.conf"),
                notify => Service ["apache2"],

        }

        service { "apache2":
                ensure => "true",
                enable => "true",

        }

	file { "/etc/puppet/modules/mysql/manifests/server/install.pp":
                ensure => "directory",
		content => template ("lamp/install.pp"),

        }


        exec {"gsettings set org.gnome.gedit.preferences.editor":
                command => "gsettings set org.gnome.gedit.preferences.editor scheme \'Oblivion\'",
                require => Package ["gedit"],
                path => ['/bin/','/sbin/','/usr/bin/','/usr/sbin/'],
        }


}
