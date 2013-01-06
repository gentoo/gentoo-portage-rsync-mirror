# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.3_p2.ebuild,v 1.3 2012/03/24 13:59:39 gienah Exp $

EAPI="2"

inherit eutils multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://${PN}.inria.fr/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	>=dev-ml/camlp5-5.09[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"
DEPEND="${RDEPEND}
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		dev-texlive/texlive-mathextra
		dev-texlive/texlive-latexextra
		)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# configure has an error at line 640 leading to closing a
	# string to early in the generated coq_config.ml. Here is a
	# wild sed which replaces \"$LABLGTKLIB\" by $LABLGTKLIB.  Note
	# during pl2-bump: Hmm, my patch did not get applied upstream?
	sed -i "s/\\\\\"\\\$LABLGTKLIB\\\\\"/\\\$LABLGTKLIB/" configure
	# Stdpp.Exc_located is an alias for Ploc.Exc, it has been
	# deprecated for a while, and was removed in dev-ml/camlp5-6.05
	# Fixed by upstream in svn repo:
	# https://coq.inria.fr/bugs/show_bug.cgi?id=2728
	sed -e 's@Stdpp.Exc_located@Ploc.Exc@g' \
		-i "${S}/checker/checker.ml" \
		-i "${S}/ide/coq.ml" \
		-i "${S}/lib/util.ml" \
		-i "${S}/lib/util.mli" \
		-i "${S}/parsing/ppvernac.ml" \
		-i "${S}/plugins/subtac/subtac_obligations.ml" \
		-i "${S}/pretyping/cases.ml" \
		-i "${S}/pretyping/pretype_errors.ml" \
		-i "${S}/pretyping/typeclasses_errors.ml" \
		-i "${S}/proofs/logic.ml" \
		-i "${S}/proofs/refiner.ml" \
		-i "${S}/tactics/class_tactics.ml4" \
		-i "${S}/tactics/extratactics.ml4" \
		-i "${S}/tactics/rewrite.ml4" \
		-i "${S}/tactics/tacinterp.ml" \
		-i "${S}/toplevel/cerrors.ml" \
		-i "${S}/toplevel/toplevel.ml" \
		-i "${S}/toplevel/vernac.ml" \
		|| die "Could not rename deprecated Stdpp.Exc_located to Ploc.Exc"
}

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr
		--bindir /usr/bin
		--libdir /usr/$(get_libdir)/coq
		--mandir /usr/share/man
		--emacslib /usr/share/emacs/site-lisp
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--docdir /usr/share/doc/${PF}
		--camlp5dir ${ocaml_lib}/camlp5
		--lablgtkdir ${ocaml_lib}/lablgtk2"

	use debug && myconf="--debug $myconf"
	use doc || myconf="$myconf --with-doc no"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"
	use ocamlopt && myconf="$myconf --opt"

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure $myconf || die "configure failed"
}

src_compile() {
	emake STRIP="true" -j1 || die "make failed"
}

src_install() {
	emake STRIP="true" COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && domenu "${FILESDIR}/coqide.desktop"
}
