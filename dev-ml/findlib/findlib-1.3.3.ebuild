# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/findlib/findlib-1.3.3.ebuild,v 1.6 2012/09/29 18:37:34 armin76 Exp $

EAPI=2

inherit multilib

RESTRICT="installsources"

DESCRIPTION="OCaml tool to find/use non-standard packages."
HOMEPAGE="http://projects.camlcity.org/projects/findlib.html"
SRC_URI="http://download.camlcity.org/download/${P}.tar.gz"
IUSE="doc +ocamlopt tk"

LICENSE="MIT"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?,tk?]"
RDEPEND="${DEPEND}"

ocamlfind_destdir="/usr/$(get_libdir)/ocaml"
stublibs="${ocamlfind_destdir}/stublibs"

src_configure() {
	local myconf
	use tk && myconf="-with-toolbox"
	./configure -bindir /usr/bin -mandir /usr/share/man \
		-sitelib ${ocamlfind_destdir} \
		-config ${ocamlfind_destdir}/findlib/findlib.conf \
		${myconf} || die "configure failed"
}

src_compile() {
	emake all || die
	if use ocamlopt; then
		emake opt || die # optimized code
	else
		# If using bytecode we dont want to strip the binary as it would remove the
		# bytecode and only leave ocamlrun...
		export STRIP_MASK="*/bin/*"
	fi
}

src_install() {
	dodir `ocamlc -where`

	emake prefix="${D}" install || die

	dodir "${stublibs}"

	cd "${S}/doc"
	dodoc QUICKSTART README DOCINFO
	use doc && dohtml -r ref-html guide-html
}

check_stublibs() {
	local ocaml_stdlib=`ocamlc -where`
	local ldconf="${ocaml_stdlib}/ld.conf"

	if [ ! -e ${ldconf} ]
	then
		echo "${ocaml_stdlib}" > ${ldconf}
		echo "${ocaml_stdlib}/stublibs" >> ${ldconf}
	fi

	if [ -z `grep -e ${stublibs} ${ldconf}` ]
	then
		echo ${stublibs} >> ${ldconf}
	fi
}

pkg_postinst() {
	check_stublibs
}
