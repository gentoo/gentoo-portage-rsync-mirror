# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-0.3.1.ebuild,v 1.1 2014/01/08 13:36:06 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 cmake-utils

DESCRIPTION="Python scripting backend for Qross."
HOMEPAGE="http://github.com/0xd34df00d/Qross"
SRC_URI="https://github.com/0xd34df00d/Qross/archive/${PV}.tar.gz -> qrosscore-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	=dev-libs/qrosscore-${PV}
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/Qross-${PV}"
CMAKE_USE_DIR="${S}/src/bindings/python/qrosspython"
