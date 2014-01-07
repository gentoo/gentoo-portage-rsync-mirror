# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molequeue/molequeue-0.7.1.ebuild,v 1.1 2014/01/07 13:40:32 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils multilib python-single-r1 versionator

DESCRIPTION="Abstract, manage and coordinate execution of tasks"
HOMEPAGE="http://www.openchemistry.org/OpenChemistry/project/molequeue.html"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+client doc server test +zeromq"

REQUIRED_USE="${PYTHON_REQUIRED_USE}
	server? ( client )"

RDEPEND="${PYTHON_DEPS}
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	zeromq? ( net-libs/cppzmq )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable test TESTING)
		$(cmake-utils_use_use zeromq ZERO_MQ)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use client MoleQueue_BUILD_CLIENT)
		$(cmake-utils_use server MoleQueue_BUILD_APPLICATION)
		-DINSTALL_LIBRARY_DIR=$(get_libdir)
		)
	use zeromq && \
		mycmakeargs+=( -DZeroMQ_ROOT_DIR=\"${EPREFIX}/usr\" )

	cmake-utils_src_configure
}
