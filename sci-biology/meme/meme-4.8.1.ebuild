## Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/meme/meme-4.8.1.ebuild,v 1.5 2013/01/31 07:17:25 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit autotools eutils python

DESCRIPTION="The MEME/MAST system - Motif discovery and search"
HOMEPAGE="http://meme.sdsc.edu/meme"
SRC_URI="http://meme.nbcr.net/downloads/${PN}_${PV}.tar.gz"

LICENSE="meme"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug examples mpi"

DEPEND="
	dev-libs/libxml2:2
	dev-libs/libxslt
	app-shells/tcsh
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_${PV}"

#pkg_setup() {
	# generate meme group to restrict logging to /var/log/meme
#	enewgroup meme
#	python_pkg_setup
#	python_set_active_version 2
#}

src_prepare() {
	use examples || sed -e '/SUBDIRS/s:examples::g' -i doc/Makefile.am
	sed \
		-e '/flags/s:-O3::g' \
		-e '/opt/s:-O::g' \
		-e '/debug/s:-ggdb::' \
		-e '/debug/s:-g::' \
		-e 's:CFLAGS=:CFLAGS+=:g' \
		-i configure.ac || die
	epatch \
		"${FILESDIR}"/${P}-Makefile.am.patch
	eautoreconf
}

src_configure() {
	MY_PREFIX="${ROOT}opt/meme"
	USE_DISABLE_MPI=""; if ! use mpi; then USE_DISABLE_MPI="--enable-serial"; fi
	econf \
		--sysconfdir="${EPREFIX}/etc/meme" \
		--with-logs="${ROOT}var/log/meme" \
		$(use_enable debug) \
		$USE_DISABLE_MPI
}

src_test() {
	# bug #297070
	emake -j1 test || die "Regression tests failed."
}

src_install() {
	emake install DESTDIR="${D}"

	echo "PATH=/opt/${PN}/bin" > 99${PN}
	doenvd 99${PN}

	# allow logging only for members of meme group
	# diropts -m 0770 -g meme -o root
	diropts -m ugo+rwxt -o root
	keepdir /var/log/meme
}

#pkg_postinst() {
#	einfo 'Log files are produced in the "/var/log/meme" directory. Users'
#	einfo 'need to be part of the meme group to use this facility.'
#}
