# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-studio/android-studio-0.5.9.135.1195882.ebuild,v 1.1 2014/06/01 21:21:27 tomwij Exp $

EAPI=5
inherit eutils versionator

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"
STUDIO_V=$(get_version_component_range 1-3)
BUILD_V=$(get_version_component_range 4-5)
DESCRIPTION="A new Android development environment based on IntelliJ IDEA"
HOMEPAGE="http://developer.android.com/sdk/installing/studio.html"
SRC_URI="http://dl.google.com/dl/android/studio/ide-zips/${STUDIO_V}/${PN}-ide-${BUILD_V}-linux.zip"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.6"
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
