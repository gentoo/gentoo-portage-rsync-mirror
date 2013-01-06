# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lksctp-tools/lksctp-tools-1.0.10.ebuild,v 1.6 2010/07/11 00:33:00 ranger Exp $

inherit eutils

DESCRIPTION="Tools for Linux Kernel Stream Control Transmission Protocol implementation"
HOMEPAGE="http://lksctp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lksctp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

# I don't known if *BSD has the support needed at all
# hence the lockdown to glibc and linux26-headers
DEPEND=">=sys-kernel/linux-headers-2.6"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.8-prefix.patch #181602
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README ROADMAP doc/*txt
}
