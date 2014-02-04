# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/speedcrunch/speedcrunch-0.11.ebuild,v 1.1 2014/02/04 00:26:07 bicatali Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Fast and usable calculator for power users"
HOMEPAGE="http://speedcrunch.org/"
SRC_URI="https://github.com/${PN}/SpeedCrunch/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SpeedCrunch-${PV}/src"

src_install() {
	cmake-utils_src_install
	cd ..
	use doc && dodoc doc/*.pdf
}
