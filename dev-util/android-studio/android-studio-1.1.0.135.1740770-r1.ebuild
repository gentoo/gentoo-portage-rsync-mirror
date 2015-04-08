# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-studio/android-studio-1.1.0.135.1740770-r1.ebuild,v 1.1 2015/03/24 09:49:28 perfinion Exp $

EAPI=5
inherit eutils versionator

RESTRICT="strip"
QA_PREBUILT="opt/${PN}/bin/libbreakgen.so"
STUDIO_V=$(get_version_component_range 1-3)
BUILD_V=$(get_version_component_range 4-5)
if [[ $(get_version_component_count) -gt 5 ]]; then
	STUDIO_V="${STUDIO_V}-$(get_version_component_range 6-)"
fi

DESCRIPTION="A new Android development environment based on IntelliJ IDEA"
HOMEPAGE="http://developer.android.com/sdk/installing/studio.html"
SRC_URI="http://dl.google.com/dl/android/studio/ide-zips/${STUDIO_V}/${PN}-ide-${BUILD_V}-linux.zip"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="selinux"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.7
	selinux? ( sec-policy/selinux-android )
	>=app-arch/bzip2-1.0.6-r4[abi_x86_32(-)]
	>=dev-libs/expat-2.1.0-r3[abi_x86_32(-)]
	>=dev-libs/libffi-3.0.13-r1[abi_x86_32(-)]
	>=media-libs/fontconfig-2.10.92[abi_x86_32(-)]
	>=media-libs/freetype-2.5.5[abi_x86_32(-)]
	>=media-libs/libpng-1.2.51[abi_x86_32(-)]
	>=media-libs/mesa-10.2.8[abi_x86_32(-)]
	>=sys-libs/ncurses-5.9-r3[abi_x86_32(-)]
	>=sys-libs/zlib-1.2.8-r1[abi_x86_32(-)]
	>=x11-libs/libX11-1.6.2[abi_x86_32(-)]
	>=x11-libs/libXau-1.0.7-r1[abi_x86_32(-)]
	>=x11-libs/libXdamage-1.1.4-r1[abi_x86_32(-)]
	>=x11-libs/libXdmcp-1.1.1-r1[abi_x86_32(-)]
	>=x11-libs/libXext-1.3.2[abi_x86_32(-)]
	>=x11-libs/libXfixes-5.0.1[abi_x86_32(-)]
	>=x11-libs/libXrender-0.9.8[abi_x86_32(-)]
	>=x11-libs/libXxf86vm-1.1.3[abi_x86_32(-)]
	>=x11-libs/libdrm-2.4.46[abi_x86_32(-)]
	>=x11-libs/libxcb-1.9.1[abi_x86_32(-)]
	>=x11-libs/libxshmfence-1.1[abi_x86_32(-)]"
S=${WORKDIR}/${PN}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/studio.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"

	newicon "bin/idea.png" "${PN}.png"
	make_wrapper ${PN} ${dir}/bin/studio.sh
	make_desktop_entry ${PN} "Android Studio" ${PN} "Development;IDE"
}
