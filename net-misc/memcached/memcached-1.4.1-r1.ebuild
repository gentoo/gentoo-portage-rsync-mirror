# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/memcached/memcached-1.4.1-r1.ebuild,v 1.2 2012/08/26 19:54:29 armin76 Exp $

EAPI=2
inherit eutils autotools flag-o-matic

MY_PV="${PV/_rc/-rc}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="High-performance, distributed memory object caching system"
HOMEPAGE="http://code.google.com/p/memcached/"
SRC_URI="http://memcached.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="test slabs-reassign debug"

RDEPEND=">=dev-libs/libevent-1.4
		 dev-lang/perl"
DEPEND="${RDEPEND}
		test? ( virtual/perl-Test-Harness >=dev-perl/Cache-Memcached-1.24 )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.2.2-fbsd.patch"
	epatch "${FILESDIR}/${PN}-1.3.3-gcc4-slab-fixup.patch"
	epatch "${FILESDIR}/${PN}-1.4.0-fix-as-needed-linking.patch"
	sed -i -e 's,-Werror,,g' configure.ac || die "sed failed"
	eautoreconf
	use slabs-reassign && append-flags -DALLOW_SLABS_REASSIGN
}

src_compile() {
	# There is a heavy degree of per-object compile flags
	# Users do NOT know better than upstream. Trying to compile the testapp and
	# the -debug version with -DNDEBUG _WILL_ fail.
	append-flags -UNDEBUG
	emake testapp memcached-debug CFLAGS="${CFLAGS}" || die "emake of testapp and memcached-debug failed."
	filter-flags -UNDEBUG
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dobin scripts/memcached-tool
	use debug && dobin memcached-debug

	dodoc AUTHORS ChangeLog NEWS README TODO doc/{CONTRIBUTORS,*.txt}

	newconfd "${FILESDIR}"/1.3.3/conf memcached
	newinitd "${FILESDIR}"/1.3.3/init memcached
}

pkg_postinst() {
	enewuser memcached -1 -1 /dev/null daemon

	elog "With this version of Memcached Gentoo now supports multiple instances."
	elog "To enable this you should create a symlink in /etc/init.d/ for each instance"
	elog "to /etc/init.d/memcached and create the matching conf files in /etc/conf.d/"
	elog "Please see Gentoo bug #122246 for more info"
}

src_test() {
	emake -j1 test || die "Failed testing"
}
