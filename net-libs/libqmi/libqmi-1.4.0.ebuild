# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libqmi/libqmi-1.4.0.ebuild,v 1.1 2013/06/18 21:29:04 vapier Exp $

EAPI="4"

inherit multilib autotools
if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_REPO_URI="git://anongit.freedesktop.org/libqmi"
else
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI="http://cgit.freedesktop.org/libqmi/snapshot/${P}.tar.gz"
fi

DESCRIPTION="QMI modem protocol helper library"
HOMEPAGE="http://cgit.freedesktop.org/libqmi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="doc static-libs test"

RDEPEND=">=dev-libs/glib-2.32"
# We have to always depend on gtk-doc since eautoreconf uses it #469214
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	virtual/pkgconfig"

src_prepare() {
	[[ -e configure ]] || eautoreconf
}

src_configure() {
	econf \
		--disable-more-warnings \
		$(use_enable static{-libs,}) \
		$(use_enable {,gtk-}doc) \
		$(use_with test{,s})
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/libqmi-glib.la
}
