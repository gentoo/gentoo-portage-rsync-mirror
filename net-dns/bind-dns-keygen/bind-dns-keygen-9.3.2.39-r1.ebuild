# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/bind-dns-keygen/bind-dns-keygen-9.3.2.39-r1.ebuild,v 1.3 2013/12/25 23:41:29 creffett Exp $

inherit rpm toolchain-funcs

# Tag for which Fedora Core version it's from
FCVER="6"

MY_PV="${PV%.*}-${PV##*.}"
MY_P="${PN%%-*}-${MY_PV}"
DESCRIPTION="A simple BIND key generator"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://gentoo/${MY_P}.fc${FCVER}.src.rpm"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN#*-} ${PN##*-}.c || die "compile failed"
}

src_install() {
	dosbin ${PN#*-} || die "dosbin failed"
}
