# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlc/htmlc-2.21.0.ebuild,v 1.4 2012/07/24 10:51:37 johu Exp $

EAPI=3

inherit eutils

DESCRIPTION="HTML template files expander"
HOMEPAGE="http://htmlc.inria.fr/"
SRC_URI="http://htmlc.inria.fr/${P}.tgz"

LICENSE="htmlc"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="+ocamlopt"
# Files for the tests are missing...
RESTRICT="test"

DEPEND=">=dev-lang/ocaml-3.11.2[ocamlopt?]"
RDEPEND="${DEPEND}"

src_prepare() {
	has_version '>=dev-lang/ocaml-3.12' && epatch "${FILESDIR}/${P}-ocaml312.patch"
}

src_configure() {
	./configure \
		--install-root-dir "${D}usr" \
		|| die
}

src_compile() {
	if use ocamlopt ; then
		emake bin || die
	else
		emake byt || die
	fi
}

src_install() {
	if use ocamlopt ; then
		emake installbin || die
	else
		export STRIP_MASK="*/bin/*"
		emake installbyt || die
	fi
	emake MANDIR='$(PREFIXINSTALLDIR)/share/man/man$(MANEXT)' installman || die
	dodoc README Announce* CHANGES || die
}
