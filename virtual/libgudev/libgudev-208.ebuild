# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libgudev/libgudev-208.ebuild,v 1.5 2014/06/02 13:33:34 ssuominen Exp $

EAPI=5
inherit multilib-build

DESCRIPTION="Virtual for libgudev providers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0/0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86"
IUSE="introspection static-libs"

DEPEND=""
RDEPEND="
	|| (
		>=sys-fs/udev-208-r1:0/0[${MULTILIB_USEDEP},gudev,introspection?,static-libs?]
		>=sys-apps/systemd-208:0/2[${MULTILIB_USEDEP},gudev,introspection?,static-libs(-)?]
		>=sys-apps/systemd-208:0/1[${MULTILIB_USEDEP},gudev,introspection?,static-libs(-)?]
		>=sys-apps/systemd-208:0/0[${MULTILIB_USEDEP},gudev,introspection?,static-libs(-)?]
		>=sys-fs/eudev-1.5.3-r1:0/0[${MULTILIB_USEDEP},gudev,introspection?,static-libs?]
	)"
