# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/meme/meme-4.3.0.ebuild,v 1.5 2011/03/02 17:41:08 jlec Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="The MEME/MAST system - Motif discovery and search"
HOMEPAGE="http://meme.sdsc.edu/meme"
SRC_URI="http://meme.nbcr.net/downloads/${PN}_${PV}.tar.gz"
LICENSE="meme"

SLOT="0"
KEYWORDS="amd64 x86"

IUSE="mpi"

DEPEND="
	dev-libs/libxml2:2
	dev-libs/libxslt
	app-shells/tcsh
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.0.0-Makefile.am.patch
	eautoreconf
}

src_configure() {
	MY_PREFIX="${ROOT}opt/meme"
	USE_DISABLE_MPI=""; if ! use mpi; then USE_DISABLE_MPI="--enable-serial"; fi
	econf --prefix=$MY_PREFIX --sysconfdir=${MY_PREFIX}/etc \
		--with-logs="${ROOT}var/log/meme" \
		$USE_DISABLE_MPI
	# $(use_enable openmp)
}

#pkg_setup() {
	# generate meme group to restrict logging to /var/log/meme
#	enewgroup meme
#}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install program files."
	echo "PATH=/opt/${PN}/bin" > 99${PN}
	doenvd 99${PN} || die
	# allow logging only for members of meme group
	# diropts -m 0770 -g meme -o root
	diropts -m ugo+rwxt -o root
	keepdir /var/log/meme
}

#pkg_postinst() {
#	einfo 'Log files are produced in the "/var/log/meme" directory. Users'
#	einfo 'need to be part of the meme group to use this facility.'
#}

src_test() {
	# bug #297070
	emake -j1 test || die "Regression tests failed."
}
