# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ext4_utils/ext4_utils-4.4.4.1.ebuild,v 1.1 2014/07/01 22:54:34 jauhien Exp $

EAPI=5

inherit versionator

ANDROID_VERSION=$(get_version_component_range 1-3)
ANDROID_REVISION=$(get_version_component_range 4-)
ANDROID_SELINUX_COMMIT=8b4760949bbafdee6f7825f39423f3db745f4115

DESCRIPTION="Tools for Android images"
HOMEPAGE="https://android.googlesource.com/platform/system/extras"
SRC_URI="https://android.googlesource.com/platform/system/extras/+archive/android-${ANDROID_VERSION}_r${ANDROID_REVISION}/${PN}.tar.gz -> ${P}.tar.gz
	https://android.googlesource.com/platform/external/libselinux/+archive/${ANDROID_SELINUX_COMMIT}.tar.gz -> libselinux-android-${PV}.tar.gz
	https://android.googlesource.com/platform/system/core/+archive/android-${ANDROID_VERSION}_r${ANDROID_REVISION}/include.tar.gz -> android-system-core-include-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}/Makefile" "${S}"
}
