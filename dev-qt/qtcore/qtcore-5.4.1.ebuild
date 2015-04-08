# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtcore/qtcore-5.4.1.ebuild,v 1.3 2015/03/08 14:00:04 pesa Exp $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="Cross-platform application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~x86"
fi

IUSE="icu systemd"

DEPEND="
	dev-libs/glib:2
	>=dev-libs/libpcre-8.30[pcre16]
	sys-libs/zlib
	virtual/libiconv
	icu? ( dev-libs/icu:= )
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/tools/bootstrap
	src/tools/moc
	src/tools/rcc
	src/corelib
	src/tools/qlalr
)

src_configure() {
	local myconf=(
		$(qt_use icu)
		$(qt_use systemd journald)
	)
	qt5-build_src_configure
}
