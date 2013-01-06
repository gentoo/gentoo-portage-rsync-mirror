# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sks/sks-1.1.2.ebuild,v 1.4 2012/02/07 00:34:06 kingtaco Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="SKS Keyserver"
HOMEPAGE="http://code.google.com/p/sks-keyserver/"
SRC_URI="http://sks-keyserver.googlecode.com/files/${PF}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="optimize"

DEPEND="dev-lang/ocaml
		dev-ml/cryptokit
		sys-libs/db:4.6"
RDEPEND="${DEPEND}"

src_prepare() {
	cp Makefile.local.unused Makefile.local || die
	sed -i \
		-e "s:^BDBLIB=.*$:BDBLIB=-L/usr/$(get_libdir):g" \
		-e "s:^BDBINCLUDE=.*$:BDBINCLUDE=-I/usr/include/db4.6/:g" \
		-e "s:^PREFIX=.*$:PREFIX=${D}/usr:g" \
		-e "s:^MANDIR=.*$:MANDIR=${D}/usr/share/man:g" \
		Makefile.local || die
	sed -i \
		-e 's:^CAMLINCLUDE= -I lib -I bdb$:CAMLINCLUDE= -I lib -I bdb -I +cryptokit:g' \
		-e 's:-Werror-implicit-function-declaration::g' \
		-e 's:LIBS.bc= lib/cryptokit.cma bdb/bdb.cma:LIBS.bc= bdb/bdb.cma:g' \
		-e 's:sks_build.bc.sh:sks_build.sh:g' \
		Makefile bdb/Makefile || die
	epatch "${FILESDIR}/bdb_stubs-gentoo.patch"
}

src_compile() {
	emake dep
	emake all
	if use optimize; then
		emake all.bc
	fi
}

src_install() {
	if use optimize; then
		emake install.bc
		dosym /usr/bin/sks.bc usr/bin/sks
		dosym /usr/bin/sks_add_mail.bc usr/bin/sks_add_mail
	else
		emake install
	fi
}
