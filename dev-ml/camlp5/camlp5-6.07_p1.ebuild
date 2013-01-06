# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlp5/camlp5-6.07_p1.ebuild,v 1.1 2012/10/09 21:55:18 aballier Exp $

EAPI="2"

inherit multilib findlib eutils

MY_P=${P%_p*}
DESCRIPTION="A preprocessor-pretty-printer of ocaml"
HOMEPAGE="http://pauillac.inria.fr/~ddr/camlp5/"
SRC_URI="http://pauillac.inria.fr/~ddr/camlp5/distrib/src/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]"
RDEPEND="${DEPEND}"

PATCHLEVEL=${PV#*_p}
PATCHLIST=""

if [ "${PATCHLEVEL}" != "${PV}" ] ; then
	for (( i=1; i<=PATCHLEVEL; i++ )) ; do
		SRC_URI="${SRC_URI}
			http://pauillac.inria.fr/~ddr/camlp5/distrib/src/patch-${PV%_p*}-${i} -> ${MY_P}-patch-${i}.patch"
		PATCHLIST="${PATCHLIST} ${MY_P}-patch-${i}.patch"
	done
fi

S=${WORKDIR}/${MY_P}

src_prepare() {
	for i in ${PATCHLIST} ; do
		epatch "${DISTDIR}/${i}"
	done
}

src_configure() {
	./configure \
		--strict \
		-prefix /usr \
	    -bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man || die "configure failed"
}

src_compile(){
	emake || die "emake failed"
	if use ocamlopt; then
		emake  opt || die "Compiling native code programs failed"
		emake  opt.opt || die "Compiling native code programs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# findlib support
	insinto "$(ocamlfind printconf destdir)/${PN}"
	doins etc/META || die "failed to install META file for findlib support"

	use doc && dohtml -r doc/*

	dodoc CHANGES DEVEL ICHANGES README UPGRADING MODE
}
