# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-2.2.2.ebuild,v 1.8 2010/12/19 15:14:44 pva Exp $

IUSE=""

MY_MPV=${PV//.*}

DESCRIPTION="GNU oSIP (Open SIP) library version 2"
HOMEPAGE="http://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/libosip2-${PV}.tar.gz"
S="${WORKDIR}/${PN}${MY_MPV}-${PV}"

SLOT="${MY_MPV}"
KEYWORDS="amd64 ppc ~sparc x86"
LICENSE="LGPL-2"

DEPEND=""

src_compile() {

	econf \
		--enable-mt \
		|| die "Failed to econf"
	# for later - --enable-hashtable - requires libdict (whatever that is)

	emake || die "Failed to emake"
}

src_install() {
	emake "DESTDIR=${D}" install || die "Failed to install"
	dodoc AUTHORS BUGS ChangeLog FEATURES HISTORY
	dodoc README NEWS TODO
}
