# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.8.0.ebuild,v 1.6 2010/10/23 22:24:23 halcy0n Exp $

EAPI="2"
inherit eutils autotools

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="debug doc examples ipv6 gnutls"

RDEPEND="gnutls? ( dev-libs/libgcrypt
		net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )
	sys-libs/zlib"
DEPEND="doc? ( >=app-doc/doxygen-1.3.6 )
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/1.6.1-gcc42_atomicity.patch"
	epatch "${FILESDIR}/1.6.2-configure_detect_netfilter.patch" # bug 236177
	epatch "${FILESDIR}/1.8.0-glibc212.patch"
	eautoreconf
}

src_configure() {
	use doc || \
		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure || die "sed failed"

	local myconf
	if use gnutls; then
		myconf="--with-gnutls --without-openssl"
	else
		myconf="--without-gnutls --with-openssl"
	fi

	econf \
		$(use_enable debug) \
		$(use_with ipv6 ) \
		${myconf}
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS ChangeLog README THANKS TODO COPYING.addendum

	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		cd demo
		doins *.cpp *.h *.xml README
	fi
}

pkg_postinst() {
	ewarn "There's a change in the ABI between version 1.5.x and 1.6.x, please"
	ewarn "run the following command to find broken packages and rebuild them:"
	ewarn "    revdep-rebuild --library=libccext2-1.5.so"
}

# Some of the tests hang forever
#src_test() {
#	cd "${S}/tests"
#	emake || die "emake tests failed"
#	./test.sh || die "tests failed"
#}
