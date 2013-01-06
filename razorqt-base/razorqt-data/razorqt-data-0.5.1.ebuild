# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/razorqt-data/razorqt-data-0.5.1.ebuild,v 1.1 2012/10/24 11:34:20 yngwin Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="Shared resources and data for the Razor-qt desktop environment"
HOMEPAGE="http://razor-qt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="https://github.com/downloads/Razor-qt/razor-qt/razorqt-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/razorqt-${PV}"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="doc"

RDEPEND="!<razorqt-base/razorqt-lightdm-greeter-0.5.0
	!<razorqt-base/razorqt-meta-0.5.0
	!x11-misc/lightdm-razorqt-greeter
	!x11-wm/razorqt"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DSPLIT_BUILD=On
		-DMODULE_RESOURCES=On
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make

	# build developer documentation using Doxygen
	use doc && emake -C "${CMAKE_BUILD_DIR}" docs
}

src_install() {
	cmake-utils_src_install

	# install developer documentation
	use doc && dodoc -r "${CMAKE_BUILD_DIR}/docs"
}
