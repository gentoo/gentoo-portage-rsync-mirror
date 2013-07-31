# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zypper/zypper-1.9.1.ebuild,v 1.2 2013/07/31 16:32:05 miska Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Command line RPM package manager developed by SUSE"
HOMEPAGE="http://en.opensuse.org/Portal:Zypper"
SRC_URI="http://github.com/openSUSE/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	app-admin/augeas
	dev-libs/libxml2
	dev-libs/libzypp
	sys-libs/readline:0
"
DEPEND="${DEPEND}
	sys-devel/gettext
"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-header.patch"
}

src_test() {
	cmake-utils_src_compile -C tests
	cmake-utils_src_test
}
