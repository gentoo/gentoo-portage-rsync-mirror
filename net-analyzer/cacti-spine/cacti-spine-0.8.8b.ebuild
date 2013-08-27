# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-spine/cacti-spine-0.8.8b.ebuild,v 1.1 2013/08/27 02:19:17 jmbsvicetto Exp $

EAPI="4"
inherit autotools eutils

UPSTREAM_PATCHES=""

MY_P=${PN}-${PV/_p/-}

DESCRIPTION="Spine is a fast poller for Cacti (formerly known as Cactid)"
HOMEPAGE="http://cacti.net/spine_info.php"
SRC_URI="http://www.cacti.net/downloads/spine/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
	dev-libs/openssl
	virtual/mysql"
RDEPEND="${DEPEND}
	>net-analyzer/cacti-0.8.8"

if [[ -n ${UPSTREAM_PATCHES} ]]; then
	for i in ${UPSTREAM_PATCHES}; do
		SRC_URI="${SRC_URI} http://www.cacti.net/downloads/spine/patches/${PV}/${i}.patch"
	done
fi

src_prepare() {
	# Patch configure.ac to replace AM_CONFIG_HEADER with AC_CONFIG_HEADERS
	epatch "${FILESDIR}/${P}-fix-ac-macro.patch"

	if [[ -n ${UPSTREAM_PATCHES} ]]; then
		for i in ${UPSTREAM_PATCHES} ; do
			EPATCH_OPTS="-p1 -N" epatch "${DISTDIR}"/${i}.patch
		done
	fi

	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	AT_M4DIR="config" eautoreconf
}

src_install() {
	dosbin spine || die
	insinto /etc/
	insopts -m0640 -o root
	newins spine.conf{.dist,} || die
	dodoc ChangeLog README || die
}

pkg_postinst() {
	elog "Please see the cacti's site for installation instructions:"
	elog
	elog "http://cacti.net/spine_install.php"
	echo
	ewarn "/etc/spine.conf should be readable by webserver, thus after you"
	ewarn "decide on webserver do not forget to run the following command:"
	ewarn
	ewarn " # chown root:<wwwgroup> /etc/spine.conf"
	echo
}
