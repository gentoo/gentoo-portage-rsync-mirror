# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant-python/geant-python-4.9.5_p02.ebuild,v 1.1 2013/05/12 03:32:16 patrick Exp $

EAPI=4

inherit python versionator

MYP="geant$(replace_version_separator 3 .)"

DESCRIPTION="Python binding for geant"
HOMEPAGE="http://geant4.cern.ch/"
SRC_URI="http://geant4.cern.ch/support/source/${MYP}.tar.gz"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="geant4"
SLOT="0"
IUSE="examples"

RDEPEND="=sci-physics/geant-${PV}* \
	dev-libs/boost[python]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}/environments/g4py"

src_prepare() {
	# DISTDIR and python path patch
	epatch "${FILESDIR}"/${PN}-4.9.5-build.patch

	# set to the highest verbose for visManager
	epatch "${FILESDIR}"/${PN}-4.9.5-visverbose.patch

	# let Geant4 module installed into python sitedir instead of default
	sed -i "/G4PY_LIBDIR  :=/cG4PY_LIBDIR  := $\(DESTDIR\)$(python_get_sitedir)/Geant4" \
		config/install.gmk || die "sed failed on config/install.gmk"
	for mfile in source/python{3,}/GNUmakefile
	do
		sed -i "/install_dir :=/cinstall_dir := $\(DESTDIR\)$(python_get_sitedir)/Geant4" \
			"${mfile}" || die "sed failed on ${mfile}"
	done

	# let g4py module installed into python sitedir instead of default
	sed -i "/install_dir :=/cinstall_dir := $\(DESTDIR\)$(python_get_sitedir)/g4py" \
		config/site-install.gmk || die "sed failed on config/site-install.gmk"
	for mfile in {processes/emcalculator,utils/MCScore}/{python3/,}GNUmakefile python/GNUmakefile
	do
		sed -i "/install_dir :=/cinstall_dir := $\(DESTDIR\)$(python_get_sitedir)/g4py" \
			"site-modules/${mfile}" || die "sed failed on site-modules/${mfile}"
	done
}

src_configure() {
	case ${CHOST} in
		x86_64-pc-linux-gnu)
			ARG=linux64
			;;
		i?86-pc-linux-gnu)
			ARG=linux
			;;
		*)
			die "platform unknown"
			;;
	esac

	./configure ${ARG} \
		--prefix="${EPREFIX}/usr" \
		--with-g4-incdir="${EPREFIX}/usr/include/Geant4" \
		--with-g4-libdir="${EPREFIX}/usr/lib" \
		--with-clhep-incdir="${EPREFIX}/usr/include" \
		--with-clhep-libdir="${EPREFIX}/usr/lib" \
		--with-python-incdir="${EPREFIX}$(python_get_includedir)" \
		--with-python-libdir="${EPREFIX}$(python_get_libdir)" \
		--with-boost-incdir="${EPREFIX}/usr/include" \
		--with-boost-libdir="${EPREFIX}/usr/lib" \
	|| die "configure failed"
}

src_install() {
	emake DESTDIR="${ED}" install
	insinto /usr/share/doc/${PF}
	dodoc 00README History AUTHORS
	use examples && doins -r examples
}
