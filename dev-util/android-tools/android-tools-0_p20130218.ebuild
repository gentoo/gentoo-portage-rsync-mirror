# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/android-tools/android-tools-0_p20130218.ebuild,v 1.1 2014/09/30 21:39:15 zmedico Exp $

EAPI=5
inherit eutils

KEYWORDS="~amd64 ~x86 ~arm-linux ~x86-linux"
DESCRIPTION="Android platform tools (adb and fastboot)"
HOMEPAGE="https://android.googlesource.com/platform/system/core.git/"
MY_VERSION="${PV##*_p}"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/android-tools_4.2.2+git${MY_VERSION}.orig.tar.xz
https://launchpad.net/ubuntu/+archive/primary/+files/android-tools_4.2.2+git${MY_VERSION}-3ubuntu36.debian.tar.gz
https://github.com/android/platform_system_core/commit/e89e09dd2b9b42184973e3ade291186a2737bced.patch -> ${PN}-e89e09dd2b9b42184973e3ade291186a2737bced.patch"
# The entire source code is Apache-2.0, except for fastboot which is BSD.
LICENSE="Apache-2.0 BSD"
SLOT="0"
IUSE=""

RDEPEND="sys-libs/zlib:=
	dev-libs/openssl:0="

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	# Apply patch for bug #500480.
	pushd core || die
	epatch "${DISTDIR}"/${PN}-e89e09dd2b9b42184973e3ade291186a2737bced.patch
	popd
	epatch ../debian/patches/*.patch
	mv ../debian/makefiles/adb.mk core/adb/Makefile || die
	mv ../debian/makefiles/fastboot.mk core/fastboot/Makefile || die

	# Avoid libselinux dependency.
	sed -e 's: -lselinux::' -i core/fastboot/Makefile || die
	sed -e '/#include <selinux\/selinux.h>/d' \
		-e 's:#include <selinux/label.h>:struct selabel_handle;:' \
		-i extras/ext4_utils/make_ext4fs.h || die
	sed -e '62,63d;180,189d;231,234d;272,274d;564,579d' \
		-i extras/ext4_utils/make_ext4fs.c || die
}

src_compile() {
	pushd core/adb || die
	emake adb || die
	popd
	pushd core/fastboot || die
	emake fastboot || die
}

src_install() {
	exeinto /usr/bin
	doexe core/adb/adb
	doexe core/fastboot/fastboot
}
