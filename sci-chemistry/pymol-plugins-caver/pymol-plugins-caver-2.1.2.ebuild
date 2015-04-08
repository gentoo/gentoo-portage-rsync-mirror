# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-caver/pymol-plugins-caver-2.1.2.ebuild,v 1.1 2011/03/18 10:22:58 jlec Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit multilib python eutils versionator java-utils-2

MY_PV="$(replace_all_version_separators _)"
MY_P="Caver${MY_PV}_pymol_plugin"

DESCRIPTION="Calculation of pathways from buried cavities to outside solvent in protein structures"
HOMEPAGE="http://loschmidt.chemi.muni.cz/caver/"
SRC_URI="${MY_P}.zip"

LICENSE="CAVER"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=virtual/jre-1.6
	sci-chemistry/pymol"
DEPEND="app-arch/unzip"

RESTRICT="fetch"

S="${WORKDIR}/${MY_P}"/linux_mac

pkg_nofetch() {
	elog "Download ${A}"
	elog "from ${HOMEPAGE}. This requires registration."
	elog "Place tarballs in ${DISTDIR}."
}

src_prepare() {
	python_copy_sources
}

src_install() {
	java-pkg_dojar Caver${MY_PV}/*.jar

	java-pkg_jarinto /usr/share/${PN}/lib/lib/
	java-pkg_dojar Caver${MY_PV}/lib/*.jar

	installation() {
	sed \
		-e "s:directory/where/jar/with/plugin/is/located:${EPREFIX}/usr/share/${PN}/lib/:g" \
		-i Caver${MY_PV}.py || die

		insinto $(python_get_sitedir)/pmg_tk/startup/
		doins Caver${MY_PV}.py || die
	}
	python_execute_function -s installation
}

pkg_postinst() {
	python_mod_optimize pmg_tk/startup/Caver${MY_PV}.py
}

pkg_postrm() {
	python_mod_cleanup pmg_tk/startup/Caver${MY_PV}.py
}
