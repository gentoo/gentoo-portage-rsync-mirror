# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-js-common/gnome-js-common-0.1.2.ebuild,v 1.13 2014/11/23 20:46:43 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2

DESCRIPTION="GNOME JavaScript common modules and tests"
HOMEPAGE="https://git.gnome.org/browse/gnome-js-common"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
"

src_configure() {
	gnome2_src_configure \
		--disable-seed \
		--disable-gjs
}

src_install() {
	gnome2_src_install
	rm -rf "${ED}"/usr/doc
}
