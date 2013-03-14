# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-3.0.3-r1.ebuild,v 1.1 2013/03/14 15:49:37 blueness Exp $

EAPI="5"

inherit autotools-utils eutils

DESCRIPTION="Varnish is a state-of-the-art, high-performance HTTP accelerator"
HOMEPAGE="http://www.varnish-cache.org/"
SRC_URI="http://repo.varnish-cache.org/source/${P}.tar.gz"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE="doc jemalloc libedit static-libs +tools"

CDEPEND="
	dev-libs/libpcre
	jemalloc? ( dev-libs/jemalloc )
	libedit? ( dev-libs/libedit )
	tools? ( sys-libs/ncurses )"

#varnish compiles stuff at run time
RDEPEND="
	${CDEPEND}
	sys-devel/gcc"

DEPEND="
	${CDEPEND}
	dev-python/docutils
	virtual/pkgconfig"

RESTRICT="test" #315725

DOCS=( README doc/changes.rst )

PATCHES=(
	"${FILESDIR}"/${PN}-3.0.3-automagic.patch
	"${FILESDIR}"/${PN}-3.0.3-pthread-uclibc.patch
)

AUTOTOOLS_AUTORECONF="yes"

src_prepare() {
	# Remove bundled libjemalloc. We also fix
	# automagic dep in our patches, bug #461638
	rm -rf lib/libjemalloc

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_with jemalloc)
		$(use_with libedit)
		$(use_with tools)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newinitd "${FILESDIR}"/varnishd.initd varnishd
	newconfd "${FILESDIR}"/varnishd.confd varnishd

	insinto /etc/logrotate.d
	newins "${FILESDIR}/varnishd.logrotate" varnishd

	dodir /var/log/varnish

	use doc && dohtml -r "doc/sphinx/=build/html/"
}

pkg_postinst () {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
}
