# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/socket-sentry/socket-sentry-0.9.3.ebuild,v 1.2 2014/08/05 16:31:48 mrueg Exp $

EAPI=5

inherit kde4-base

MY_PN="socketsentry"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A KDE plasmoid that displays real-time network traffic on your Linux computer"
HOMEPAGE="http://code.google.com/p/socket-sentry"
SRC_URI="http://socket-sentry.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug test"

RDEPEND="
	>=net-libs/libpcap-0.8
"
DEPEND="${RDEPEND}
	test? ( dev-cpp/gmock dev-cpp/gtest )
"

PATCHES=( "${FILESDIR}/${PN}-0.9.3-automagictests.patch" )

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with test TESTS)
	)
	cmake-utils_src_configure
}
