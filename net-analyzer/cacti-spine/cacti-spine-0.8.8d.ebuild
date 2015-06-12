# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-spine/cacti-spine-0.8.8d.ebuild,v 1.1 2015/06/12 05:47:52 jer Exp $

EAPI=5
inherit autotools eutils

MY_P=${PN}-${PV/_p/-}

DESCRIPTION="Spine is a fast poller for Cacti (formerly known as Cactid)"
HOMEPAGE="http://cacti.net/spine_info.php"
SRC_URI="http://www.cacti.net/downloads/spine/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="net-analyzer/net-snmp
	dev-libs/openssl:*
	virtual/mysql"
RDEPEND="${DEPEND}
	>net-analyzer/cacti-0.8.8"

src_prepare() {
	# Patch configure.ac to replace AM_CONFIG_HEADER with AC_CONFIG_HEADERS
	epatch "${FILESDIR}/${PN}-0.8.8d-fix-ac-macro.patch"

	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	AT_M4DIR="config" eautoreconf
}

src_install() {
	dosbin spine
	insinto /etc/
	insopts -m0640 -o root
	newins spine.conf{.dist,}
	dodoc ChangeLog README
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
