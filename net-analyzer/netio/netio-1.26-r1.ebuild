# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netio/netio-1.26-r1.ebuild,v 1.1 2010/08/09 17:44:49 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs versionator

MY_P="${PN}$(get_version_component_range 1)$(get_version_component_range 2)"
DESCRIPTION="a network benchmark for DOS, OS/2, Windows NT and Unix that measures net througput with NetBIOS and TCP/IP protocols."
HOMEPAGE="http://www.ars.de/ars/ars.nsf/docs/netio"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	edos2unix *.c *.h

	sed -i Makefile \
		-e 's|\(CFLAGS\)=|\1+=|g' \
		-e 's|\(CC\)=|\1?=|g' \
		-e "s|LFLAGS=\"\"|LFLAGS?=\"${LDFLAGS}\"|g" \
		|| die "sed Makefile failed"
	epatch "${FILESDIR}"/${P}-linux-include.patch
}

src_compile() {
	emake linux	\
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin netio || die "dobin failed"

	# to be sure to comply with the license statement in netio.doc,
	# just install everything included in the package to doc
	dodoc netio.doc FILE_ID.DIZ getopt.h netb_1_c.h netbios.h netio.c \
		netb_2_c.h netio.doc getopt.c Makefile netbios.c

	# also install binaries
	dodoc bin/os2-i386.exe bin/win32-i386.exe
}

pkg_postinst() {
	echo
	elog "NOTE: all files included in the upstream zip file have"
	elog "been installed to /usr/share/doc/${PF}, as required by"
	elog "the license."
	echo
}
