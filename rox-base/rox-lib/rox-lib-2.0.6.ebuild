# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-lib/rox-lib-2.0.6.ebuild,v 1.7 2012/02/10 03:05:01 patrick Exp $

PYTHON_DEPEND="2:2.5"
inherit python eutils multilib

MY_PN="rox-lib2"
DESCRIPTION="ROX-Lib2 - Shared code for ROX applications by Thomas Leonard"
HOMEPAGE="http://rox.sourceforge.net/desktop/ROX-Lib"
SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=rox-base/rox-2.2.0
		>=dev-python/pygtk-2.8.2"

DEPEND="rox-base/zeroinstall-injector"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/rox-lib-nosvg.patch"
}

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	local NATIVE_FEED_DIR="/usr/share/0install.net/native_feeds"
	local ICON_CACHE_DIR="/var/cache/0install.net/interface_icons"

	dodir "${baselibdir}"
	cp -r ROX-Lib2/ "${D}${baselibdir}"
	dodir /usr/share/doc/
	dosym "${baselibdir}/ROX-Lib2/Help" "/usr/share/doc/${P}"

	0distutils ROX-Lib2/ROX-Lib2.xml > tmp.native_feed || die "0distutilss feed edit failed"
	insinto "${baselibdir}/ROX-Lib2/"
	newins tmp.native_feed ROX-Lib2.xml

	local feedname
	feedname=$(0distutils -e tmp.native_feed) || die "0distutils URI escape failed"
	dosym "${baselibdir}/ROX-Lib2/ROX-Lib2.xml" "${NATIVE_FEED_DIR}/${feedname}"

	local cachedname
	cachedname=$(0distutils -c tmp.native_feed) || die "0distutils URI escape failed"
	dosym "${baselibdir}/ROX-Lib2/.DirIcon" "${ICON_CACHE_DIR}/${cachedname}"
}

pkg_postinst() {
	local baselibdir="/usr/$(get_libdir)"
	python_mod_optimize "${baselibdir}/ROX-Lib2/"
}

pkg_postrm() {
	local baselibdir="/usr/$(get_libdir)"
	python_mod_cleanup "${baselibdir}/ROX-Lib2/"
}
