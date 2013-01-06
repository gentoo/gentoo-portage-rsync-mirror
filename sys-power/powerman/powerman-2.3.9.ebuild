# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powerman/powerman-2.3.9.ebuild,v 1.1 2011/04/02 18:07:37 weaver Exp $

EAPI="1"

DESCRIPTION="RPC/PDU control and monitoring service for data center or compute cluster power management"
HOMEPAGE="http://code.google.com/p/powerman/"
SRC_URI="http://powerman.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+httppower -snmppower -h8power +genders"
DEPEND="sys-devel/bison
	httppower? ( net-misc/curl )
	snmppower? ( net-analyzer/net-snmp )
	!app-accessibility/speech-tools"
RDEPEND=">=sys-libs/freeipmi-0.2.3"

src_compile() {
	# Powerman stores the pidfile under $localstatedir/run.
	# It's set to /var/lib in the release, but in gentoo pidfiles live under /var/run.
	econf --localstatedir="/var" \
		$(use_with httppower) \
		$(use_with snmppower) \
		$(use_with h8power) \
		$(use_with genders)
	emake || die
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die
	rm -f "${D}/etc/init.d/powerman"
	doinitd "${FILESDIR}/powerman" || die
	dodoc AUTHORS ChangeLog DISCLAIMER NEWS TODO
}
