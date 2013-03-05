# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-mongo/pecl-mongo-1.3.4.ebuild,v 1.1 2013/03/05 11:30:15 olemarkus Exp $

EAPI=5

PHP_EXT_NAME="mongo"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

DESCRIPTION="MongoDB database driver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
