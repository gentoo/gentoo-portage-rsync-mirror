# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portsentry/portsentry-1.2-r1.ebuild,v 1.5 2012/02/06 18:46:18 ranger Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Automated port scan detector and response tool"
# Seems like CISCO took the site down?
HOMEPAGE="http://sourceforge.net/projects/sentrytools/"
SRC_URI="mirror://sourceforge/sentrytools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}"/${PN}_beta

src_unpack() {
	unpack ${A} ; cd "${S}"

	# Setting the portsentry.conf file location
	sed -i \
		-e 's:/usr/local/psionic/portsentry/portsentry.conf:/etc/portsentry/portsentry.conf:' \
		portsentry_config.h || die "sed portsentry_config.h failed"

	# presetting the other file locations in portsentry.conf
	sed -i \
		-e 's:\(^IGNORE_FILE\).*:\1="/etc/portsentry/portsentry.ignore":g' \
	    -e 's:^\(HISTORY_FILE\).*:\1="/etc/portsentry/portsentry.history":g' \
	    -e 's:^\(BLOCKED_FILE\).*:\1="/etc/portsentry/portsentry.blocked":g' \
		portsentry.conf || die "sed portsentry.conf failed"

	sed -i \
		-e "s:^set SENTRYDIR.*:set SENTRYDIR=/etc/portsentry:g" \
		ignore.csh || die "sed ignore.csh failed"
	epatch "${FILESDIR}"/gcc.patch
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS} ${LDFLAGS}" linux || die
}

src_install() {
	doman "${FILESDIR}"/{portsentry.8,portsentry.conf.5}

	dobin portsentry ignore.csh
	dodoc README* CHANGES CREDITS
	newdoc portsentry.ignore portsentry.ignore.sample
	newdoc portsentry.conf portsentry.conf.sample

	insinto /etc/portsentry
	newins portsentry.ignore portsentry.ignore.sample
	newins portsentry.conf portsentry.conf.sample

	newinitd "${FILESDIR}"/portsentry.rc6 portsentry
	newconfd "${FILESDIR}"/portsentry.confd portsentry
}
