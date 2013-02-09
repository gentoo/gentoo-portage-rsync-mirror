# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lnxhc/lnxhc-1.2.ebuild,v 1.1 2013/02/09 18:59:10 creffett Exp $

EAPI=5

inherit eutils
DESCRIPTION="Linux Health Checker"
HOMEPAGE="http://lnxhc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.2-usrlocal.patch"
}
