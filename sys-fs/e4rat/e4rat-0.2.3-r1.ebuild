# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/e4rat/e4rat-0.2.3-r1.ebuild,v 1.4 2013/01/13 11:21:31 ago Exp $

EAPI=4

inherit cmake-utils linux-info

DESCRIPTION="Toolset to accelerate the boot process and application startup"
HOMEPAGE="http://e4rat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-libs/boost-1.42
	sys-fs/e2fsprogs
	sys-process/audit
	sys-process/lsof"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~AUDITSYSCALL"

PATCHES=(
	"${FILESDIR}"/${PN}-0.2.2-shared-build.patch
	"${FILESDIR}"/${PN}-0.2.2-libdir.patch
	"${FILESDIR}"/${P}-boostfsv3.patch
)

pkg_setup() {
	check_extra_config
}

src_install() {
	cmake-utils_src_install
	# relocate binaries to /sbin. If someone knows of a better way to do it
	# please do tell me
	dodir sbin
	find "${D}"/usr/sbin -type f -exec mv {} "${D}"/sbin/. \; \
		|| die
}

pkg_postinst() {
	elog
	elog "Please consult the upstream wiki if you need help"
	elog "configuring your system"
	elog "http://e4rat.sourceforge.net/wiki/index.php/Main_Page"
	elog
	if has_version sys-apps/preload; then
		elog "It appears you have sys-apps/preload installed. This may"
		elog "has negative effects on ${PN}. You may want to disable preload"
		elog "when using ${PN}."
		elog "http://e4rat.sourceforge.net/wiki/index.php/Main_Page#Debian.2FUbuntu"
	fi
}
