# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/menu-cache/menu-cache-0.5.1.ebuild,v 1.3 2014/01/12 20:02:24 pacho Exp $

EAPI="5"

DESCRIPTION="A library creating and utilizing caches to speed up freedesktop.org application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
# ABI is v2. See Makefile.am
SLOT="0/2"
KEYWORDS="~alpha amd64 arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"
