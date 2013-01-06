# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libqmi/libqmi-9999.ebuild,v 1.1 2012/09/23 21:28:19 vapier Exp $

EAPI="4"

inherit multilib
if [[ ${PV} == "9999" ]] ; then
	inherit git-2 autotools
	EGIT_REPO_URI="git://anongit.freedesktop.org/libqmi"
else
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI=""
fi

DESCRIPTION="QMI modem protocol helper library"
HOMEPAGE="http://cgit.freedesktop.org/libqmi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug doc static-libs test"

RDEPEND=">=dev-libs/glib-2.32"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	virtual/pkgconfig"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautoreconf
	fi
	sed -i '/GLIB_MKENUMS=/s:pkg-config:$PKG_CONFIG:' configure
}

src_configure() {
	econf \
		$(use_enable static{-libs,}) \
		$(use_with debug traces) \
		$(use_with doc{,s}) \
		$(use_with test{,s})
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/libqmi-glib.la
}
