# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-2.0.18.ebuild,v 1.9 2012/12/19 03:47:09 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

MY_PN=gob2
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
PVP=(${PV//[-\._]/ })

DESCRIPTION="Preprocessor for making GTK+ objects with inline C code"
HOMEPAGE="http://www.jirka.org/gob.html"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/glib-2:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex"

DOCS="AUTHORS ChangeLog NEWS README TODO"
