# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlduce/ocamlduce-3.12.1.0.ebuild,v 1.1 2011/07/07 20:34:43 aballier Exp $

EAPI="2"

inherit versionator eutils toolchain-funcs flag-o-matic multilib

OCAML_VERSION=3.12.1
OCAML_TARBALL=ocaml-${OCAML_VERSION}.tar.bz2
OCAML_PATCHLEVEL=3
OCAML_GENTOO_PATCHES=ocaml-patches-${OCAML_PATCHLEVEL}.tar.bz2

DESCRIPTION="OCamlDuce is a merger between OCaml and CDuce"
HOMEPAGE="http://ocamlduce.forge.ocamlcore.org/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/644/${P}.tar.gz
	ftp://ftp.inria.fr/INRIA/cristal/ocaml/ocaml-$(get_version_component_range 1-2 ${OCAML_VERSION})/${OCAML_TARBALL}
	mirror://gentoo/${OCAML_GENTOO_PATCHES}"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="+ocamlopt"

DEPEND="~dev-lang/ocaml-${OCAML_VERSION/+/_}[ocamlopt?]
	>=dev-ml/findlib-1.2.4-r1
	!!<dev-ml/${P}"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/ocaml-${OCAML_VERSION}

src_unpack() {
	unpack ${P}.tar.gz ${OCAML_GENTOO_PATCHES}
}

src_prepare() {
	cd "${WORKDIR}/${P}"
	emake OCAML_SOURCE="${DISTDIR}/${OCAML_TARBALL}" prepare || die "failed to prepare"
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
}

src_configure() {
	RAW_LDFLAGS="$(raw-ldflags)" ./configure -prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/ocaml \
		--mandir /usr/share/man \
		-host "${CHOST}" \
		-cc "$(tc-getCC)" \
		-as "$(tc-getAS)" \
		-aspp "$(tc-getCC) -c" \
		--with-pthread || die "configure failed!"
}

src_compile() {
	if use ocamlopt; then
		emake -f Makefile.ocamlduce -j1 world.opt || die
	else
		emake -f Makefile.ocamlduce -j1 world || die
	fi
}

src_install() {
	emake -f Makefile.ocamlduce BINDIR="${D}/usr/bin" LIBDIR="${D}/usr/$(get_libdir)/ocaml" installbyte || die
	if use ocamlopt; then
		emake -f Makefile.ocamlduce BINDIR="${D}/usr/bin" LIBDIR="${D}/usr/$(get_libdir)/ocaml" installopt || die
	fi
	dodoc Changes README
}
