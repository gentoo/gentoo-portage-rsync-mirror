# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/libsparse/libsparse-4.4.4.1.ebuild,v 1.1 2014/07/01 13:24:13 jauhien Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 versionator

ANDROID_VERSION=$(get_version_component_range 1-3)
ANDROID_REVISION=$(get_version_component_range 4-)

DESCRIPTION="Library and cli tools for Android sparse files"
HOMEPAGE="https://android.googlesource.com/platform/system/core"
SRC_URI="https://android.googlesource.com/platform/system/core/+archive/android-${ANDROID_VERSION}_r${ANDROID_REVISION}/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

RDEPEND="${PYTHON_DEPS}"

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}"
}

src_install() {
	default

	python_doscript simg_dump.py
}
