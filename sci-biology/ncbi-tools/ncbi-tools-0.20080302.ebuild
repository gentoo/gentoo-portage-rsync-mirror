# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ncbi-tools/ncbi-tools-0.20080302.ebuild,v 1.3 2013/02/18 12:53:27 jlec Exp $

EAPI=1

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Development toolkit and applications for computational biology"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"
SRC_URI="
	mirror://gentoo/${PN}-${PV/0./}.tar.gz
	doc? ( mirror://gentoo/${PN}-sdk-doc.tar.bz2 )"

#	mpi? ( mirror://gentoo/mpiblast-20070826.tar.gz )

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ppc64 ~sparc x86"

# IUSE="doc mpi X"
# mpiblast 1.5.0beta1 doesn't compile as advertised with this ncbi release.
# Currently seeking a fix.

IUSE="doc X"

RDEPEND="
	app-shells/tcsh
	dev-lang/perl
	!dev-util/fhist
	media-libs/libpng
	X? ( >=x11-libs/motif-2.3:0 )"

DEPEND="${RDEPEND}
		sys-devel/pmake"

#	mpi? ( virtual/mpi )

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

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-extra_vib.patch

	if use ppc64; then
		epatch "${FILESDIR}"/${PN}-lop.patch
	fi

#	if use mpi; then
#		cd "${WORKDIR}"
#		epatch "${WORKDIR}"/mpiblast/ncbi_Mar2007_evalue.patch
#	fi

	if ! use X; then
		cd "${S}"/make
		sed -e "s:\#set HAVE_OGL=0:set HAVE_OGL=0:" \
			-e "s:\#set HAVE_MOTIF=0:set HAVE_MOTIF=0:" \
			-i makedis.csh || die
	else
		if use x86; then
			# X applications segfault on startup on x86 with -O3.
			replace-flags '-O3' '-O2'
		fi
	fi

	# Apply user C flags...
	cd "${S}"/platform
	# ... on x86...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mcpu=pentium4/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mcpu=pentium4/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux-x86.ncbi.mk || die
	# ... on alpha...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mieee/NCBI_LDFLAGS1 = -mieee ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mieee/NCBI_OPTFLAG = -mieee ${CFLAGS}/" \
		-i linux-alpha.ncbi.mk || die
	# ... on hppa...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O2/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O2/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i hppalinux.ncbi.mk || die
	# ... on ppc...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O2/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O2/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i ppclinux.ncbi.mk || die
	# ... on generic 64-bit Linux...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux64.ncbi.mk || die
	# ... on generic Linux.
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux.ncbi.mk || die

	# Put in our MAKEOPTS (doesn't work).
	# sed -e "s:make \$MFLG:make ${MAKEOPTS}:" -i ncbi/make/makedis.csh

	# Set C compiler...
	# ... on x86...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux-x86.ncbi.mk || die
	# ... on alpha...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux-alpha.ncbi.mk || die
	# ... on hppa...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" hppalinux.ncbi.mk || die
	# ... on ppc...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" ppclinux.ncbi.mk || die
	# ... on generic 64-bit Linux...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux64.ncbi.mk || die
	# ... on generic Linux.
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux.ncbi.mk || die

	# We use dynamic libraries
	sed -i -e "s/-Wl,-Bstatic//" *linux*.ncbi.mk || die

	# GNU make 3.81 is confused by those nightmarish Makefiles, so we use pmake
	# instead. The right solution would be to fix the Makefiles. (Be my guest.)
	cd "${S}"/make
	sed -i -e "s%CMD='make%CMD='/usr/bin/pmake%" makedis.csh || die \
			"Failed to replace make by pmake."
}

src_compile() {
	export EXTRA_VIB
	cd "${WORKDIR}"
	ncbi/make/makedis.csh || die
	mkdir "${S}"/cgi
	mkdir "${S}"/real
	mv "${S}"/bin/*.cgi "${S}"/cgi || die
	mv "${S}"/bin/*.REAL "${S}"/real || die

# mpiblast fails to compile... perhaps mpiblast2 contain a fix
#	if use mpi; then
#		cd "${WORKDIR}"/mpiblast
#		AM_OPT="-a"
#		eautoreconf
#		econf --with-ncbi="${WORKDIR}"/ncbi --with-mpi=/usr
#		emake || die
#	fi
}

src_install() {
	dobin "${S}"/bin/* || die "Failed to install binaries."
	for i in ${EXTRA_VIB}; do
		dobin "${S}"/build/${i} || die "Failed to install binaries."
	done
	dolib "${S}"/lib/* || die "Failed to install libraries."
	mkdir -p "${D}"/usr/include/ncbi
	cp -RL "${S}"/include/* "${D}"/usr/include/ncbi || \
		die "Failed to install headers."

#	if use mpi; then
#		cd "${WORKDIR}"/mpiblast
#		make install DESTDIR="${D}" || die "Failed to install MPI blast."
#	fi

	# TODO: Web apps
	#insinto /usr/share/ncbi/lib/cgi
	#doins ${S}/cgi/*
	#insinto /usr/share/ncbi/lib/real
	#doins ${S}/real/*
	# TODO: Add support for wwwblast.

	# Basic documentation
	dodoc "${S}"/{README,VERSION,doc/{*.txt,README.asn2xml}} || \
		die "Failed to install basic documentation."
	newdoc "${S}"/doc/fa2htgs/README README.fa2htgs || \
		die "Failed renaming fa2htgs documentation."
	newdoc "${S}"/config/README README.config || \
		die "Failed renaming config documentation."
	newdoc "${S}"/network/encrypt/README README.encrypt || \
		die "Failed renaming encrypt documentation."
	newdoc "${S}"/network/nsclilib/readme README.nsclilib || \
	die "Failed renaming nsclilib documentation."
	newdoc "${S}"/sequin/README README.sequin || \
		die "Failed renaming sequin documentation."
	doman "${S}"/doc/man/* || \
		die "Failed to install man pages."

	# Hypertext user documentation
	dohtml "${S}"/{README.htm,doc/{*.html,*.gif}} || \
		die "Failed to install HTML documentation."
	insinto /usr/share/doc/${PF}/html/blast
	doins "${S}"/doc/blast/* || die "Failed to install blast HTML documentation."

	# Developer documentation
	if use doc; then
		# Hypertext SDK documentation
		insinto /usr/share/doc/${PF}/html/sdk
		doins "${WORKDIR}"/${PN}-sdk-doc/* || die

		# Demo programs
		mkdir "${D}"/usr/share/ncbi
		mv "${S}"/demo "${D}"/usr/share/ncbi/demo || die
	fi

	# Shared data (similarity matrices and such) and database directory.
	insinto /usr/share/ncbi/data
	doins "${S}"/data/* || die "Failed to install shared data."
	dodir /usr/share/ncbi/formatdb || die

	# Default config file to set the path for shared data.
	insinto /etc/ncbi
	newins "${FILESDIR}"/ncbirc .ncbirc || die "Failed to install config file."

	# Env file to set the location of the config file and BLAST databases.
	newenvd "${FILESDIR}"/21ncbi-r1 21ncbi || die "Failed to install env file."
}
