# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aiccu/aiccu-2007.01.15-r3.ebuild,v 1.1 2013/05/24 07:09:06 xmw Exp $

EAPI=5

inherit eutils linux-info systemd toolchain-funcs

DESCRIPTION="AICCU Client to configure an IPv6 tunnel to SixXS"
HOMEPAGE="http://www.sixxs.net/tools/aiccu"
SRC_URI="http://www.sixxs.net/archive/sixxs/aiccu/unix/${PN}_${PV//\./}.tar.gz"

LICENSE="SixXS"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sparc ~x86"
IUSE="systemd"

RDEPEND="net-libs/gnutls
	sys-apps/iproute2
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

CONFIG_CHECK="~TUN"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-r2-init.gentoo.patch \
		"${FILESDIR}"/${P}-Makefile.patch \
		"${FILESDIR}"/${P}-setupscript.patch \
		"${FILESDIR}"/${P}-uclibc.patch \
		"${FILESDIR}"/${P}-systemd.patch
}

src_compile() {
	# Don't use main Makefile since it requires additional
	# dependencies which are useless for us.
	emake CC=$(tc-getCC) STRIP= -C unix-console \
		HAVE_SYSTEMD=$(usex systemd 1 0)
}

src_install() {
	dosbin unix-console/${PN}

	insopts -m 600
	insinto /etc
	doins doc/${PN}.conf
	newinitd doc/${PN}.init.gentoo ${PN}

	use systemd && systemd_dounit doc/${PN}.service

	dodoc doc/{HOWTO,README,changelog}
}
