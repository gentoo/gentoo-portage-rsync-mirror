# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/raspberrypi-sources/raspberrypi-sources-9999.3.8.ebuild,v 1.1 2013/07/19 14:33:47 xmw Exp $

EAPI=5

ETYPE=sources
K_DEFCONFIG="bcmrpi_cutdown_defconfig"
K_SECURITY_UNSUPPORTED=1
EXTRAVERSION="-${PN}/-*"
inherit kernel-2
detect_version
detect_arch

inherit git-2 versionator
EGIT_REPO_URI=https://github.com/raspberrypi/linux.git
EGIT_PROJECT="raspberrypi-linux.git"
EGIT_BRANCH="rpi-$(get_version_component_range 2-3).y"

DESCRIPTION="Raspberry PI kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"

KEYWORDS=""

src_unpack() {
	git-2_src_unpack
	unpack_set_extraversion
}
