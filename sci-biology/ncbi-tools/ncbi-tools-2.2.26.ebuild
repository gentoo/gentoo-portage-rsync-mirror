# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ncbi-tools/ncbi-tools-2.2.26.ebuild,v 1.2 2012/10/24 19:31:33 ulm Exp $

EAPI=4

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Development toolkit and applications for computational biology, including NCBI BLAST"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"
SRC_URI="ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/${PV}/ncbi.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~alpha ~amd64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc static-libs X"

RDEPEND="
	app-shells/tcsh
	dev-lang/perl
	media-libs/libpng
	X? ( x11-libs/motif:0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ncbi"

EXTRA_VIB="asn2all asn2asn"

pkg_setup() {
	echo
	ewarn 'Please note that the NCBI toolkit (and especially the X'
	ewarn 'applications) are known to have compilation and run-time'
	ewarn 'problems when compiled with agressive compilation flags. The'
	ewarn '"-O3" flag is filtered by the ebuild on the x86 architecture if'
	ewarn 'X support is enabled.'
	echo
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-extra_vib.patch

	if use ppc || use ppc64; then
		epatch "${FILESDIR}"/${PN}-lop.patch
	fi

	if ! use X; then
		sed \
			-e "s:\#set HAVE_OGL=0:set HAVE_OGL=0:" \
			-e "s:\#set HAVE_MOTIF=0:set HAVE_MOTIF=0:" \
			-i "${S}"/make/makedis.csh || die
	else
		# X applications segfault on startup on x86 with -O3.
		use x86 || replace-flags '-O3' '-O2'
	fi

	# Apply user C flags...
	cd "${S}"/platform
	sed \
		-e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" \
		-e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O2/NCBI_LDFLAGS1 = ${CFLAGS} ${LDFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mcpu=pentium4/NCBI_LDFLAGS1 = ${CFLAGS} ${LDFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mieee/NCBI_LDFLAGS1 = -mieee ${CFLAGS} ${LDFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3/NCBI_LDFLAGS1 = ${CFLAGS} ${LDFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O2/NCBI_OPTFLAG = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mcpu=pentium4/NCBI_OPTFLAG = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mieee/NCBI_OPTFLAG = -mieee ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux-x86.ncbi.mk linux-alpha.ncbi.mk hppalinux.ncbi.mk \
			ppclinux.ncbi.mk linux64.ncbi.mk linux.ncbi.mk || die

	# We use dynamic libraries
	sed -i -e "s/-Wl,-Bstatic//" *linux*.ncbi.mk || die

	sed \
		-re "s:/usr(/bin/.*sh):\1:g" \
		-e "s:(/bin/.*sh):${EPREFIX}\1:g" \
		-i $(find "${S}" -type f) || die
}

src_compile() {
	export EXTRA_VIB
	cd "${WORKDIR}"
	csh ncbi/make/makedis.csh || die
	mkdir "${S}"/cgi "${S}"/real || die
	mv "${S}"/bin/*.cgi "${S}"/cgi || die
	mv "${S}"/bin/*.REAL "${S}"/real || die
	cd "${S}"/demo
	emake \
		-f ../make/makenet.unx \
		CC="$(tc-getCC) ${CFLAGS} -I../include  -L../lib" \
		LDFLAGS="${LDFLAGS}" \
		spidey
	cp spidey ../bin/ || die
}

src_install() {
	#sci-geosciences/cdat-lite
	mv "${S}"/bin/cdscan "${S}"/bin/cdscan-ncbi || die

	dobin "${S}"/bin/*

	for i in ${EXTRA_VIB}; do
		dobin "${S}"/build/${i} || die "Failed to install binaries."
	done
	use static-libs && dolib.a "${S}"/lib/*.a
	mkdir -p "${ED}"/usr/include/ncbi
	cp -RL "${S}"/include/* "${ED}"/usr/include/ncbi || \
		die "Failed to install headers."

	# TODO: wwwblast with webapps
	#insinto /usr/share/ncbi/lib/cgi
	#doins ${S}/cgi/*
	#insinto /usr/share/ncbi/lib/real
	#doins ${S}/real/*

	# Basic documentation
	dodoc "${S}"/{README,VERSION,doc/{*.txt,README.*}}
	newdoc "${S}"/doc/fa2htgs/README README.fa2htgs
	newdoc "${S}"/config/README README.config
	newdoc "${S}"/network/encrypt/README README.encrypt
	newdoc "${S}"/network/nsclilib/readme README.nsclilib
	newdoc "${S}"/sequin/README README.sequin
	doman "${S}"/doc/man/*

	# Hypertext user documentation
	dohtml "${S}"/{README.htm,doc/{*.html,*.htm,*.gif}}
	insinto /usr/share/doc/${PF}/html
	doins -r "${S}"/doc/blast "${S}"/doc/images "${S}"/doc/seq_install

	# Developer documentation
	if use doc; then
		# Demo programs
		mkdir "${ED}"/usr/share/ncbi
		mv "${S}"/demo "${ED}"/usr/share/ncbi/demo || die
	fi

	# Shared data (similarity matrices and such) and database directory.
	insinto /usr/share/ncbi
	doins -r "${S}"/data
	dodir /usr/share/ncbi/formatdb

	# Default config file to set the path for shared data.
	insinto /etc/ncbi
	newins "${FILESDIR}"/ncbirc .ncbirc

	# Env file to set the location of the config file and BLAST databases.
	newenvd "${FILESDIR}"/21ncbi-r1 21ncbi
}
