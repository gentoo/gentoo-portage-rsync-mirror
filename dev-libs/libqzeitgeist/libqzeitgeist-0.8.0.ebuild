# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libqzeitgeist/libqzeitgeist-0.8.0.ebuild,v 1.5 2013/09/05 18:29:54 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
KDE_REQUIRED="never"
inherit python-single-r1 kde4-base

DESCRIPTION="Qt interface to the Zeitgeist event tracking system"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/libqzeitgeist"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/libzeitgeist
	dev-qt/qtdeclarative:4
"
DEPEND="
	${RDEPEND}
	gnome-extra/zeitgeist
"

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}
