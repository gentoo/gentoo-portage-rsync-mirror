# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/autodock/autodock-4.2.3-r1.ebuild,v 1.3 2011/06/26 09:00:41 jlec Exp $

EAPI=3

PYTHON_DEPEND="test? 2"

inherit autotools eutils python

MY_PN="autodocksuite"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A suite of automated docking tools"
HOMEPAGE="http://autodock.scripps.edu/"
SRC_URI="mirror://gentoo/${MY_PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/src"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -i -e "s/\tcsh/\tsh/" \
		autodock/Makefile.am autogrid/Makefile.am || die "sed failed"
	for i in autodock autogrid; do
		pushd $i &>/dev/null
		eautoreconf
		popd &>/dev/null
	done
}

src_configure() {
	for i in autodock autogrid; do
		pushd $i &>/dev/null
		econf
		popd &>/dev/null
	done
}

src_compile() {
	emake -C autodock || die
	emake -C autogrid || die
}

src_test() {
	einfo "Testing autodock"
	cd "${S}/autodock/Tests"
	cp ../*.dat .
	$(PYTHON) test_autodock4.py || die "AutoDock tests failed."
	einfo "Testing autogrid"
	cd "${S}/autogrid/Tests"
	$(PYTHON) test_autogrid4.py || die "AutoGrid tests failed."
}

src_install() {
	dobin "${S}"/autodock/autodock4 "${S}"/autogrid/autogrid4 \
		|| die "Failed to install autodock binary."

	insinto "/usr/share/autodock"
	doins "${S}"/autodock/{AD4_parameters.dat,AD4_PARM99.dat} \
		 || die "Failed to install shared files."

	dodoc "${S}"/autodock/{AUTHORS,ChangeLog,NEWS,README} \
		|| die "Failed to install documentation."
}

pkg_postinst() {
	einfo "The AutoDock development team requests all users to fill out the"
	einfo "registration form at:"
	einfo
	einfo "\thttp://autodock.scripps.edu/downloads/autodock-registration"
	einfo
	einfo "The number of unique users of AutoDock is used by Prof. Arthur J."
	einfo "Olson and the Scripps Research Institude to support grant"
	einfo "applications."
}
