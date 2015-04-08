# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libqmi/libqmi-1.12.6.ebuild,v 1.1 2015/02/28 21:30:02 vapier Exp $

EAPI="5"

inherit multilib
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}"
else
	KEYWORDS="~amd64 ~arm ~mips ~x86"
	SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"
fi

DESCRIPTION="QMI modem protocol helper library"
HOMEPAGE="http://cgit.freedesktop.org/libqmi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="doc static-libs"

RDEPEND=">=dev-libs/glib-2.32"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	virtual/pkgconfig"
[[ ${PV} == "9999" ]] && DEPEND+=" dev-util/gtk-doc" #469214

src_prepare() {
	[[ -e configure ]] || eautoreconf
}

src_configure() {
	econf \
		--disable-more-warnings \
		$(use_enable static{-libs,}) \
		$(use_enable {,gtk-}doc)
}

src_install() {
	default
	use static-libs || rm -f "${ED}/usr/$(get_libdir)/${PN}-glib.la"
}
