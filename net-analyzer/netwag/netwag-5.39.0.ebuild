# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwag/netwag-5.39.0.ebuild,v 1.5 2013/02/01 15:43:31 jer Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

EAPI=4

DESCRIPTION="Tcl/tk interface to netwox (Toolbox of 222 utilities for testing Ethernet/IP networks)"
HOMEPAGE="
	http://ntwag.sourceforge.net/
	http://www.laurentconstantin.com/en/netw/netwag/
"
SRC_URI="mirror://sourceforge/ntwag/${P}-src.tgz
	doc? ( mirror://sourceforge/ntwag/${P}-doc_html.tgz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc x86"
IUSE="doc"

DEPEND="
	~net-analyzer/netwox-${PV}
	>=dev-lang/tk-8
	|| (
		x11-terms/xterm
		kde-base/konsole
		x11-terms/eterm
		x11-terms/gnome-terminal
		x11-terms/rxvt
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src/src"

src_prepare() {
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/usr/local:/usr:" \
		config.dat || die
	sed -i \
		-e 's|eterm|Eterm|g' \
		genemake || die
}

src_configure() {
	sh genemake || die "problem creating Makefile"
}

src_install() {
	default
	dodoc ../README.TXT
	if use doc;
	then
		mv "${WORKDIR}"/${P}-doc_html \
			"${D}"/usr/share/doc/${PF}/html
	fi

	dodoc "${S}"/../doc/{changelog.txt,credits.txt} \
		"${S}"/../doc/{problemreport.txt,problemusage.txt,todo.txt}
}
