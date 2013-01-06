# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccpn-data/ccpn-data-2.2.2_p121012.ebuild,v 1.1 2012/10/12 16:25:35 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit portability python versionator

PATCHSET="${PV##*_p}"
MY_PN="${PN/-data}mr"
MY_PV="$(replace_version_separator 3 _ ${PV%%_p*})"
MY_MAJOR="$(get_version_component_range 1-3)"

DESCRIPTION="The Collaborative Computing Project for NMR - Data"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
SRC_URI="http://www2.ccpn.ac.uk/download/${MY_PN}/analysis${MY_PV}.tar.gz"
[[ -n ${PATCHSET} ]] && SRC_URI+=" http://dev.gentoo.org/~jlec/distfiles/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch.xz"

SLOT="0"
LICENSE="|| ( CCPN LGPL-2.1 )"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="!<sci-chemistry/ccpn-${PVR}"
DEPEND=""

RESTRICT="binchecks strip"

S="${WORKDIR}"/ccpnmr/ccpnmr2.2

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	[[ -n ${PATCHSET} ]] && \
		epatch "${WORKDIR}"/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch
}

src_install() {
	local i pydocs in_path

	dodir /usr/share/doc/${PF}/html
	sed \
		-e "s:../ccpnmr2.1:${EPREFIX}/usr/share/doc/${PF}/html:g" \
		../doc/index.html > "${ED}"/usr/share/doc/${PF}/html/index.html || die
	treecopy $(find python/ -name doc -type d) "${ED}"/usr/share/doc/${PF}/html/

	pydocs="$(find python -name doc -type d)"
	in_path=$(python_get_sitedir)/ccpn

	dosym ../../../../share/doc/${PF}/html ${in_path}/doc
	for i in ${pydocs}; do
		dosym /usr/share/doc/${PF}/html/${i} ${in_path}/${i}
	done

	dosym /usr/share/ccpn/data ${in_path}/data
	dosym /usr/share/ccpn/model ${in_path}/model

	dohtml -r doc/*
	insinto /usr/share/ccpn
	doins -r data model
}
