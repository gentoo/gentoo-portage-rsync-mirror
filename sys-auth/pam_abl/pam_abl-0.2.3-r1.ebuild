# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_abl/pam_abl-0.2.3-r1.ebuild,v 1.7 2012/05/24 05:05:31 vapier Exp $

EAPI=2

inherit flag-o-matic pam toolchain-funcs eutils

DESCRIPTION="Provides auto blacklisting of hosts and users responsible for repeated failed authentication attempts"
HOMEPAGE="http://www.hexten.net/pam_abl/"
SRC_URI="mirror://sourceforge/${PN/_/-}/${P}.tar.gz"
RESTRICT=""

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.78-r2
	>=sys-libs/db-4.2.52_p2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

# restrict tests as they're broken badly
RESTRICT="test"

src_prepare() {
	# fix as-needed per bug # 248403
	epatch "${FILESDIR}/${P}-as-needed.patch"

	# fix hardcoded values in Makefile
	sed -i -e "s:-Wall -fPIC:${CFLAGS} -Wall:" \
		-e "s:/lib/security:$(getpam_mod_dir):" \
		-e "s:cc:$(tc-getCC):" \
		-e "s:ld -:$(tc-getLD) -:" Makefile || die "sed failed in Makefile"
	sed -i -e "s:-Wall:${CFLAGS} -Wall:" \
		-e "s:cc:$(tc-getCC):" tools/Makefile || die "sed failed in tools/Makefile"

	# comment out default configuration
	sed -i -e "s:host:#host:" \
		-e "s:user:#user:" conf/pam_abl.conf || die "sed failed in conf/pam_abl.conf"
}

src_compile() {
	# fix strict aliasing problems, using -fno-strict-aliasing
	append-flags "-fPIC -fno-strict-aliasing"

	emake CC="$(tc-getCC)" \
	    LD="$(tc-getLD)" \
	    CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dopammod pam_abl.so
	dopamsecurity . conf/pam_abl.conf
	dobin tools/pam_abl
	keepdir /var/lib/abl
	dohtml doc/*.html doc/*.css
}

pkg_postinst() {
	elog "See /usr/share/doc/${PF}/html/index.html for configuration info"
	elog "and set up /etc/security/pam_abl.conf as needed."
	elog "Also check for needed changes to system-auth, we don't merge"
	elog "that automatically any more."
}
