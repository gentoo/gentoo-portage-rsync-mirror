# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aiccu/aiccu-2007.01.15-r1.ebuild,v 1.7 2012/08/01 06:39:07 xmw Exp $

EAPI=3

inherit toolchain-funcs eutils

DESCRIPTION="AICCU Client to configure an IPv6 tunnel to SixXS"
HOMEPAGE="http://www.sixxs.net/tools/aiccu"
SRC_URI="http://www.sixxs.net/archive/sixxs/aiccu/unix/${PN}_${PV//\./}.tar.gz"

LICENSE="SixXS"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sparc x86"
IUSE=""

DEPEND="net-libs/gnutls
	sys-apps/iproute2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/aiccu

src_prepare() {
	epatch "${FILESDIR}/aiccu.init.gentoo.patch" \
		"${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	# Don't use main Makefile since it requires additional dependencies which
	# are useless for us.
	emake CC=$(tc-getCC) STRIP= -C unix-console || die
}

src_install() {
	dosbin unix-console/aiccu || die

	insopts -m 600
	insinto /etc
	doins doc/aiccu.conf || die

	dodoc doc/{HOWTO,README,changelog}

	newinitd doc/aiccu.init.gentoo aiccu || die
}

pkg_postinst() {
	einfo "The aiccu ebuild installs an init script named 'aiccu'"
	einfo "To add support for a SixXS connection at startup, do"
	einfo "edit your /etc/aiccu.conf and do"
	einfo "# rc-update add aiccu default"
}
