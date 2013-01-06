# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-2.11.1.ebuild,v 1.16 2012/12/17 11:58:19 tetromino Exp $

EAPI="1"

inherit eutils gnome2 versionator autotools

MY_P="lib${P}"
MY_PN="lib${PN}"
MY_MAJ_PV="$(get_version_component_range 1-2)"

DESCRIPTION="Lightweight HTML rendering/printing/editing engine"
HOMEPAGE="http://projects.gnome.org/evolution/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${MY_MAJ_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2+ LGPL-2+"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="accessibility test"

# gnome-vfs is only needed to run testgtkhtml (1/3 tests)

RDEPEND=">=x11-libs/gtk+-2.13.0:2
	>=dev-libs/libxml2-2.4.16:2
	test? ( >=gnome-base/gnome-vfs-2:2 )"
DEPEND="${RDEPEND}
	 virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO docs/IDEAS"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable accessibility)"
}

src_unpack() {
	gnome2_src_unpack

	if use alpha; then
		epatch "${FILESDIR}/${MY_PN}-2.2.0-alpha.patch"
	fi

	if use x86-fbsd; then
		# We need a full autoreconf on FreeBSD at least to fix libtool errors.
		eautoreconf
	fi
}
