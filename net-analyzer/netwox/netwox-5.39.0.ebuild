# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwox/netwox-5.39.0.ebuild,v 1.3 2013/01/03 15:00:45 nativemad Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

EAPI=4
inherit toolchain-funcs multilib

DESCRIPTION="Toolbox of 217 utilities for testing Ethernet/IP networks"
HOMEPAGE="
	http://ntwox.sourceforge.net/
	http://www.laurentconstantin.com/en/netw/netwox/
"
SRC_URI="mirror://sourceforge/ntwox/${P}-src.tgz
	doc? ( mirror://sourceforge/ntwox/${P}-doc_html.tgz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc x86"
IUSE="doc"

RDEPEND=">=net-libs/libnet-1.1.1"

DEPEND="
	${RDEPEND}
	net-libs/libpcap
	~net-libs/netwib-${PV}
"

S=${WORKDIR}/${P}-src/src

src_prepare() {
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/lib:/$(get_libdir):" \
		-e "s:/usr/local:/usr:" \
		-e "s:=ar:=$(tc-getAR):" \
		-e "s:=ranlib:=$(tc-getRANLIB):" \
		-e "s:=gcc:=$(tc-getCC):" \
		-e "s:-O2:${CFLAGS}:" \
		config.dat || die "patching config.dat failed"
	sed -i \
		-e "s:-o netwox:& \${LDFLAGS}:g" \
		-e 's: ; make: ; \\$(MAKE):g' \
		genemake || die "patching genemake failed"
}

src_configure() {
	sh genemake || die "problem creating Makefile"
}

src_install() {
	default
	dodoc ../README.TXT
	if use doc;
	then
		mv "${WORKDIR}"/${P}-doc_html "${D}"/usr/share/doc/${PF}/html
	fi

	dodoc "${S}"/../doc/{changelog.txt,credits.txt} \
		"${S}"/../doc/{problemreport.txt,problemusageunix.txt,todo.txt}
}
