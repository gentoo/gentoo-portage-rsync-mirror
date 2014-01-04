# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-ncurses/pecl-ncurses-1.0.2.ebuild,v 1.1 2014/01/04 19:28:51 mabi Exp $

EAPI=5

USE_PHP="php5-3 php5-4 php5-5"

inherit php-ext-pecl-r2

DESCRIPTION="Terminal screen handling and optimization package"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

my_conf="--enable-ncursesw"
