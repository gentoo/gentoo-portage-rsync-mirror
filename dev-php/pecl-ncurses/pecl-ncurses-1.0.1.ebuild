# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-ncurses/pecl-ncurses-1.0.1.ebuild,v 1.1 2012/01/22 00:05:02 mabi Exp $

EAPI=4

inherit php-ext-pecl-r2

DESCRIPTION="Terminal screen handling and optimization package"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

my_conf="--enable-ncursesw"
