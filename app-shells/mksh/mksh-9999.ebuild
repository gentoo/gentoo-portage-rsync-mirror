# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mksh/mksh-9999.ebuild,v 1.4 2012/12/01 03:12:33 patrick Exp $

EAPI=4

inherit eutils toolchain-funcs

if [[ $PV = 9999 ]]; then
	inherit cvs
	ECVS_SERVER="anoncvs.mirbsd.org:/cvs"
	ECVS_MODULE="mksh"
	ECVS_USER="_anoncvs"
	ECVS_AUTH="ext"
	KEYWORDS=""
else
	inherit unpacker
	DEPEND="app-arch/cpio"
	SRC_URI="http://www.mirbsd.org/MirOS/dist/mir/mksh/${PN}-R${PV}.cpio.gz"
	KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"
fi

DESCRIPTION="MirBSD Korn Shell"
HOMEPAGE="http://mirbsd.de/mksh"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND="${DEPEND}"
RDEPEND=""
S="${WORKDIR}/${PN}"

src_compile() {
	tc-export CC
	export CPPFLAGS="${CPPFLAGS} -DMKSH_DEFAULT_PROFILEDIR=\\\"${EPREFIX}/etc\\\""
	sh Build.sh -r -c lto || sh Rebuild.sh || die
}

src_install() {
	exeinto /bin
	doexe mksh
	doman mksh.1
	dodoc dot.mkshrc
}

src_test() {
	./test.sh || die
}
