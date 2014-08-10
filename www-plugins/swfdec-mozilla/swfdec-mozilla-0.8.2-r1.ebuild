# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/swfdec-mozilla/swfdec-mozilla-0.8.2-r1.ebuild,v 1.6 2014/08/10 20:09:50 slyfox Exp $

EAPI="2"

inherit multilib versionator eutils

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Swfdec-mozilla is a decoder/renderer netscape style plugin for Macromedia Flash animations"
HOMEPAGE="http://swfdec.freedesktop.org/"
SRC_URI="http://swfdec.freedesktop.org/download/${PN}/${MY_PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=media-libs/swfdec-0.8[gtk]"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.35
		virtual/pkgconfig"

src_prepare() {
	# Read correct argument when parsing alignment, see bug #307097
	epatch "${FILESDIR}/${P}-fix-crash.patch"
}

src_configure() {
	econf --with-plugin-dir=/usr/$(get_libdir)/nsbrowser/plugins
}

src_install() {
	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe src/.libs/libswfdecmozilla.so || die "libswfdecmozilla.so failed"

	insinto /usr/$(get_libdir)/nsbrowser/plugins
	doins src/libswfdecmozilla.la
}
