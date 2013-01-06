# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/charm/charm-5.9.ebuild,v 1.19 2011/10/05 18:40:35 aballier Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Charm++ is a message-passing parallel language and runtime system."
LICENSE="charm"
HOMEPAGE="http://charm.cs.uiuc.edu/"
SRC_URI="${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE="cmkopt tcp smp doc"

RESTRICT="fetch"

DEPEND="
	doc? (
		app-text/poppler
		dev-tex/latex2html
		virtual/latex-base
		dev-texlive/texlive-genericrecommended
		dev-texlive/texlive-latexextra
	)"

RDEPEND="${DEPEND}"

CHARM_ARCH="net-linux"
CHARM_DOWNLOAD="http://charm.cs.uiuc.edu/download/"

pkg_nofetch() {
	echo
	einfo "Please download ${P}.tar.gz from"
	einfo "${CHARM_DOWNLOAD}"
	einfo "and then move it to ${DISTDIR}"
	echo
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc-4.2.patch

	# add -fPIC to generate PIC code for charm so's
	epatch "${FILESDIR}"/${PN}-fpic-gentoo.patch

	# for pdf/html docs we need to patch the makefiles
	if use doc; then
		epatch "${FILESDIR}"/${PN}-doc-makefile-gentoo.patch
	fi

	# patch the example Makefiles so they run out of
	# the box
	epatch "${FILESDIR}"/${PN}-examples-gentoo.patch

	# enable proper detection of python in configure
	epatch "${FILESDIR}"/${PN}-python-configure-gentoo.patch

	# gcc-4.1 fixes
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# TCP instead of default UDP for socket comunication
	# protocol
	if use tcp; then
		CHARM_OPTS="${CHARM_OPTS} tcp"
	fi

	# enable direct SMP support using shared memory
	if use smp; then
		CHARM_OPTS="${CHARM_OPTS} smp"
	fi

	# compile with icc if requested (icc or icpc)
	if [ $(tc-getCC) = icc ] || [ $(tc-getCXX) = ic* ]; then
		CHARM_OPTS="${CHARM_OPTS} icc"
	fi

	# CMK optimization
	if use cmkopt; then
		append-flags -DCMK_OPTIMIZE=1
	fi
}

src_compile() {
	# build charmm++ first
	./build charm++ net-linux ${CHARM_OPTS} ${CFLAGS} || \
		die "Failed to build charm++"

	# make pdf/html docs
	if use doc; then
		cd "${S}"/doc
		make doc || die "failed to create pdf/html docs"
	fi
}

src_install() {
	# make charmc play well with gentoo before
	# we move it into /usr/bin
	einfo "Fixing paths in charmc wrapper"
	epatch "${FILESDIR}"/${PN}-charmc-gentoo.patch

	sed -e "s/gentoo-include/${P}/" -i ./src/scripts/charmc || \
		die "failed patching charmc script"

	# install binaries
	cd "${S}"/bin
	dobin ./charmd ./charmd_faceless ./charmr* ./charmc ./charmxi \
		./conv-cpm ./dep.pl || die "Failed to install binaries"

	# install headers
	cd "${S}"/include
	insinto /usr/include/${P}
	doins * || die "failed to install header files"

	# install static libs
	cd "${S}"/lib
	dolib.a * || die "failed to install static libs"

	# install shared libs
	cd "${S}"/lib_so
	dolib.so * || die "failed to install shared libs"

	# basic docs
	cd "${S}"
	dodoc CHANGES README  || die "Failed to install docs"

	# install examples after fixing path to charmc
	find examples/ -name 'Makefile' | xargs sed \
		-r "s:(../)+bin/charmc:/usr/bin/charmc:" -i || \
		die "Failed to fix examples"
	find examples/ -name 'Makefile' | xargs sed \
		-r "s:./charmrun:./charmrun ++local:" -i || \
		die "Failed to fix examples"
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/charm++/*

	# pdf/html docs
	if use doc; then
		cd "${S}"/doc
		# install pdfs
		insinto /usr/share/doc/${PF}/pdf
		doins  doc/pdf/* || die "failed to install pdf docs"
		# install html
		docinto html
		dohtml -r doc/html/* || die "failed to install html docs"
	fi
}

pkg_postinst() {
	echo
	einfo "Please test your charm installation by copying the"
	einfo "content of /usr/share/doc/${PF}/examples to a"
	einfo "temporary location and run 'make test'."
	echo
}
