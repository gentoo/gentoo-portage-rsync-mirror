# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind-dns-keygen/bind-dns-keygen-9.3.2.39.ebuild,v 1.2 2012/12/06 19:59:19 ulm Exp $

inherit rpm toolchain-funcs

# Tag for which Fedora Core version it's from
FCVER="6"

MY_PV="${PV%.*}-${PV##*.}"
MY_P="${PN%%-*}-${MY_PV}"
DESCRIPTION="A simple BIND key generator"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${MY_P}.fc${FCVER}.src.rpm"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_compile() {
	$(tc-getCC) ${CFLAGS} -o ${PN#*-} ${PN##*-}.c || die "compile failed"
}

src_install() {
	dosbin ${PN#*-} || die "dosbin failed"
}
