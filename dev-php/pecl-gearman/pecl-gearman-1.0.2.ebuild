# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-gearman/pecl-gearman-1.0.2.ebuild,v 1.1 2012/03/06 08:25:41 olemarkus Exp $

EAPI=4
PHP_EXT_NAME="gearman"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension for using gearmand."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=sys-cluster/gearmand-0.21"
RDEPEND="${DEPEND}"
