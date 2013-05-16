# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-dynamics/pymol-plugins-dynamics-1.2.0.ebuild,v 1.1 2013/05/16 09:53:54 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1

MY_PN="Dynamics"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Molecular dynamics in Pymol"
HOMEPAGE="https://github.com/tomaszmakarewicz/Dynamics"
SRC_URI="https://github.com/tomaszmakarewicz/Dynamics/archive/v1.2.0.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"/${MY_P}

DOCS=( manual.odt )

src_prepare() {
	sed \
		-e "/sys.path.insert/d" \
		-e "s:import dynamics_pymol_plugin:from pmg_tk.startup import dynamics_pymol_plugin:g" \
		-i pydynamics* || die
}

src_install() {
	python_moduleinto pmg_tk/startup
	python_parallel_foreach_impl python_domodule dynamics_pymol_plugin.py
	python_parallel_foreach_impl python_doscript pydynamics*
}
